FROM --platform=$TARGETPLATFORM node AS builder

RUN git clone -b vant https://github.com/AegirTech/IberiaEye.git && \
    cd IberiaEye && \
    npm i -g npm && npm i

FROM --platform=$TARGETPLATFORM alpine

ENV URL=http://127.0.0.1:2000/

COPY --from=builder /IberiaEye /IberiaEye
COPY start.sh /IberiaEye
COPY .env.local /IberiaEye

WORKDIR /IberiaEye

RUN apk update && apk upgrade -U -a && \
    apk add --no-cache npm && \
    npm config set registry https://registry.npm.taobao.org && \
    echo "Asia/Shanghai" > /etc/timezone && \
    chmod +x /IberiaEye/start.sh && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* 

EXPOSE 5173

ENTRYPOINT ["/IberiaEye/start.sh"] 