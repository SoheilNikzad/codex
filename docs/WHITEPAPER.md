# RAAKH: Custom EVM Blockchain

RAAKH is an experimental blockchain network derived from existing EVM
implementations. It is intended as a learning project to explore how an
Ethereum-compatible network can be launched and customized.

## Goals

- Provide an open testbed for smart contracts and consensus experimentation.
- Demonstrate how to fork a public EVM engine (such as Polygon or Optimism) and
  adjust its parameters.
- Offer documentation for running a node and contributing to the network.

## Technical Overview

RAAKH is compatible with the Ethereum Virtual Machine (EVM) and relies on
Proof-of-Stake consensus. The configuration is derived from Polygon's PoS chain
with modifications to chain ID, initial allocations, and block parameters.

### Sample Parameters

- **Chain ID:** `1337`
- **Block Time:** 2 seconds (configurable)
- **Initial Validators:** defined in the genesis file

## Running a Node

1. Clone this repository and review the files in `raakh/`.
2. Execute `scripts/init_raakh_node.sh` to fetch the upstream EVM source,
   compile it, and initialize a node using `raakh/genesis.json`.
3. Start the node and monitor the logs to verify block production.

## Contributing

We welcome experimentation and collaboration. Feel free to open issues or pull
requests with improvements, or fork the project for your own research.
