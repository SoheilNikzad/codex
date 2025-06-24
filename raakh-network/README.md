# RAAKH Network

This directory contains setup instructions and lightweight chain notes for running the **RAAKH** blockchain. The README combines the main RAAKH setup guide with concise hints for spinning up a minimal test chain.

## Directory Structure

```
raakh-network/
├── README.md
├── scripts/
│   ├── install-raakh.sh      # TODO – add file
│   └── init_raakh_node.sh    # TODO – add file
├── genesis.json              # TODO – add file
├── contracts/                # TODO – add sample contracts
├── docs/
│   └── WHITEPAPER.md         # TODO – add file
```

## Getting Started

1. **Prepare the genesis file**  
   Edit `genesis.json` to set the `chainId`, pre-funded accounts, and gas limits. If the file is missing, create it based on your network parameters.
2. **Install dependencies**  
   Run `scripts/install-raakh.sh` to install required tooling and build the underlying EVM client. This script should set up Go, fetch the RAAKH source, and compile binaries. *(Currently missing: see TODOs.)*
3. **Initialize the node**  
   Execute `scripts/init_raakh_node.sh` to create the data directory and import `genesis.json`. Check that the command populates the chain database correctly.
4. **Start the network**  
   Launch your RAAKH node with appropriate flags (RPC port, network ID, and so on). Confirm blocks are produced and the node accepts RPC requests.

These steps align with the official setup guide while incorporating the lightweight instructions below.

## Lightweight Chain Notes

For rapid testing, you can run a stripped-down network:

1. Use a minimal `genesis.json` with low difficulty and few accounts.
2. Start the node with a small block gas limit and enable HTTP RPC on `localhost:8545`.
3. Deploy contracts from `contracts/` to test interactions. You may create a simple `sample_contract.sol` for experimentation.

Running in this mode helps you validate configuration changes without a full validator set.

## Contributing

Improvements are welcome! If you add scripts or configuration files, be sure to update the README and keep the directory structure consistent.
