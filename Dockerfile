	FROM jenkins/jnlp-slave:3.29-1-alpine

	USER root

	ENV KUBE_LATEST_VERSION="v1.15.0"
	ENV KUSTOMIZE_VERSION="2.1.0"

	RUN apk add --update git docker python py-pip ca-certificates \
	&& apk add --update -t deps curl \
	&& curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
	&& curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
	&& chmod +x /usr/local/bin/kubectl \
	&& chmod +x /usr/local/bin/kustomize \
	&& apk del --purge deps \
	&& rm /var/cache/apk/*
