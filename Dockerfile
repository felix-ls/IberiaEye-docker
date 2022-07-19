FROM --platform=$TARGETPLATFORM node AS builder

RUN git clone -b element-plus https://github.com/AegirTech/IberiaEye.git && \
    cd IberiaEye && \
    npm i -g npm && npm i

COPY start.sh /IberiaEye
RUN chmod +x /IberiaEye/start.sh

FROM --platform=$TARGETPLATFORM alpine

ENV URL=http://127.0.0.1:2000/

RUN apk update && apk upgrade -U -a && \
    apk add --no-cache npm && \
    npm config set registry https://registry.npm.taobao.org && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

COPY --from=builder /IberiaEye /IberiaEye

WORKDIR /IberiaEye

EXPOSE 3000

ENTRYPOINT ["/IberiaEye/start.sh"] 
