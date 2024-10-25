#!/bin/sh

# Set variables
POSTGRES_HOST=${POSTGRES_HOST:-postgres}
POSTGRES_DB=${POSTGRES_DB:-postgres}
POSTGRES_USER=${POSTGRES_USER:-postgres}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-password}
BACKUP_DIR="/backups/postgres"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create backup
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB | gzip > "$BACKUP_DIR/postgres_$TIMESTAMP.sql.gz"

# Remove backups older than 7 days
find $BACKUP_DIR -type f -name "postgres_*.sql.gz" -mtime +7 -delete
