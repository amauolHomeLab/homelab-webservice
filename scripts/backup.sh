#!/bin/bash

BACKUP_DIR="/var/backups/homelab-api"
DATE=$(date+"%Y%m%d-%H%M%S")

mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/backup-$DATE.tar.gz /var/www/websvc

echo "[+] Backup completed: $BACKUP_DIR/backup-$DATE.tar.gz"

