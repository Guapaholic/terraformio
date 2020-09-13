FROM cimg/python:3.8-node AS build

ARG terraform_version="0.13.2"

RUN sudo apt-get update && sudo apt-get install -y \
  wget unzip

RUN pip3 install awscli --upgrade

RUN wget --quiet https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip

RUN unzip terraform_${terraform_version}_linux_amd64.zip \
  && sudo mv terraform /usr/bin \
  && rm terraform_${terraform_version}_linux_amd64.zip

RUN sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["sudo", "terraform"]
CMD ["init"]
