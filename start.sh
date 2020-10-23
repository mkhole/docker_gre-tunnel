#!/bin/sh

if [ -z "$ENV_REMOTE_IP" ]; then
	echo "\$ENV_REMOTE_IP must be specified."
	exit 1
fi

if [ -z "$ENV_GRE_TUNNEL_IP" ]; then
	ENV_GRE_TUNNEL_IP=172.168.0.1/24
else
	if ! printf %s "${ENV_GRE_TUNNEL_IP}" | grep -Eq "^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\/[0-9]*$"; then
		ENV_GRE_TUNNEL_IP=${ENV_GRE_TUNNEL_IP}/24
	fi
fi

PRIVATE_IP=$(ip -4 route get 1 | awk -F' ' '/src/{ print $7 }')

if [ -z "$PRIVATE_IP" ]; then
	echo "Cannot find valid private IP. Aborting."
	exit 1
fi

case "$ENV_GRE_TYPE" in
	L2)
		GRE_TUNNEL_INTF="gretap1"
		ip link add $GRE_TUNNEL_INTF type gretap remote $ENV_REMOTE_IP local $PRIVATE_IP nopmtudisc
		;;
	L3)
		GRE_TUNNEL_INTF="tun0"
		ip tunnel add $GRE_TUNNEL_INTF mode gre remote $ENV_REMOTE_IP local $PRIVATE_IP ttl 255
		;;
	*)
		;;
esac

ip addr add $ENV_GRE_TUNNEL_IP dev $GRE_TUNNEL_INTF
ip link set $GRE_TUNNEL_INTF up

set -e
echo "Entry point"
exec "$@"
