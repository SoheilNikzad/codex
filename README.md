# RAAKH Blockchain

This repository contains scripts and configuration files for launching the **RAAKH**
EVM-based blockchain. RAAKH is a custom network derived from open-source EVM
implementations such as Polygon or Optimism.

## Repository Layout

- `scripts/` – helper scripts to set up a development node.
- `raakh/` – sample configuration files, including the genesis file.
- `docs/` – documentation and the project whitepaper.

## Getting Started

1. Review the sample `genesis.json` in `raakh/` and adjust parameters like the
   `chainId`, initial account balances, or gas limits.
2. Run `scripts/init_raakh_node.sh` to clone the upstream EVM repository and
   initialize a local node using the custom genesis file.
3. Consult `docs/WHITEPAPER.md` for a full description of the network goals and
   setup instructions.

These files provide a starting point for customizing an EVM engine and launching
RAAKH as a standalone blockchain.
