FROM --platform=linux/amd64 python:3.9.19-alpine

# Install dependencies and Vault CLI
ENV VAULT_VERSION=1.18.3
RUN apk update && \
  apk add --no-cache curl wget jq openssl openssl-dev bash && \
#   wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
#   unzip vault_${VAULT_VERSION}_linux_amd64.zip && \
#   mv vault /usr/local/bin/ && \
#   rm vault_${VAULT_VERSION}_linux_amd64.zip && \
  rm -rf /var/cache/apk/*

# Download and install Google Cloud SDK
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz -o /tmp/google-cloud-sdk.tar.gz && \
  mkdir -p /usr/local/gcloud && \
  tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz && \
  /usr/local/gcloud/google-cloud-sdk/install.sh --quiet && \
  rm /tmp/google-cloud-sdk.tar.gz

# Install BigQuery CLI
RUN gcloud components install bq --quiet
