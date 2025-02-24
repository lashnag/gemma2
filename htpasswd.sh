#!/bin/sh
echo "${OLLAMA_USERNAME}:$(openssl passwd -apr1 ${OLLAMA_PASSWORD})" > /etc/nginx/.htpasswd
exec nginx -g 'daemon off;'