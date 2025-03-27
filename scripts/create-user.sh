#!/bin/bash

# Add a new group named 'ubuntu' (if it doesn't exist)
groupadd ubuntu

# Create a new user 'ubuntu', set its primary group to 'ubuntu',
# add it to the 'admin' group, assign it the Bash shell, 
# and set its home directory to '/home/ubuntu'
useradd -g ubuntu -G admin -s /bin/bash -d /home/ubuntu ubuntu

# Ensure the home directory exists for the 'ubuntu' user
mkdir -p /home/ubuntu

# Copy SSH keys from the root user to the new ubuntu user's home directory
cp -r /root/.ssh /home/ubuntu/.ssh

# Change ownership of the home directory to the 'ubuntu' user
chown -R ubuntu:ubuntu /home/ubuntu

# Grant the 'ubuntu' user sudo access without requiring a password
echo "ubuntu ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create a Kubernetes configuration directory for the 'ubuntu' user
mkdir -p ~ubuntu/.kube

# Copy the Kubernetes admin configuration file so the user can use kubectl
cp -i /etc/kubernetes/admin.conf ~ubuntu/.kube/config

# Change ownership of the kubeconfig file to the 'ubuntu' user
chown ubuntu:ubuntu ~ubuntu/.kube/config
