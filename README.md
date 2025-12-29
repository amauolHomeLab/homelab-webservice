

## 📌 Présentation

Ce projet a pour objectif de mettre en place un **service web fonctionnel et sécurisé** dans un environnement Linux, en appliquant des bonnes pratiques d’administration système et de DevOps.

Il s’agit d’un TP réalisable dans une **machine virtuelle (VirtualBox / VMware)**, pensé pour être **reproductible, documenté et versionné** via GitHub.

---

## 🧱 Architecture du projet

```
homelab-webservice/
│
├── app/
│   └── app.py
│
├── scripts/
│   └── backup.sh
│
├── systemd/
│   └── homelab-api.service
│
├── Dockerfile
│   
│
├── .github/
│   └── workflows/
│       └── lint.yml
│
├── .gitignore
└── README.md
```

---

## ⚙️ Prérequis

* Linux (Ubuntu / Debian / Kali)
* Accès `sudo`
* Python ≥ 3.8
* Git
* (Optionnel) Docker

---

## 👤 Création de l’utilisateur système

```bash
sudo useradd -r -s /usr/sbin/nologin websvc
```

---

## 🐍 Déploiement de l’application

### 1. Copier l’application

```bash
sudo mkdir -p /var/www/websvc
sudo cp -r app /var/www/websvc
sudo chown -R websvc:websvc /var/www/websvc
```

### 2. Test manuel

```bash
python3 app/app.py
```

Accessible sur :

```
http://localhost:5000
```

---

## ⚙️ Service systemd

### Installation

```bash
sudo cp systemd/homelab-api.service /etc/systemd/system/
sudo systemctl daemon-reexec
sudo systemctl enable homelab-api
sudo systemctl start homelab-api
```

### Vérification

```bash
systemctl status homelab-api
journalctl -u homelab-api -f
```

---

## 🔥 Sécurisation

* Service lancé avec un utilisateur non privilégié
* Accès réseau contrôlé
* Isolation du code applicatif
* Permissions minimales

Exemple avec UFW :

```bash
sudo ufw allow 5000/tcp
sudo ufw enable
```

---

## 💾 Sauvegarde automatique

Script situé dans `scripts/backup.sh`

Exécution manuelle :

```bash
./scripts/backup.sh
```

Ajout au cron :

```bash
sudo crontab -e
```

Puis :

```
0 */4 * * * /home/<user>/homelab-webservice/scripts/backup.sh
```

---

## 🐳 Docker (Bonus)

### Build

```bash
docker build -t homelab-api .
```

### Run

```bash
docker run -p 5000:5000 homelab-api
```

---

## 🤖 CI/CD – GitHub Actions

Pipeline simple :

* Lint du code Python avec `flake8`
* Exécution automatique à chaque push / PR

Fichier :

```
.github/workflows/lint.yml
```

---

## 🧪 Tests

```bash
curl http://localhost:5000
```

Réponse attendue :

```json
{
  "service": "homelab-api",
  "hostname": "machine-name",
  "status": "running"
}
```

---

## 🧠 Compétences mobilisées

* Administration système Linux
* Sécurité système
* Réseaux
* Scripting Bash
* Python
* DevOps
* Git & GitHub

---

## 📚 Améliorations possibles

* Ajout de HTTPS (Nginx + Certbot)
* Supervision (Prometheus / Grafana)
* Déploiement Ansible
* Kubernetes
* Reverse proxy
* Logs centralisés

---

## 📚 Ressources

- Claude IA, Chat GPT-5.2
- [Serveur Fault] : https://serverfault.com/questions/845471/service-start-request-repeated-too-quickly-refusing-to-start-limit
- [Stack Overflaw] : https://stackoverflow.com/questions/35452591/start-request-repeated-too-quickly

---

## 👨‍💻 Auteur

Projet personnel réalisé dans le cadre d’un entraînement en **administration système & DevOps**.

---

## 🏁 Licence

Libre d’utilisation à des fins pédagogiques.
