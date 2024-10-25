#!/bin/sh

# Set variables
MINIO_HOST=${APPFLOWY_S3_MINIO_URL:-http://minio:9000}
MINIO_ACCESS_KEY=${APPFLOWY_S3_ACCESS_KEY:-minioadmin}
MINIO_SECRET_KEY=${APPFLOWY_S3_SECRET_KEY:-minioadmin}
MINIO_BUCKET=${APPFLOWY_S3_BUCKET:-appflowy}
BACKUP_DIR="/backups/minio"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Configure MinIO client
mc alias set myminio $MINIO_HOST $MINIO_ACCESS_KEY $MINIO_SECRET_KEY

# Create backup
mc mirror myminio/$MINIO_BUCKET $BACKUP_DIR/$TIMESTAMP

# Remove backups older than 7 days
find $BACKUP_DIR -type d -mtime +7 -exec rm -rf {} +

sudo docker-compose up -d postgres && sleep 10 && sudo docker exec -i appflowy-cloud-postgres-1 bash -c "psql -U postgres -d postgres -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;' && zcat /backups/postgres/postgres_20241023_132146.sql.gz | psql -U postgres -d postgres"