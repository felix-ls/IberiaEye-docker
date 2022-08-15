FROM --platform=$TARGETPLATFORM node AS builder

RUN git clone -b element-plus https://github.com/AegirTech/IberiaEye.git && \
    cd IberiaEye && \
    npm i -g npm && npm i && \
    sed -i "s#http:.*:2000/#http://127.0.0.1:2000/#g" /IberiaEye/src/http/index.ts && \
    npm run build

FROM --platform=$TARGETPLATFORM nginx:alpine

ENV URL=http://127.0.0.1:2000/

COPY --from=builder /IberiaEye/dist/ /dist
COPY default.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.sh /

RUN apk update && apk upgrade -U -a && \
    echo "Asia/Shanghai" > /etc/timezone && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

EXPOSE 80