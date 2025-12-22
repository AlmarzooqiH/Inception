#!/bin/bash

set -e

wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz


php-fpm8.2 -F