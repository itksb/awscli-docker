# awscli-docker

This is the Git repo of the Docker image for Gitlab runner jobs related with awscli.

It is based on the official _docker:stable_ image and includes following packages:

    - git
    - openssh
    - bash
    - py-pip 
    
## Usage Example

`cat .gitlab-ci.yml`:

```build_app:
  image: itksb/awscli-docker
  stage: build_app
  services:
    - docker:dind

  variables:
    CMD: ""
    DOCKER_HOST: tcp://docker:2375/
    DOCKER_DRIVER: overlay2
    VERSION: 1.1.1

  before_script:
    - CMD=$(/root/.local/bin/aws ecr get-login --no-include-email --region ap-southeast-1)
    - eval $CMD
    - mkdir -p /root/.ssh && cp ${SSH_DEPLOY_SCRIPTS_KEY_FILE} /root/.ssh/id_rsa && chmod 400 /root/.ssh/id_rsa
    - echo "StrictHostKeyChecking no " > /root/.ssh/config
    - git clone git@gitlab.com:itksb/repository_name.git CICD

  script:
    - cd CICD && ./make.sh -o
    - docker push image_name

  when: manual
  ```