FROM alpine:latest AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache build-base pcre pcre-dev openssl openssl-dev wget git zlib-dev

RUN wget 'https://nginx.org/download/nginx-1.28.0.tar.gz' && \
    tar -zxvf nginx-1.28.0.tar.gz && \
    git clone https://github.com/arut/nginx-rtmp-module.git && \
    cd nginx-1.28.0 && \
    ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make && \
    make install

RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /nginx-1.28.0.tar.gz /nginx-1.28.0 /nginx-rtmp-module

FROM alpine:latest

RUN apk update && apk upgrade && \
    apk add --no-cache pcre openssl zlib

COPY --from=builder /usr/local/nginx /usr/local/nginx

RUN wget -O /usr/local/nginx/conf/nginx.conf https://raw.githubusercontent.com/AlexanderWagnerDev/rtmp-server-docker/main/nginx/conf/nginx.conf && \
    wget -O /usr/local/nginx/html/stat.xsl https://raw.githubusercontent.com/AlexanderWagnerDev/rtmp-server-docker/main/nginx/html/stat.xsl

EXPOSE 80/tcp 1935/tcp

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
