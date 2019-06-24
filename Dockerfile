	FROM jenkins/jnlp-slave:latest

	USER root
	RUN apt-get update \
	&& apt-get install --no-install-recommends -y python build-essential python-pip python-colorama \
	&& pip install --upgrade setuptools  \
	&& pip install aws-shell \
	&& curl -sSL https://get.docker.com/ | sh \
	&& pip install docker \
	&& pip install awscli --upgrade \
	&& apt-get purge -y python-pip \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

	WORKDIR /
