FROM docker:20.10

LABEL maintainer="sobolevn@wemake.services"
LABEL vendor="wemake.services"

# Installing system deps:
RUN apk update && apk upgrade \
  && apk add --no-cache \
       # Installing Python:
       python3 python3-dev py3-pip \
       # Installing build deps:
       libffi-dev openssl-dev build-base git \
       # Installing Rust (latest cryptography requires it):
       cargo gcc musl-dev

WORKDIR /build
COPY requirements.txt /build/requirements.txt

# Installing Python dependencies:
RUN pip3 install -U pip \
  && pip3 install -r requirements.txt \
  && rm requirements.txt
