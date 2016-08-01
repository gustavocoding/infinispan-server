#!/bin/bash

IP=$(ip addr list eth0 |grep "inet " |cut -d' ' -f6|cut -d/ -f1)
echo "Bug fixed"
exec /opt/jboss/infinispan-server/bin/standalone.sh -c clustered.xml -Djgroups.join_timeout=1000 -Djgroups.bind_addr=$IP -Djboss.bind.address=$IP "$@"
