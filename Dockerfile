FROM python:3.6-alpine

ENV PYTHONUNBUFFERED 1

# Install Python dependencies
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories;
RUN apk -q update && \
    # Curl
    apk -q add --update curl curl-dev && \
    # OpenSSL
    apk -q --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main add openssl openssl-dev && \
    # PostgreSQL
    apk -q --no-cache add py-psycopg2 postgresql-dev && \
    # bash
    apk -q --no-cache add bash && \
    # Gevent
    apk -q --no-cache add libevent-dev && \
    # Pillow
    apk -q --no-cache add py-pip gcc musl-dev libjpeg-turbo-dev python-dev zlib-dev libffi-dev build-base jpeg-dev freetype-dev && \
    # Git
    apk -q --no-cache add git && \
    # Debugging
    apk -q --no-cache add nano htop postgresql-client && \
    # lxml
    apk -q --no-cache add libxslt-dev libxml2-dev

ENV LIBRARY_PATH /lib:/usr/lib:$LIBRARY_PATH  # Pillow

RUN pip install --upgrade pip
ADD requirements.txt .
RUN pip install -r requirements.txt && rm requirements.txt