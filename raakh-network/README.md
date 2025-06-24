# RAAKH Network – Complete Installation & Deployment Guide

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

- Ubuntu 22.04+ server with **root** access
- Domain pointing to your server (e.g. `rpc.raakh.net`)
=======
To follow this setup, you will need:

- An Ubuntu 22.04+ server with **root** access
- A domain name (e.g. `rpc.raakh.net`) that points to your server
- Open ports: `443`, `80`, `8545`, `9545`, `30303`, `9001`
- Installed tools:
  - `git`, `curl`
  - `docker`, `docker-compose`
=======
=======
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
├── README.md
├── LICENSE
├── .gitignore
├── optimism-package/            ← OP Stack source (add manually)
│   ├── network_params.yaml
│   └── ...
├── raakh-setup-files/
│   ├── install-raakh.sh         ← Installer script (add manually)
│   ├── genesis.json             ← Chain genesis file (add manually)
│   └── nginx.conf               ← Nginx reverse proxy
└── scripts/
    ├── init_node.sh             ← Optional helper
    └── build_stack.sh           ← Optional helper
```

---

## 🚧 Manual File Upload Notice

Some components are not included in this repository. Before running any commands, manually place the following files:

- `genesis.json` and `install-raakh.sh` inside `raakh-setup-files/`
- The full OP Stack source inside `optimism-package/`

Commit these files to your fork or local clone after adding them.

---

## Step 1 – Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/raakh-network.git
cd raakh-network
```

## Step 2 – Prepare Required Files

Ensure that `raakh-setup-files/` contains `genesis.json`, `install-raakh.sh`, and `nginx.conf`. Also place the OP Stack source code inside `optimism-package/`.

## Step 3 – Install System Dependencies

```bash
sudo apt update
sudo apt install -y curl git docker.io docker-compose nginx certbot python3-certbot-nginx build-essential
sudo systemctl enable --now docker
```

## Step 4 – Install Kurtosis

```bash
curl -fsSL https://kurtosis.com/install | bash
echo 'export PATH="$HOME/.kurtosis/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
kurtosis version
```

## Step 5 – Launch the OP Stack Network

```bash
cd optimism-package
kurtosis run . --enclave raakhnet
```

This command starts `op-geth`, `op-node`, and the other required services in containers. Wait until the RPC service is reachable on port `8545`.

## Step 6 – Configure Nginx and Obtain SSL
=======
├── LICENSE                      ← MIT License
├── README.md                    ← This file
├── .gitignore
├── optimism-package/            ← Source of OP Stack (TODO – add files)
│   └── network_params.yaml      ← Kurtosis parameters (TODO – add file)
└── raakh-setup-files/
    ├── genesis.json             ← Chain genesis (TODO – add file)
    ├── install-raakh.sh         ← Auto-install script
    └── nginx.conf               ← Nginx reverse proxy config
```

Files marked as `TODO` do not contain real data yet. Upload them manually before running the installer.

---

## 📦 Manual File Upload Notice

Some components of the project—such as the `optimism-package` sources, `genesis.json`, and `install-raakh.sh`—were distributed outside of this repository. You must manually place these files into the correct directories before executing any setup commands. Once added, commit them to your own fork or clone.

---

## 🚀 Step-by-Step Installation Guide

### Stage 2 – Install Nginx and Certbot (SSL)

1. Install Nginx:
   ```bash
   sudo apt install nginx -y
   ```
   Check the service status:
   ```bash
   systemctl status nginx
   ```
   If it is not running, start and enable it:
   ```bash
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```
2. Install Certbot for free SSL certificates:
   ```bash
   sudo apt install certbot python3-certbot-nginx -y
   ```
   Ensure your domain has an **A record** pointing to the server IP.

---

### Stage 3 – Get the Project from GitHub

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/raakh-network.git
   cd raakh-network
   ```
2. Review the files located in `raakh-setup-files/`:
   - `genesis.json` – genesis block configuration (TODO if empty)
   - `install-raakh.sh` – automated installer
   - `nginx.conf` – nginx configuration for the RPC endpoint

   The `optimism-package/` directory should contain the full OP Stack source used by Kurtosis.

---

### Stage 4 – Run the Full OP Stack with Kurtosis

1. Install the Kurtosis CLI:
   ```bash
   curl -fsSL https://kurtosis.com/install | bash
   echo 'export PATH="$HOME/.kurtosis/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   kurtosis version
   ```
