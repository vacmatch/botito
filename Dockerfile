FROM google/nodejs-runtime
MAINTAINER Santiago Saavedra <ssaavedra@vacmatch.com>

RUN npm install -g coffee-script

ENTRYPOINT ["/app/node_modules/.bin/hubot"]

