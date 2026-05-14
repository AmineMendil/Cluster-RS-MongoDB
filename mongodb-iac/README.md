# MongoDB Replica Set on AWS avec Terraform

Ce projet permet de déployer automatiquement une infrastructure AWS composée de 3 machines EC2 destinées à héberger un cluster MongoDB Replica Set.

L’infrastructure est entièrement gérée avec **Terraform (Infrastructure as Code)**.

---

# Architecture

- 3 instances EC2 Ubuntu
- 1 Security Group (SSH + MongoDB 27017)
- Clé SSH gérée via Terraform
- Outputs pour récupérer les IP publiques

---

# Structure du projet
```bash
terraform/mongodb-iac/
├── main.tf            # Infrastructure AWS (EC2, SG, Key Pair)
├── provider.tf        # Configuration du provider AWS
├── variables.tf       # Déclaration des variables
├── terraform.tfvars   # Valeurs des variables
├── outputs.tf         # Récupération des IP publiques
```

---
# Explication des fichiers Terraform
## provider.tf

Ce fichier configure la connexion entre Terraform et AWS. Il définit la région dans laquelle les ressources seront créées. C’est le point d’entrée qui permet à Terraform de savoir sur quel cloud travailler.

## variables.tf

Ce fichier contient toutes les variables du projet. Il permet de rendre la configuration flexible et réutilisable (région AWS, type d’instance EC2, AMI Ubuntu, nom de la clé SSH). Au lieu de coder les valeurs en dur, elles sont centralisées ici.

## terraform.tfvars

Ce fichier définit les valeurs concrètes des variables. Il permet de personnaliser l’infrastructure sans modifier le code principal. C’est ici que l’on choisit la région, le type de machine et les paramètres du déploiement.

## main.tf

C’est le cœur de l’infrastructure. Il contient la création des ressources AWS :

+ clé SSH (Key Pair)
+ Security Group (réseau et sécurité)
+ instances EC2 (3 nœuds MongoDB)

C’est ici que toute l’infrastructure est construite.

## outputs.tf

Ce fichier permet d’afficher les informations importantes après le déploiement. Dans ce projet, il récupère automatiquement les IP publiques des instances EC2 pour pouvoir s’y connecter ou les utiliser avec Ansible.

---

# Comment lancer le projet
## Initialiser Terraform
```bash
terraform init 
```
## Vérifier le plan d’exécution
```bash
terraform plan 
```
## Déployer l’infrastructure
```bash
terraform apply 
```
---

# Vérifier les ressources créées
## Lister l’état Terraform
```bash
terraform state list 
```
## Récupérer les IP des machines
```bash
terraform output instance_ips 
```
---

# Connexion SSH aux machines
```bash
ssh -i ~/.ssh/key_name ubuntu@IP_Address
```