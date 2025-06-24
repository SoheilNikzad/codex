# 📘 RAAKH Network – Full Setup Guide (Ultra Detailed, No Knowledge Assumed)

This document is **designed for absolute clarity**. Even if you've never set up a blockchain or Linux server before, you can follow every step here and fully deploy the RAAKH network—a Layer 2 blockchain built on Optimism's OP Stack.

> 🧠 No assumptions. Every command is explained. Every config is included.

---

# RAAKH Blockchain Network – Full Reproducible Setup (OP Stack Based)

Welcome to the RAAKH network documentation. This guide walks you through the **exact steps** required to deploy a clone of the RAAKH L2 blockchain network on your own infrastructure using [Optimism's OP Stack](https://stack.optimism.io/).

This repository provides:
- The full configuration and genesis file of the RAAKH chain
- A working OP Stack setup (`op-geth`, `op-node`, etc.)
- A tested `install-raakh.sh` installer script
- An nginx setup with SSL config for RPC endpoints
- Deployment-ready `kurtosis.yml`, `network_params.yaml`, and helper scripts

---

## ⚙️ Requirements

To follow this setup, you'll need:

- An Ubuntu 22.04+ VPS with `root` access
- A domain (e.g. `rpc.raakh.net`) with DNS pointing to your server IP
- Open ports: `443`, `80`, `8545`, `9545`, `30303`, `9001`
- Installed tools:
  - `git`, `docker`, `docker-compose`, `curl`
  - `nginx`, `certbot`
  - Optional: [`kurtosis`](https://docs.kurtosis.com/)

---

## 🗂 Directory Structure

```
raakh-network/
├── optimism-package/         ← Source of OP Stack
├── raakh-setup-files/
│   ├── genesis.json          ← Chain genesis file
│   ├── install-raakh.sh      ← Auto-install script
│   └── nginx.conf            ← RPC + SSL nginx config
└── README.md                 ← This file
```

Files marked above are placeholders if they do not yet exist.

---

## 🚀 Step-by-Step Installation Guide

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/RAAKH.git
cd RAAKH/raakh-network
```

### 2. Run the Auto-Installer (optional)

```bash
chmod +x raakh-setup-files/install-raakh.sh
./raakh-setup-files/install-raakh.sh
```

This script installs Go, Docker, clones the Optimism repo, builds binaries, and prepares your environment.

### 3. Set Up OP Stack Locally (manually)

```bash
cd optimism-package/
# Customize kurtosis params if needed:
nano network_params.yaml
kurtosis run . --enclave raakhnet
```

This launches all OP Stack components: `op-geth`, `op-node`, `batcher`, `proposer`, and bridges.

---

## 🔐 Setting Up Nginx with SSL

### 1. Install nginx & certbot

```bash
sudo apt install nginx certbot python3-certbot-nginx -y
```

### 2. Replace default config with your own

```bash
sudo cp raakh-setup-files/nginx.conf /etc/nginx/sites-available/rpc.raakh.net
sudo ln -s /etc/nginx/sites-available/rpc.raakh.net /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

### 3. Issue SSL certificates

```bash
sudo certbot --nginx -d rpc.raakh.net
```

---

## 🔗 Accessing RPC

Once everything is running:

- **HTTP RPC**: `https://rpc.raakh.net`
- **Chain ID**: `919191`
- Add this network to MetaMask or other wallets manually.

---

## 📎 Notes

- `genesis.json` contains the account used by the original operator.
- `install-raakh.sh` may need review depending on updates to the OP Stack repo.
- `optimism-package` uses Kurtosis to deploy everything in containers.

---

## 🤝 Credits

This repo is created and maintained by [Soheil Nikzad](https://raakh.net), inspired by Optimism's OP Stack and tailored for independent sovereign chains like RAAKH.

---
