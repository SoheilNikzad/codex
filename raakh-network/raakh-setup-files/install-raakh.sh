#!/bin/bash
# RAAKH Network installer
# This script installs dependencies, builds OP Stack, and configures Nginx.
# Use on Ubuntu 22.04+ as root.
set -e

# Update system and install packages
apt update
apt install -y curl git docker.io docker-compose nginx certbot python3-certbot-nginx build-essential

# Enable docker service
systemctl enable --now docker

# Clone Optimism (if not already provided)
if [ ! -d "../optimism" ]; then
    git clone https://github.com/ethereum-optimism/optimism.git ../optimism
fi

# Build op-geth and op-node
cd ../optimism
make op-geth
make op-node
cd -

# Initialize Geth with genesis
if [ ! -d /opt/raakh ]; then
    mkdir -p /opt/raakh
fi
cp raakh-setup-files/genesis.json /opt/raakh/
/opt/optimism/op-geth init /opt/raakh/genesis.json --datadir /opt/raakh/gethdata

# Example of starting geth and op-node (user may adapt)
# /opt/optimism/op-geth --datadir /opt/raakh/gethdata &
# /opt/optimism/op-node --l1=<L1 URL> --l2=<local RPC> &

# Configure nginx
cp raakh-setup-files/nginx.conf /etc/nginx/sites-available/rpc.raakh.net
ln -sf /etc/nginx/sites-available/rpc.raakh.net /etc/nginx/sites-enabled/rpc.raakh.net
nginx -t
systemctl reload nginx

# Obtain SSL certificate
certbot --nginx -d rpc.raakh.net --non-interactive --agree-tos -m admin@raakh.net || true

echo "Installation complete. RPC available at https://rpc.raakh.net"
