# BADASS

## What is GNS3 (Graphical Network Simulator 3)

C'est un **simulateur** de réseaux informatiques graphique et open-source.

- ##### À quoi ça sert ?
    > **Créer des topologies réseau virtuelles :** routeurs, switches, firewalls, serveurs
    Tester des configurations réseau sans matériel physique
    Apprendre les réseaux (Cisco, Juniper, etc.)
    Développer et debugger des architectures réseau complexes
- ##### Comment ça marche ?
    > **Interface graphique :** Tu glisses-déposes des équipements réseau
    **Connexions :** Tu relies les machines avec des câbles virtuels
    **Configuration :** Tu configures chaque équipement (IP, routage, protocoles)
    **Simulation :** Le réseau fonctionne comme s'il était réel
- ##### Technologies utilisées
    **GNS3 peut utiliser :**

    > **Docker :** pour les conteneurs Linux (ce que tu fais dans ton projet)
    **QEMU/KVM :** pour virtualiser des OS complets
    **VirtualBox/VMware :** pour des VM
    **Vrais équipements :** via des appliances virtuelles Cisco, Juniper, etc.

Tu utilises **GNS3** avec **Docker** pour :

- Créer des conteneurs réseau légers
- Simuler des routeurs avec FRRouting (BGPD, OSPFD, IS-IS)
- Tester VXLAN et BGP EVPN
- Sans avoir besoin de vrais serveurs !

**_En gros : GNS3 = laboratoire réseau virtuel sur ton PC !_**

## Tools Network

- ##### BGPD (Border Gateway Protocol Daemon)
    > Protocole de routage qui fait fonctionner Internet
    > Permet aux réseaux (AS - Autonomous Systems) de s'échanger des routes
    > Utilisé entre les grands opérateurs Internet
    > Dans ton projet : pour la partie P3 (BGP avec EVPN)

- ##### OSPFD (Open Shortest Path First Daemon)
    > Protocole de routage interne (IGP)
    > Calcule automatiquement les meilleures routes dans un réseau
    > Plus rapide que RIP, idéal pour les réseaux moyens/grands
    > Dans ton projet : pour simplifier le routage dans P3

- ##### IS-IS (Intermediate System to Intermediate System)
    > Autre protocole de routage interne (alternative à OSPF)
    > Utilisé dans les gros réseaux (opérateurs, datacenters)
    > Très stable et scalable
    > Dans ton projet : requis par le sujet pour l'image routeur

- ##### Zebra
    > Daemon de gestion du routage kernel (inclus dans FRRouting)
    Fait le lien entre les protocoles de routage (BGP, OSPF, IS-IS) et le kernel Linux
    Gère la table de routage du système
    Dans ton projet : activé automatiquement dans l'image routeur

- ##### busybox
    > Collection d'outils Unix minimalistes (ls, cp, ping, sh, etc.)
    Tout-en-un ultra léger (~2MB)
    Inclut un shell, outils réseau, système de fichiers
    Dans ton projet : pour les outils de base dans tes conteneurs Docker

### Docker Images install

- ##### Installer frrouting/frr:latest et setup routeur gns3
    > ``docker pull frrouting/frr`` - Pull en local
    > ``docker run -d frrouting/frr`` - Lancer le docker en local
    > ``docker exec -it $(name_frrouting) bash`` - Rentrer dans le docker
    > ``vi /etc/frr/daemons`` - Activer les composant que nous avons besoins
    > ``docker stop $(name_frrouting)`` - Stoper le docker
    > ``docker commit $(name_frrouting) gns3`` - Creer notre image pimper pour gns3 avec tous les composant de l'image setup.

*exemple de daemons configurer* :

```bash
    bgpd=yes
    ospfd=yes
    ospf6d=no
    ripd=no
    ripngd=no
    isisd=yes
    pimd=no
    pim6d=no
    ldpd=no
    nhrpd=no
    eigrpd=no
```

> _**INFO :**_ *frrouting* est une suite logicielle de routage open-source pour Linux/Unix. Les protocoles de routage inclus dans cette image sont *BGP, OSPF, IS-IS, RIP, PIM, LDP* et en composants principaux *Zebra, BGPD, OSPFD, ISISD*. Parfait pour creer notre **_routeur gns3_**

[...]