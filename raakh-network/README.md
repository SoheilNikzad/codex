# RAAKH Network – Full Setup Guide
RAAKH Network is a private Layer 2 blockchain built on the [Optimism OP Stack](https://stack.optimism.io/). This repository shows how to reproduce the local devnet from scratch so you can experiment with your own OP Stack chain.

The guide assumes **no prior experience**. Every command is included and explained in plain English.

## What Problem Does It Solve?

Running a private L2 allows you to test contracts and infrastructure without using public testnets. You control the genesis accounts, block production, and RPC endpoints. It is ideal for local experimentation or education about OP Stack internals.
## Requirements
- Ubuntu 22.04 server with `root` access
- Domain name pointed to your server (e.g. `rpc.raakh.net`)
- Installed packages:
  - `git`, `curl`
  - `docker`, `docker-compose`
  - optional: [`kurtosis`](https://docs.kurtosis.com/) for containerized OP Stack

## Directory Layout

├── LICENSE                      <-- MIT license
├── README.md                    <-- This document
├── .gitignore
├── optimism-package/            <-- OP Stack sources (TODO upload)
│   └── network_params.yaml      <-- Kurtosis network parameters
└── raakh-setup-files/
    ├── genesis.json             <-- Chain genesis (TODO upload)
    ├── install-raakh.sh         <-- Auto installer script
    └── nginx.conf               <-- Nginx reverse proxy config
Files marked with `TODO` are not included in this repository. See the next section about manual uploads.

---

## 📦 Manual File Upload Notice

Some components, such as the `optimism-package` sources, `genesis.json`, and `install-raakh.sh`, may need to be supplied manually. Place them into the directories above before running the installer. After adding them you can commit and push the full setup to your own GitHub repository.

---

## Step‑by‑Step Installation

git clone https://github.com/YOUR-USERNAME/raakh-network.git
cd raakh-network
### 2. Review or Add the Required Files

Ensure `genesis.json` and the OP Stack sources exist as described. If you received them separately, copy them now.

### 3. Run the Auto Installer
sudo ./raakh-setup-files/install-raakh.sh
The script installs Docker and other packages, compiles `op-geth` and `op-node`, initializes Geth with your `genesis.json`, and configures nginx with SSL for `rpc.raakh.net`.

### 4. Start the OP Stack Manually (Alternative)
If you prefer manual control or want to run a lightweight chain:
cd optimism-package
nano network_params.yaml   # customize ports and chain settings

Kurtosis will launch `op-geth`, `op-node`, the batcher, and proposer in containers.

---

## Exposing RPC Securely

The provided `nginx.conf` proxies HTTPS requests on port 443 to your local Geth node on port 8545. Once `certbot` issues a certificate, your RPC endpoint will be:

https://rpc.raakh.net
Make sure DNS for `rpc.raakh.net` points to your server's IP before running `certbot`.
## Connecting MetaMask

Open MetaMask and add a custom network with the following fields:
| Field        | Value                    |
|--------------|--------------------------|
| **Network Name** | RAAKH Devnet           |
| **RPC URL**      | https://rpc.raakh.net  |
| **Chain ID**     | 919191                 |
| **Currency Symbol** | KHAS               |
| **Block Explorer**  | (optional)          |
## Troubleshooting
- **SSL certificate failed** – ensure your domain points to the server and port 80 is open before running `certbot`.
- **Kurtosis containers not starting** – run `kurtosis logs` to inspect errors or check Docker daemon status.
- **Geth not syncing** – confirm the genesis file path and datadir are correct. You can remove the datadir and re‑initialize if needed.

---

## Optional Add‑Ons

- **Blockscout** – deploy the [Blockscout](https://docs.blockscout.com/) explorer to browse accounts and transactions.
- **IPFS integration** – connect to a local or remote IPFS node for hosting front‑end assets.

These components are outside the base installer but can be added once your devnet is running.


## Credits

Created by **Soheil Nikzad** (<https://raakh.net>) with inspiration from Optimism's OP Stack.

Licensed under the MIT License. See [LICENSE](LICENSE).

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