2. Launch the network:
   ```bash
   cd optimism-package/
   kurtosis run . --enclave raakhnet
   ```
   This command starts `op-geth`, `op-node`, the batcher, proposer, and bridges inside containers.

---

### Stage 5 – Configure Nginx for `rpc.raakh.net`

1. Copy the provided configuration:
   ```bash
   sudo cp raakh-setup-files/nginx.conf /etc/nginx/sites-available/rpc.raakh.net
   sudo ln -s /etc/nginx/sites-available/rpc.raakh.net /etc/nginx/sites-enabled/
   ```
2. Test and reload nginx:
   ```bash
   sudo nginx -t
   sudo systemctl reload nginx
   ```
3. Obtain an SSL certificate:
   ```bash
   sudo certbot --nginx -d rpc.raakh.net
   ```

---

### Stage 6 – Connect MetaMask

In MetaMask choose **Add Network** and fill in the following values:

| Field            | Value                  |
|------------------|------------------------|
| Network Name     | RAAKH Devnet           |
| RPC URL          | https://rpc.raakh.net  |
| Chain ID         | 919191                 |
| Currency Symbol  | KHAS                   |
| Explorer         | (optional)             |

Once added, you can deploy contracts and interact with the chain through `https://rpc.raakh.net`.

---

## ✅ Ready to Go!

You now have a fully functional devnet. Feel free to extend it with Blockscout or IPFS integration once the core components are running.

---

## 🤝 Credits

Created by **Soheil Nikzad** (<https://raakh.net>). Inspired by Optimism's OP Stack and tailored for independent chains like RAAKH.

Released under the [MIT License](LICENSE).
=======
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
sudo nginx -t
sudo systemctl reload nginx
sudo certbot --nginx -d rpc.raakh.net
```

The RPC will now be accessible via `https://rpc.raakh.net`.

## Step 7 – Connect to MetaMask

Open MetaMask and add a custom network with the following values:

| Field          | Value                 |
|----------------|-----------------------|
| Network Name   | RAAKH Devnet          |
| RPC URL        | https://rpc.raakh.net |
| Chain ID       | 919191                |
| Currency       | KHAS                  |
| Explorer URL   | (optional)            |

After saving, you can deploy contracts and interact with the chain.

---

## 🔧 Troubleshooting

- **SSL certificate failed** – ensure your domain points to this server and port 80 is open before running Certbot.
- **Kurtosis errors** – check Docker is running and the OP Stack source files are present.
- **Geth not syncing** – verify the genesis file and check container logs for `op-geth`.

Optional services such as Blockscout or IPFS can be added once the core network is running.
=======
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

Created by **Soheil Nikzad** (<https://raakh.net>). Inspired by Optimism's OP Stack and released under the [MIT License](LICENSE).

=======
This repo is created and maintained by [Soheil Nikzad](https://raakh.net), inspired by Optimism's OP Stack and tailored for independent sovereign chains like RAAKH.

---
=======
# RAAKH Network

This directory contains notes and setup instructions for launching the **RAAKH** blockchain. The guidance below merges the original RAAKH setup guide with the lightweight chain notes so everything is in one place.

## Repository Layout

- `scripts/install-raakh.sh` *(TODO – add file)* – helper script to install prerequisites and build the chain.
- `scripts/init_raakh_node.sh` *(TODO – add file)* – initializes a local node using the genesis file.
- `genesis.json` *(TODO – add file)* – sample genesis configuration with chain ID and initial balances.
- `contracts/` *(TODO – add sample contracts)* – example smart contracts for testing.
- `docs/WHITEPAPER.md` *(TODO – add file)* – extended background on the project.

## Getting Started

1. Review the sample `genesis.json` and adjust parameters such as `chainId`, account balances, and gas limits.
2. Run `scripts/install-raakh.sh` to fetch dependencies and compile the underlying EVM client.
3. Execute `scripts/init_raakh_node.sh` to initialize a node using `genesis.json`.
4. Start the node and verify that blocks are produced.

These steps mirror the original setup guide and ensure that the chain boots with the expected parameters.

## Lightweight Chain Notes

For quick experimentation, you can run a lightweight test chain:

1. Use the minimal `genesis.json` provided above (or create your own) with a low difficulty.
2. Start the node with a small block gas limit and enable HTTP RPC on `localhost:8545`.
3. Deploy any contracts from `contracts/` to interact with the chain.

This lightweight mode lets you validate configuration changes without running a full validator network.

## Contributing

Improvements and pull requests are welcome. Be sure to keep configuration files up to date and document any custom scripts.
