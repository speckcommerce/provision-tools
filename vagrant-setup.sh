#!/bin/bash
set -e

if [ "$USER" != "vagrant" ] || [ ! -d "/vagrant" ]; then
    echo "Restricted to vagrant to avoid accidental damage to local environment"
    exit 1
fi

sudo dnf install -y docker docker-compose
sudo systemctl enable docker.service
sudo systemctl start docker.service

DOCKER_IMAGES_DIR="$(dirname "${BASH_SOURCE[0]}")/docker"

sudo docker build -t "speckcommerce/php" "${DOCKER_IMAGES_DIR}/php"
sudo docker build -t "speckcommerce/php-fpm" "${DOCKER_IMAGES_DIR}/php-fpm"
sudo docker build -t "speckcommerce/php-composer" "${DOCKER_IMAGES_DIR}/php-composer"

echo 'sudo docker run --rm -v /vagrant:/app speckcommerce/php-composer update' > ~/.bash_history
echo 'sudo docker run --rm -v /vagrant:/app -w=/app speckcommerce/php vendor/bin/phpcbf' >> ~/.bash_history
echo 'sudo docker run --rm -v /vagrant:/app -w=/app speckcommerce/php vendor/bin/phpcs' >> ~/.bash_history
echo 'sudo docker run --rm -v /vagrant:/app -w=/app speckcommerce/php vendor/bin/phpunit' >> ~/.bash_history
