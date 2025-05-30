#!/bin/bash
set -e

IMAGE_NAME=my-booking-service
TAG=v1

# build l'image avec le nom
docker build --no-cache -f ../Dockerfile -t $IMAGE_NAME:$TAG ..

echo "Image BUILD complete!"


# Sauvegarder l'image en tar
docker save $IMAGE_NAME:$TAG -o $IMAGE_NAME.tar

# Supprimer l'image docker du cluster k3s
sudo k3s ctr images rm docker.io/library/$IMAGE_NAME:$TAG

# Charger l'image sur tous les noeuds K3s
sudo k3s ctr images import $IMAGE_NAME.tar

# Supprimer l'image du répertoire courant
sudo rm -f $IMAGE_NAME.tar


echo "Image copy complete!"

