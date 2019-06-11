#!/usr/bin/env bash

docker build -t itksb/awscli-docker:latest .
docker push itksb/awscli-docker:latest