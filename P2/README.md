# P2


mot cle pour le readme -> VXLAN -> VTEP

HOST1 ── R1(VTEP) ── SWITCH (underlay L2) ── R2(VTEP) ── HOST2

📦 CE QUI SE PASSE VRAIMENT (packet flow)
1️⃣ Host1 → Router1

Ethernet classique (L2)

2️⃣ Router1 (VTEP)

encapsule la trame Ethernet

dans UDP/IP (VXLAN)

3️⃣ Switch

voit juste un paquet IP

le forward comme un bourrin L2

aucune intelligence VXLAN

4️⃣ Router2 (VTEP)

reçoit UDP 4789

décapsule

recrée la trame Ethernet

5️⃣ Host2

croit être sur le même LAN

PHRASE PARFAITE POUR L’ÉVALUATION (celle qui fait mouche)

“Dans cette topologie, le switch central ne fait que transporter le réseau underlay. Les routeurs agissent comme VTEP VXLAN, encapsulant et décapsulant le trafic Ethernet afin d’étendre un réseau L2 au-dessus du réseau IP.”

✅ RÉSUMÉ FINAL (ULTRA CLAIR)

✔️ Le switch est un vrai switch LAN

✔️ Il est sous le VXLAN, pas dedans

✔️ Le VXLAN est sur les routeurs

❌ Le switch ne fait aucune encapsulation

❌ Il ne “comprend” pas VXLAN

❌ “En direct” (sans encapsulation) : les limites

Si tu relies tout “en direct” en L2 :

1️⃣ Ça ne traverse pas le monde

L2 ne traverse pas Internet

pas de broadcast à grande distance

pas de MAC à l’échelle mondiale

👉 Japon ↔ USA impossible en L2 pur

2️⃣ Ça ne scale pas

Broadcast ARP partout

MAC tables énormes

tempêtes réseau

👉 Très vite instable

3️⃣ Tu es prisonnier de la topologie

changer de site = changer d’IP

déplacer une VM = casse réseau

✅ Encapsulation (VXLAN) : ce que ça apporte
1️⃣ Ça traverse n’importe quel réseau IP

Internet

MPLS

VPN

backbone cloud

👉 Du moment qu’il y a IP → VXLAN passe

2️⃣ Scalabilité énorme

VLAN = 4096

VXLAN = 16 millions de réseaux

👉 Multi-tenant, cloud, DC géants

3️⃣ Isolation & sécurité

segmentation logique

isolation par VNI

facile à filtrer (UDP 4789)

4️⃣ Transparence pour les machines

mêmes IP

mêmes MAC

même L2

👉 Zéro reconfig côté host

ip link add br0 type bridge

Ce que ça fait :
Crée un bridge Linux br0. Un bridge = un switch L2 logiciel.

Pourquoi :
Tu as deux mondes à “mettre ensemble” au niveau L2 :

    le LAN local (eth1 ↔ host1)

    le LAN distant via VXLAN (vxlan10 ↔ routeur2)

Le bridge est la colle L2 qui fait :

    “Tout ce qui arrive de eth1 peut ressortir vers vxlan10, et inversement”, en se basant sur les MAC (table de forwarding comme un switch).



3) Créer l’interface VXLAN (le tunnel)
ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789


Je découpe les paramètres :

name vxlan10 : nom de l’interface virtuelle créée

type vxlan : on crée une interface VXLAN

id 10 : VNI (VXLAN Network Identifier). C’est “le VLAN mais en version VXLAN”.
👉 Tous les endpoints qui partagent id 10 sont dans le même LAN virtuel.

dev eth0 : l’interface physique qui transporte les paquets VXLAN (UDP/IP sort par eth0)

local 10.1.1.1 : IP source (Router1 underlay)

remote 10.1.1.2 : IP destination (Router2 underlay)

dstport 4789 : port UDP standard VXLAN

Pourquoi on fait ça :
Parce que sans cette interface, Linux n’a rien qui représente :

“le câble virtuel Ethernet vers le site distant”.

vxlan10 devient justement ce “câble”.


6) Mettre eth1 dans le bridge (accrocher le LAN local)
ip link set dev eth1 master br0


Ce que ça fait :
“Branche” eth1 dans le switch logiciel br0.

Pourquoi :

eth1 est le port qui va vers host1

donc tu veux que host1 fasse partie du “LAN virtuel étendu”

Une fois eth1 dans br0 :

les trames venant de host1 entrent dans br0

br0 décide si ça doit partir :

vers eth1 (local) ou

vers vxlan10 (distant)