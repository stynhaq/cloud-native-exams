#!/bin/bash

# minikube set up
if [[ -f minikube-linux-amd64 ]]
then
	echo minikube file in current directory
else
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi



# kubectl set up


if [[ -f kubectl ]]
then
	echo kubectl file in current directory
else
        # Download latest release 
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	# Download checksum
	curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
        # validate download
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
fi


# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --short

# Install Docker Engine
sudo apt-get update
 sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

if [[ ! -f /etc/apt/keyrings/docker.gpg ]] 
then
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add current user to docker group
if [[ $(groups $USER | awk '{print $4}') == 'docker' ]]
then
	echo "User belongs to docker group, skipping...."
else
	sudo usermod -aG docker $USER && newgrp docker
fi

# Start minikube
minikube start

if [[ $(echo $?) > 0 ]]
then
	echo "Minikube failed to start"
else
	# clean up setup files
	rm -f ./kubectl
	rm -f ./kubectl.sha256
	rm -f ./minikube-linux-amd64
fi


kubectl get po -A
