#!/bin/bash

if [ ! -d /app ]; then
	git clone "${CLONE_URL}" /app
fi

cd /app

# If we are not yet inside this script
if [ "x${INCEPTION}" = "x" ]; then
	INCEPTION=yes
	# If there is a new one cloned
	if [ -f /app/clone.sh ]; then
		# Prefer the downloaded one
		exec bash /app/clone.sh
	fi
fi

git pull && \
	echo -n "Fetched botito rev. " && \
	git rev-parse --short HEAD && \
	npm install && \
	echo "Modules installed. Botito warming up..." && \
	exec node_modules/.bin/hubot $@

