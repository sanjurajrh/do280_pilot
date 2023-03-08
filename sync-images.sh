
#!/bin/bash

# Copyright (c) 2023 Red Hat Training <training@redhat.com>
#
# Sync images in the DO280 offline registry

set -euo pipefail

export PATH="${HOME}/.local/bin:${PATH}"

IMAGES=$(cat << EOF
quay.io/jkube/jkube-java-binary-s2i:0.0.9
quay.io/openshift/origin-cli:4.12
quay.io/redhattraining/books:v1.4
quay.io/redhattraining/builds-for-managers
quay.io/redhattraining/do280-beeper-api:1.0
quay.io/redhattraining/do280-product-stock:1.0
quay.io/redhattraining/do280-product:1.0
quay.io/redhattraining/do280-project-cleaner:v1.0
quay.io/redhattraining/do280-show-config-app:1.0
quay.io/redhattraining/do280-stakater-reloader:v0.0.125
quay.io/redhattraining/exoplanets:v1.0
quay.io/redhattraining/famous-quotes:2.1
quay.io/redhattraining/famous-quotes:latest
quay.io/redhattraining/gitlab-ce:8.4.3-ce.0
quay.io/redhattraining/hello-world-nginx:latest
quay.io/redhattraining/hello-world-nginx:v1.0
quay.io/redhattraining/loadtest:v1.0
quay.io/redhattraining/php-hello-dockerfile
quay.io/redhattraining/php-ssl:v1.0
quay.io/redhattraining/php-ssl:v1.1
quay.io/redhattraining/scaling:v1.0
quay.io/redhattraining/todo-angular:v1.1
quay.io/redhattraining/todo-angular:v1.2
quay.io/redhattraining/todo-backend:release-46
quay.io/redhattraining/wordpress:5.7-php7.4-apache
registry.access.redhat.com/rhscl/httpd-24-rhel7:latest
registry.access.redhat.com/rhscl/mysql-57-rhel7:latest
registry.access.redhat.com/rhscl/nginx-18-rhel7:latest
registry.access.redhat.com/rhscl/nodejs-6-rhel7:latest
registry.access.redhat.com/rhscl/php-72-rhel7:latest
registry.access.redhat.com/ubi7/nginx-118:latest
registry.access.redhat.com/ubi8/httpd-24:latest
registry.access.redhat.com/ubi8/nginx-118:latest
registry.access.redhat.com/ubi8/nodejs-10:latest
registry.access.redhat.com/ubi8/nodejs-16:latest
registry.access.redhat.com/ubi8/php-72:latest
registry.access.redhat.com/ubi8/php-73:latest
registry.access.redhat.com/ubi8/ubi:8.0
registry.access.redhat.com/ubi8/ubi:8.4
registry.access.redhat.com/ubi8/ubi:latest
registry.access.redhat.com/ubi8:latest
registry.access.redhat.com/ubi9/httpd-24:latest
registry.access.redhat.com/ubi9/nginx-120:latest
registry.access.redhat.com/ubi9/ubi:latest
registry.redhat.io/redhat-openjdk-18/openjdk18-openshift:1.8
registry.redhat.io/redhat-openjdk-18/openjdk18-openshift:latest
registry.redhat.io/rhel8/mysql-80:1-211.1664898586
registry.redhat.io/rhel8/mysql-80:latest
registry.redhat.io/rhel8/postgresql-13:1-7
registry.redhat.io/rhel8/postgresql-13:latest
registry.redhat.io/ubi8/ubi:8.6-943
EOF
)

cat << EOF

Setting the DynoLabs log level to 'debug'

EOF

sed -i'' -e 's|error|debug|g' ~/.grading/config.yaml

cat << EOF

Waiting for the cluster to be ready

EOF

ssh lab@utility './wait.sh'

cat << EOF

Sync images for the offline registry
You will be asked for your credentials to access the following registries:

- quay.io
- registry.redhat.io
- registry.access.redhat.com

EOF

~/.venv/labs/bin/debug-lab-mirror-images ${IMAGES}
