#!/bin/bash

# Set the image name and tag
IMAGE_NAME=${1:-"my-image"}  # Default to "my-image" if no argument is provided
IMAGE_TAG=${2:-"latest"}     # Default to "latest" if no argument is provided

# Set the registry URL (adjust this to your registry)
REGISTRY_URL="my-registry.com"

# Combine registry URL with image name and tag
IMAGE="$REGISTRY_URL/$IMAGE_NAME:$IMAGE_TAG"

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker could not be found, please install Docker first."
    exit 1
fi

# Check if the image exists locally
if ! docker images "$IMAGE" | grep -q "$IMAGE"; then
    echo "Docker image $IMAGE not found locally, building the image..."
    # Build the image if not found locally
    docker build -t $IMAGE .
    
    # Check if the build was successful
    if [ $? -ne 0 ]; then
        echo "Docker build failed."
        exit 1
    fi
else
    echo "Docker image $IMAGE found locally."
fi

# Log in to the Docker registry (replace with your credentials or use Docker credentials helper)
echo "Logging into Docker registry $REGISTRY_URL..."
docker login $REGISTRY_URL -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

# Push the Docker image to the registry
echo "Pushing Docker image $IMAGE to $REGISTRY_URL ..."
docker push $IMAGE

# Check if the push was successful
if [ $? -eq 0 ]; then
    echo "Docker image $IMAGE successfully pushed."
else
    echo "Failed to push Docker image $IMAGE."
    exit 1
fi
