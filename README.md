# MongoDB Replica Set sur AWS — Infrastructure DevOps & Cloud Engineering

![RS](/images/RS.png)

## Présentation

Ce projet met en place une architecture complète de type **DevOps / Cloud Engineering** permettant le déploiement automatisé d’un cluster **MongoDB Replica Set (`rs0`)** sur AWS.

L’objectif est de construire une infrastructure :

- hautement disponible
- scalable
- automatisée
- reproductible
- conteneurisée
- basée sur l’Infrastructure as Code (IaC)

---

Ce projet est divisé en deux parties :

## Infrastructure Terraform
--> Voir le projet Terraform :  
[Terraform README](mongodb-iac/README.md)

---

## Configuration Ansible
--> Voir le projet Ansible :  
[Ansible README](mongodb-conf/README.md)

---

## Architecture globale

L’architecture repose sur :

- 3 instances **AWS EC2 Ubuntu**
- 1 conteneur **MongoDB par serveur**
- Un **Replica Set MongoDB (rs0)**
- Une communication de réplication entre les nœuds
- Une infrastructure entièrement automatisée

Chaque serveur joue un rôle dans le cluster afin d’assurer la continuité et la redondance des données.

---

## Infrastructure AWS

AWS héberge l’ensemble de l’environnement :

- Instances EC2 Ubuntu 22.04
- Réseau cloud pour la communication entre serveurs
- Hébergement des nœuds MongoDB

L’infrastructure est pensée pour être simple, évolutive et résiliente.

---

## Docker & Conteneurisation

MongoDB est exécuté dans des conteneurs Docker sur chaque machine.

Cela permet :

- standardisation des environnements
- portabilité des services
- isolation des bases de données
- simplification du déploiement

---

## MongoDB Replica Set (rs0)

Le Replica Set est composé de 3 nœuds :

- **mongo-1 → PRIMARY**
- **mongo-2 → SECONDARY**
- **mongo-3 → SECONDARY**

### Fonctionnement

- Le PRIMARY gère les écritures
- Les SECONDARY répliquent les données
- En cas de panne, un SECONDARY devient automatiquement PRIMARY

--> Cela garantit :
- haute disponibilité
- tolérance aux pannes
- cohérence des données

---

## Terraform (Infrastructure as Code)

Terraform est utilisé pour :

- provisionner les ressources AWS
- créer les instances EC2
- standardiser l’infrastructure
- versionner l’architecture

--> Toute l’infrastructure est reproductible à l’identique.

---

## Ansible (Automatisation)

Ansible automatise la configuration des serveurs :

- installation de Docker
- configuration des systèmes Ubuntu
- déploiement de MongoDB
- configuration du Replica Set

--> Cela garantit une configuration homogène sur tous les serveurs.

---

## Cycle DevOps du projet

Le workflow global suit ces étapes :

### 1. Développement
Le code est développé et versionné.

### 2. GitHub
Centralisation du code et collaboration.

### 3. Terraform
Création automatique de l’infrastructure AWS.

### 4. Ansible
Configuration automatique des serveurs.

### 5. Docker
Déploiement des conteneurs MongoDB.

### 6. MongoDB Replica Set
Formation du cluster rs0.

### 7. Validation
Vérification de la santé du cluster.

---

## Communication entre nœuds

Les nœuds MongoDB :

- communiquent en continu
- répliquent les données
- gèrent l’élection du PRIMARY
- assurent la cohérence du cluster

---

## Sécurité & bonnes pratiques

L’architecture respecte les principes DevOps :

- automatisation complète
- infrastructure reproductible
- séparation des responsabilités
- déploiement standardisé

Extensions possibles :

- authentification MongoDB
- TLS/SSL
- monitoring (Prometheus / Grafana)
- CI/CD pipeline
- gestion des secrets

---

## Avantages

- Haute disponibilité
- Scalabilité
- Résilience
- Automatisation complète
- Infrastructure as Code
- Déploiement reproductible

---

## Stack technologique

- AWS (EC2)
- Ubuntu Server
- Docker
- MongoDB 6.x
- Replica Set
- Terraform
- Ansible
- Git / GitHub

---

## Objectif

Ce projet démontre une architecture DevOps complète permettant de :

- déployer une base de données distribuée
- automatiser toute l’infrastructure
- garantir haute disponibilité et résilience
- appliquer les bonnes pratiques Cloud & DevOps

---

## Licence

Projet éducatif et portfolio DevOps / Cloud Engineering.