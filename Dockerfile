# Alpha build: OpenRTMP/librtmp2-server
# This branch builds the Rust-based librtmp2-server instead of nginx-rtmp.

FROM rust:latest AS builder

ARG LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git
ARG LIBRTMP2_SERVER_REF=main

WORKDIR /build

RUN git clone --depth 1 --branch "${LIBRTMP2_SERVER_REF}" "${LIBRTMP2_SERVER_REPO}" . && \
    cargo build --release

FROM alexanderwagnerdev/alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add --no-cache libgcc wget ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /build/target/release/librtmp2-server /usr/local/bin/librtmp2-server
COPY --from=builder /build/config.example.env /etc/librtmp2-server/config.env

RUN adduser -D -H -s /sbin/nologin openrtmp && \
    mkdir -p /data /etc/librtmp2-server && \
    chown -R openrtmp:openrtmp /data /etc/librtmp2-server

ENV LRTMP2_DB=/data/server.db

USER openrtmp

EXPOSE 1935/tcp 8080/tcp

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1:8080/api/v1/health || exit 1

ENTRYPOINT ["librtmp2-server"]
CMD ["-c", "/etc/librtmp2-server/config.env"]
