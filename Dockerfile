FROM node:16 AS builder

RUN git clone -b main https://github.com/AegirTech/IberiaEye.git && \
    cd IberiaEye && \
    npm i -g npm && npm i -g pnpm && \
    pnpm install && \
    sed -i "s#baseURL: '.*/'#baseURL: 'http://127.0.0.1:2000/'#g" /IberiaEye/nuxt.config.js
RUN cd IberiaEye && pnpm run build

FROM --platform=$TARGETPLATFORM nginx:alpine

ENV URL=http://127.0.0.1:2000/

COPY --from=builder /IberiaEye/dist/ /dist
COPY default.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.sh /

RUN apk update && apk upgrade -U -a && \
    echo "Asia/Shanghai" > /etc/timezone && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

EXPOSE 8000