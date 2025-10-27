#!/bin/sh
crond -f -l 2 &
exec /usr/local/nginx/sbin/nginx -g 'daemon off;'
