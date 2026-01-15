#!/usr/bin/env bash
set -e

DOC_ROOT="/var/www/html"

# Generate nginx.conf dynamically using DOMAIN_NAME from the env
cat > /etc/nginx/nginx.conf <<EOF
user www-data;
worker_processes auto;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    sendfile on;
    keepalive_timeout 65;

    server {
        listen 443 ssl;
        server_name ${DOMAIN_NAME} www.${DOMAIN_NAME};

        ssl_certificate /etc/nginx/cert.pem;
        ssl_certificate_key /etc/nginx/key.pem;
        ssl_protocols TLSv1.2 TLSv1.3;

        root ${DOC_ROOT};
        index index.php index.html;

        location / {
            try_files \$uri \$uri/ /index.php?\$args;
        }

        location ~ \.php\$ {
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
            fastcgi_pass wordpress:9000;
        }
    }
}
EOF

echo "Nginx configuration generated successfully."

# Ensure the document root exists
mkdir -p ${DOC_ROOT}

# Start Nginx in foreground
exec nginx -g "daemon off;"
