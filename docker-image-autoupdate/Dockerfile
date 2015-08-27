FROM google/nodejs
MAINTAINER Santiago Saavedra <ssaavedra@vacmatch.com>

RUN apt-get update && apt-get install -y openssh-client && rm -rf /var/lib/apt/lists/*
RUN npm install -g coffee-script
ENV CLONE_URL https://github.com/vacmatch/botito.git
ADD clone.sh /

EXPOSE 8080

ENTRYPOINT ["bash", "/clone.sh"]
