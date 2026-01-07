#!/usr/bin/env bash
set -e

rm -f /etc/nginx/nginx.conf

mv ./conf/nginx.conf /etc/nginx/

nginx -g 'daemon off;'
