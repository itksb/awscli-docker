FROM docker:stable
MAINTAINER vc@itksb.com

RUN apk add --no-cache \
     git \
     openssh \
     bash \
     py-pip \
     && pip install awscli --upgrade --user \
     && rm -rf /var/cache/apk/*