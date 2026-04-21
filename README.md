# Starknet Bridge Relay

This repository provides an expert-grade messaging architecture for bridging assets between Ethereum (L1) and Starknet (L2). It demonstrates how to utilize the Starknet Core Contract to send cross-layer messages.

### Architecture
* **L1 Portal:** A Solidity contract on Ethereum that locks assets and sends a message to L2 via the `IStarknetMessaging` interface.
* **L2 Receiver:** A Cairo-inspired logic flow for consuming messages and minting representation tokens.
* **State Sync:** Mechanisms to ensure transaction finality and security across both layers.

### Security
* **Finality Checks:** Only processes withdrawals once L2 state is finalized on L1.
* **Replay Protection:** Unique message hashes and nonces to prevent double-spending.
