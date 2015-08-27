FROM google/nodejs-runtime
MAINTAINER Santiago Saavedra <ssaavedra@vacmatch.com>

RUN npm install -g coffee-script

EXPOSE 8080

ENTRYPOINT ["/app/node_modules/.bin/hubot"]

