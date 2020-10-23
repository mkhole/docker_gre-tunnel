FROM alpine:3.8
MAINTAINER Jeff_Shiu

RUN apk add iproute2

COPY start.sh /start.sh
RUN chmod 755 /start.sh

ENTRYPOINT ["/start.sh"]

CMD ["tail", "-f", "/dev/null"]
