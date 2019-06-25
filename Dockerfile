	# FROM jenkins/jnlp-slave:latest
	FROM jenkinsci/jnlp-slave

	ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
	ENV PATH /opt/google-cloud-sdk/bin:$PATH

	USER root
	RUN apt-get install --no-install-recommends -y python build-essential python-pip python-colorama dnsutils \
	&& pip install --upgrade setuptools  \
	&& curl -sSL https://get.docker.com/ | sh \
	&& pip install docker \
	&& apt-get purge -y python-pip \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

	# Install google-cloud-sdk
	RUN apt-get update -y && \
	apt-get install -y jq git make && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/*

	RUN curl https://sdk.cloud.google.com | bash && mv google-cloud-sdk /opt
	RUN gcloud components install kubectl

	# Install Helm
	RUN wget http://storage.googleapis.com/kubernetes-helm/helm-v2.5.0-linux-amd64.tar.gz -P /tmp
	RUN tar -zxvf /tmp/helm-v2.5.0-linux-amd64.tar.gz -C /tmp && mv /tmp/linux-amd64/helm /bin/helm && rm -rf /tmp
