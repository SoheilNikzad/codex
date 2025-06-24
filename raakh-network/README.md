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
