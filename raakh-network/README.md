# RAAKH Network – Complete Installation & Deployment Guide

This guide explains how to install and run a local OP Stack based blockchain called **RAAKH Network**. It is written for developers and enthusiasts who want to recreate or extend the RAAKH Devnet without prior experience with Optimism, Docker, or Linux administration. Every command is included and no steps are assumed.

---

## ⚙️ Requirements

- Ubuntu 22.04+ server with **root** access
- Domain pointing to your server (e.g. `rpc.raakh.net`)
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

---

## 🤝 Credits

Created by **Soheil Nikzad** (<https://raakh.net>). Inspired by Optimism's OP Stack and released under the [MIT License](LICENSE).

