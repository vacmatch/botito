#!/bin/bash

if [ ! -d /app ]; then
	git clone "${CLONE_URL}" /app
fi

cd /app

# If we are not yet inside this script
if [ "x${_INCEPTION}" = "x" ]; then
	export _INCEPTION=yes
	# If there is a new one cloned
	if [ -f /app/docker-image-autoupdate/clone.sh ]; then
		# Prefer the downloaded one
		exec bash /app/docker-image-autoupdate/clone.sh $@
	fi
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
	cat /dev/zero | ssh-keygen -t rsa -b 2048 -N ""
	echo "Please ensure you have the following key in gerrit: "
	cat ~/.ssh/id_rsa.pub
fi

if [ ! -f ~/.ssh/known_hosts ]; then
	cat >~/.ssh/known_hosts <<EOF
|1|0l6RzgASI9iAMkwY8ZQKsRQw88U=|87qJ+tHQr2+0esbEB5JGDOVdLCg= ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCJy+03h9EVtECremT4ZWJ68TcELJdhY7PW0iP6euHzF5vVscGhpzLg97vGTHH1c95PC1zQnjv+wzohH/rtFecNMCaZ11Q4kNAm96VJEgux7x+guaSKazRlH7x/qf9DPPvh+Wd3KPjI0/FtYN9spMq76SWD6dRJgm/g4v9pSFLtXQ==
|1|mNfGDqb0EWCtgI3V7RNSi9h8i6M=|38Wigd2YC1NzjvPOrNqpzeao6T4= ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCJy+03h9EVtECremT4ZWJ68TcELJdhY7PW0iP6euHzF5vVscGhpzLg97vGTHH1c95PC1zQnjv+wzohH/rtFecNMCaZ11Q4kNAm96VJEgux7x+guaSKazRlH7x/qf9DPPvh+Wd3KPjI0/FtYN9spMq76SWD6dRJgm/g4v9pSFLtXQ==
EOF
fi

if [ ! -f ~/.ssh/config ]; then
	cat >~/.ssh/config <<EOF
Host *
User botito
AddressFamily inet
EOF

fi
if [ "x${REDIS_PORT}" != "x" ]; then
	echo "Using Redis brain at ${REDIS_PORT}"
	export REDIS_URL="${REDIS_PORT}"
else
	echo "Redis brain not found"
	env
fi

git pull && \
	echo -n "Fetched botito rev. " && \
	git rev-parse --short HEAD && \
	npm install && \
	echo "Modules installed. Botito warming up..." && \
	exec node_modules/.bin/hubot $@

