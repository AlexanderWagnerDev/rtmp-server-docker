FROM alpine:latest AS builder

RUN apk update \
    && apk upgrade \
    && apk add --no-cache build-base pcre pcre-dev openssl openssl-dev wget git zlib-dev \
    && rm -rf /var/cache/apk/*

RUN wget 'https://nginx.org/download/nginx-1.28.0.tar.gz' && \
    tar -zxvf nginx-1.28.0.tar.gz && \
    git clone https://github.com/arut/nginx-rtmp-module.git && \
    cd nginx-1.28.0 && \
    ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make && \
    make install

RUN rm -rf /tmp/* /var/tmp/* /nginx-1.28.0.tar.gz /nginx-1.28.0 /nginx-rtmp-module

FROM alpine:latest

RUN apk update \
    && apk upgrade \
    && apk add --no-cache pcre openssl zlib \
    && rm -rf /var/cache/apk/*

COPY --from=builder /usr/local/nginx /usr/local/nginx
COPY nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY nginx/html/stat.xsl /usr/local/nginx/html/stat.xsl

EXPOSE 80/tcp 1935/tcp

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
