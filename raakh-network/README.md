# 📘 RAAKH Network – Full Setup Guide (Ultra Detailed, No Knowledge Assumed)

This document is **designed for absolute clarity**. Even if you have never set up a blockchain or Linux server before, you can follow every step here and fully deploy the RAAKH network—a Layer 2 blockchain built on Optimism's OP Stack.

> No assumptions. Every command is explained. Every config is included.

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

To follow this setup, you will need:

- An Ubuntu 22.04+ server with **root** access
- A domain name (e.g. `rpc.raakh.net`) that points to your server
- Open ports: `443`, `80`, `8545`, `9545`, `30303`, `9001`
- Installed tools:
  - `git`, `curl`
  - `docker`, `docker-compose`
  - `nginx`, `certbot`
  - Optional: [`kurtosis`](https://docs.kurtosis.com/)

---

## 🗂 Directory Structure

```
raakh-network/
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
