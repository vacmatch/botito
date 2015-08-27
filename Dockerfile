FROM google/nodejs-runtime
MAINTAINER Santiago Saavedra <ssaavedra@vacmatch.com>

ENTRYPOINT ["/app/node_modules/.bin/hubot"]

