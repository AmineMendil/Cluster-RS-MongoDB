# Mise en place d'un cluster Replica Set Mongodb

Ce projet permet de déployer automatiquement un cluster MongoDB Replica Set avec Docker grâce à Ansible.

---

# Structure des playbooks

## 1. Préparation des serveurs `/playbooks` 

### Playbook :
`os-setup.yml`

### Description :
Ce playbook prépare les machines avant l’installation de MongoDB.

### Actions effectuées :
- Mise à jour du système
- Installation des paquets essentiels
- Installation de Python et dépendances Ansible
- Configuration automatique du hostname
- Mise à jour du fichier `/etc/hosts`

### Objectif :
Préparer un environnement propre et compatible pour Docker et MongoDB.

---

## 2. Installation Docker

### Playbook :
`docker-setup.yml`

### Description :
Installe Docker et les dépendances nécessaires.

### Actions effectuées :
- Installation de Docker
- Installation de containerd
- Activation des services Docker et containerd
- Vérification du runtime Docker
- Installation du module Python Docker pour Ansible

### Objectif :
Permettre l’exécution et la gestion des conteneurs MongoDB.

---

## 3. Déploiement MongoDB Replica Set

### Playbook :
`mongodb-setup.yml`

### Description :
Déploie MongoDB en Replica Set sur plusieurs noeuds Docker.

### Actions effectuées :
- Création du keyfile MongoDB
- Création du dossier de données
- Suppression des anciens conteneurs
- Déploiement du conteneur MongoDB
- Initialisation du Replica Set
- Élection automatique du PRIMARY
- Vérification du cluster MongoDB

### Objectif :
Créer un cluster MongoDB haute disponibilité.

---

# Playbooks de suppression `/cleanup-setup`

## 4. Suppression préparation serveur

### Playbook :
`cleanup-os.yml`

### Description :
Supprime les paquets et configurations ajoutés lors de la préparation serveur.

---

## 5. Suppression Docker

### Playbook :
`cleanup-docker.yml`

### Description :
Arrête et supprime Docker, containerd et leurs données.

---

## 6. Suppression MongoDB Replica Set

### Playbook :
`cleanup-mongodb.yml`

### Description :
Supprime les conteneurs MongoDB, les volumes de données et le keyfile.

# Ordre d’exécution des playbooks

Les playbooks doivent être exécutés dans l’ordre suivant.

---

## 1. Préparation des serveurs

### 1. Préparation des serveurs
```bash
ansible-playbook playbooks/os-setup.yml
```

### 2. Installation Docker
```bash
ansible-playbook playbooks/docker-setup.yml
```

### 3. Déploiement MongoDB Replica Set
```bash
ansible-playbook playbooks/mongodb-setup.yml
```

# Vérification du bon fonctionnement

## 1. Vérifier que le Replica Set fonctionne

### Commande :

```bash
docker exec -it mongo mongosh
```

Puis dans le shell MongoDB :

```javascript
rs.status()
```

### Résultat attendu :

- Un noeud en `PRIMARY`
- Deux noeuds en `SECONDARY`
- Replica Set nommé `rs0`

### Vérification rapide :

```javascript
rs.isMaster()
```

---

## 2. Vérifier la persistance des données

### Étape 1 : Insérer une donnée

Depuis le PRIMARY :

```javascript
use testdb

db.users.insertOne({
  name: "admin",
  role: "mongodb"
})
```

### Étape 2 : Vérifier la donnée

```javascript
db.users.find()
```

### Étape 3 : Redémarrer le container

```bash
docker restart mongo
```

### Étape 4 : Vérifier à nouveau

```javascript
db.users.find()
```

### Résultat attendu :

Les données existent toujours après le redémarrage.

### Conclusion :

La persistance fonctionne grâce au volume Docker :

```text
/opt/mongo-data:/data/db
```

---

## 3. Vérifier le Failover MongoDB

Le failover permet l’élection automatique d’un nouveau PRIMARY si le PRIMARY actuel tombe.

### Étape 1 : Vérifier le PRIMARY actuel

```javascript
rs.status()
```

Exemple :

```text
mongo1 = PRIMARY
```

### Étape 2 : Stopper le PRIMARY

Sur le serveur PRIMARY :

```bash
docker stop mongo
```

### Étape 3 : Attendre quelques secondes

MongoDB lance automatiquement une nouvelle élection.

### Étape 4 : Vérifier le nouveau PRIMARY

Depuis un autre noeud :

```javascript
rs.status()
```

### Résultat attendu :

Un SECONDARY devient automatiquement PRIMARY.

Exemple :

```text
mongo2 = PRIMARY
```

### Conclusion :

Le Replica Set assure la haute disponibilité du cluster MongoDB.