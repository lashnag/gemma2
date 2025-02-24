#!/bin/sh

echo "${GEMMA2_USERNAME}:$(openssl passwd -apr1 ${GEMMA2_PASSWORD})" > /etc/nginx/.htpasswd

cat <<EOF > /etc/nginx/nginx.conf
server {
    listen ${GEMMA2_PORT};

    location / {
        proxy_pass http://ollama:11434;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        # Настройка базовой авторизации
        auth_basic "Restricted Area";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
}
EOF

nginx -g 'daemon off;'