#!/bin/sh
set -e

echo "Running original entrypoint..."
mkdir -p /app/var

chmod +x /app/.github/docker/entrypoint.sh
/app/.github/docker/entrypoint.sh echo "Original entrypoint completed !"

echo "Applying Railway tweaks..."

if [ -f /app/storage/app/public/.railway_initialized ]; then
    echo "Initial Railway tweaks already applied, skipping..."
else
    echo "Applying initial Railway tweaks..."

    php artisan app:init "$COMPANY_NAME" "$APP_URL"
    php artisan db:seed --class=CustomPropertySeeder --force
    php artisan app:user:create "CHANGEME" "CHANGEME" "$ADMIN_EMAIL" "$ADMIN_PASSWORD" 1
    
    touch /app/storage/app/public/.railway_initialized
fi

exec "$@"