#! /usr/bin/env bash

cat <<EOF > ~/.aws/config
[default]
region = us-east-1
output = json
EOF
