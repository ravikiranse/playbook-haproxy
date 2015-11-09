#!/bin/bash

XAAS_VIP_IP=$1
XAAS_VIP_NIC=$2

echo "stop haproxy resource";
crm resource stop haproxy
sleep 5;

echo "delete haproxy resource";
crm configure delete haproxy;
sleep 5;

echo "stop virtual-ip resource";
crm resource stop virtual-ip
sleep 5;

echo "delete virtual-ip resource";
crm configure delete virtual-ip
sleep 5;

echo "prepare virtual-ip resource"

crm <<EOD
configure
primitive virtual-ip ocf:heartbeat:IPaddr2 params ip=$XAAS_VIP_IP nic=$XAAS_VIP_NIC op monitor interval=10s
verify
property stonith-enabled=false
property no-quorum-policy=ignore
verify
end
quit
EOD
