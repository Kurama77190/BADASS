# VXLAN & static et dynamic multicast


> **_WARNING_**: _Avant de poursuivre la suite nous devons voir quelque notion importante avant la suite du projet_

### VXLAN qu'est ce que sait ?
Le **VXLAN** (Virtual Extensible LAN) est une technologie de virtualisation réseau qui vise à résoudre des problèmes d'évolutivité associés au déploiement du cloud computing. Il utilise une technique d'encapsulation proche du **VLAN** et permet d’encapsuler des trames Ethernet de couche 2 OSI dans des datagrammes **UDP** de couche 4. Le numéro de **port UDP** de destination par défaut attribué par l’IANA **pour le VXLAN est le 4789**.
Les paramètres VXLAN, qui cloisonnent les VXLAN et peuvent être des switchs virtuels ou physiques, sont aussi connus sous le terme VTEP (VXLAN Tunnel Endpoints)

### Bridge qu'est ce que sait ?
Un **Bridge** (pont) est un équipement informatique d'infrastructure de réseaux de type passerelle[1]. Dans les réseaux Ethernet, il intervient en couche 2 du modèle OSI (liaison). Son objectif est d'interconnecter deux segments de réseaux distincts, soit de technologies différentes, soit de même technologie, mais physiquement séparés à la conception pour diverses raisons (géographique, extension de site etc.).
Son usage le rapproche fortement de celui d'un commutateur (switch), à l'unique différence que le commutateur ne convertit pas les formats de transmissions de données. Le pont ne doit pas être confondu avec le routeur.

### Les couches OSI qu'est ce que sait ?

Le modèle OSI (Open Systems Interconnection) est une norme de communication de tous les systèmes informatiques en réseau. C'est un modèle de communications entre ordinateurs proposé par l'ISO (Organisation internationale de normalisation) qui décrit les fonctionnalités nécessaires à la communication et l'organisation de ces fonctions.
![alt text](/images/OSI_Model_v1.svg.png)

### Static et dynamic multicast qu'est ce que sait ?

Le **MULTICAST** est une forme de diffusion d'un émetteur (source unique) vers un groupe de récepteurs. Les termes « diffusion multipoint » ou « diffusion de groupe » sont également employés.




**L'UNICAST** définit une connexion réseau point à point, c'est-à-dire d'un hôte vers un (seul) autre hôte. Elle peut également être traduite en envoi individuel ou parfois diffusion individuelle. 

**TYPE DE ROUTAGE:**

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="text-align: center;">
    <div><b>Cast</b></div>
    <img src="../images/Cast.png" alt="Image 1" width="300"/>
  </div>
  <div style="text-align: center;">
    <div><b>Anycast</b></div>
    <img src="../images/Anycast.png" alt="Image 2" width="300"/>
  </div>
  <div style="text-align: center;">
    <div><b>Broadcast</b></div>
    <img src="../images/Broadcast.png" alt="Image 3" width="300"/>
  </div>
  <div style="text-align: center;">
    <div><b>Unicast</b></div>
    <img src="../images/Unicast.png" alt="Image 4" width="300"/>
  </div>
    <div style="text-align: center;">
    <div><b>Multicast</b></div>
    <img src="../images/Multicast.png" alt="Image 5" width="300"/>
  </div>
    <div style="text-align: center;">
    <div><b>Geocast</b></div>
    <img src="../images/Geocast.png" alt="Image 6" width="300"/>
  </div>
</div>

### Topologie de notre reseau VXLAN

![alt text](../images/Topologie%20VXLAN.png)

### Premiere Etape