FROM alpine

ENV TERRAFORM_VERSION=0.12.12

#Install Terraform
RUN apk --update add curl jq python bash ca-certificates git openssl unzip wget && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin

#Install Git
RUN apk --update add git less openssh

#Install gcloud-cli
RUN curl -sSL https://sdk.cloud.google.com >> install_gcloud.sh && \
    bash install_gcloud.sh --disable-prompts --install-dir=/usr/local/gcloud && \
    rm install_gcloud.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

#Clear caches
RUN apk add --no-cache go && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*