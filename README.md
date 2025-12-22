# 🚀 BADASS - BGP At Datacenter And Scale Simulation

> **Projet 42** - Simulation d'architectures réseau datacenter avec GNS3, Docker et FRRouting

![Network](https://img.shields.io/badge/Network-VXLAN%20%7C%20BGP%20%7C%20EVPN-blue)
![Tools](https://img.shields.io/badge/Tools-GNS3%20%7C%20Docker%20%7C%20FRRouting-green)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

## 📋 Description

**BADASS** est un projet de simulation réseau avancée qui explore les technologies modernes utilisées dans les datacenters. À travers trois parties progressives, nous construisons une infrastructure réseau complète utilisant **VXLAN**, **BGP**, **EVPN** et l'architecture **Leaf-Spine**.

---

## 🏗️ Architecture du Projet

```
BADASS/
├── P1/          # Découverte GNS3 & Docker
├── P2/          # VXLAN Unicast & Multicast
├── P3/          # VXLAN-EVPN Leaf-Spine
└── images/      # Ressources & Diagrammes
```

---

## 📚 Les 3 Parties

### 🔹 P1 - Découverte GNS3 & Docker

Introduction à l'environnement de simulation réseau.

| Composant | Description |
|-----------|-------------|
| **GNS3** | Simulateur réseau graphique |
| **Docker** | Conteneurisation des équipements |
| **FRRouting** | Suite de routage open-source |

**Objectifs :**
- Configuration de l'environnement GNS3
- Création d'images Docker personnalisées
- Premier routeur avec FRRouting

---

### 🔹 P2 - VXLAN Unicast & Multicast

Exploration de la technologie VXLAN pour l'extension L2 sur L3.

```
    ┌──────────┐                    ┌──────────┐
    │  Host 1  │                    │  Host 2  │
    │ 30.1.1.1 │                    │ 30.1.1.2 │
    └────┬─────┘                    └────┬─────┘
         │                               │
    ┌────┴─────┐    VXLAN Tunnel    ┌────┴─────┐
    │  VTEP 1  │◄──────────────────►│  VTEP 2  │
    │ 10.1.1.1 │     VNI 10         │ 10.1.1.2 │
    └──────────┘                    └──────────┘
```

**Technologies :**
- VXLAN (Virtual Extensible LAN)
- Unicast & Multicast modes
- Bridge Linux
- VNI (VXLAN Network Identifier)

---

### 🔹 P3 - VXLAN-EVPN Leaf-Spine

Architecture datacenter moderne avec plan de contrôle BGP EVPN.

```
                      ┌─────────────────┐
                      │   sben-tay-1    │
                      │  SPINE / RR     │
                      │  Lo: 1.1.1.1    │
                      └───────┬─────────┘
                              │
            ┌─────────────────┼─────────────────┐
            │                 │                 │
     ┌──────┴──────┐   ┌──────┴──────┐   ┌──────┴──────┐
     │ sben-tay-2  │   │ sben-tay-3  │   │ sben-tay-4  │
     │  LEAF/VTEP  │   │  LEAF/VTEP  │   │  LEAF/VTEP  │
     │ Lo: 1.1.1.2 │   │ Lo: 1.1.1.3 │   │ Lo: 1.1.1.4 │
     └──────┬──────┘   └──────┬──────┘   └──────┬──────┘
            │                 │                 │
       ┌────┴────┐       ┌────┴────┐       ┌────┴────┐
       │ Host 1  │       │ Host 2  │       │ Host 3  │
       │20.1.1.1 │       │20.1.1.2 │       │20.1.1.3 │
       └─────────┘       └─────────┘       └─────────┘
```

**Protocoles :**

| Couche | Protocole | Rôle |
|--------|-----------|------|
| **Underlay** | OSPF Area 0 | Routage IP entre équipements |
| **Control Plane** | BGP EVPN | Distribution des infos MAC/IP |
| **Overlay** | VXLAN VNI 10 | Tunnel L2 over L3 |

**Concepts clés :**
- Architecture Leaf-Spine
- BGP Route Reflector
- EVPN Type-2 & Type-3 routes
- advertise-all-vni

---

## 🛠️ Stack Technique

| Outil | Version | Usage |
|-------|---------|-------|
| **GNS3** | Latest | Simulation réseau |
| **Docker** | Latest | Conteneurs |
| **FRRouting** | Latest | BGP, OSPF, IS-IS |
| **Alpine Linux** | Latest | Hosts légers |

---

## 🚀 Quick Start

### 1. Build des images Docker

```bash
# Image routeur avec FRRouting
docker build -t router:latest -f P1/_sben-tay-1_router .

# Image host Alpine
docker build -t host:latest -f P1/_sben-tay-1_host .
```

### 2. Lancer GNS3

```bash
gns3 &
```

### 3. Importer les projets

Ouvrir les fichiers `.gns3project` dans chaque dossier P1, P2, P3.

---

## 📖 Documentation

Chaque partie contient un README détaillé :

- 📄 [P1/README.md](P1/README.md) - Setup GNS3 & Docker
- 📄 [P2/README.md](P2/README.md) - VXLAN Unicast/Multicast
- 📄 [P3/README.md](P3/README.md) - VXLAN-EVPN Leaf-Spine

---