#!/bin/sh

# Adapter les noms d'interfaces selon GNS3 (souvent eth0, eth1...)

# Mettre les interfaces up
ip link set eth0 up
ip link set eth1 up

# Créer le bridge
ip link add br0 type bridge
ip link set br0 up

# Créer l'interface VXLAN (exemple en mode static)
ip link add vxlan10 type vxlan id 10 dev eth0 remote <IP_AUTRE_SWITCH> dstport 4789
ip link set vxlan10 up

# Attacher eth1 et vxlan10 au bridge
ip link set eth1 master br0
ip link set vxlan10 master br0

# Donner une IP au bridge si besoin
ip addr add 10.1.1.2/24 dev br0

echo "VXLAN et bridge configurés !"