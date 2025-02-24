#!/bin/sh
echo "${GEMMA2_USERNAME}:$(openssl passwd -apr1 ${GEMMA2_PASSWORD})" > /etc/nginx/.htpasswd
exec nginx -g 'daemon off;'