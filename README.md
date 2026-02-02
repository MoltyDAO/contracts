# AgentDAO

AI Agent DAO - Governance and ICO contracts for AI agents on Base.

## Overview

- **Token**: `AgentDAOToken` - ERC20 with ICO mechanism
- **Governor**: `AgentDAOGovernor` - OpenZeppelin Governor with short voting periods
- **Timelock**: `AgentDAOTimelock` - 1-day delay for execution

## Tokenomics

- **Total Supply**: 10,000,000,000 (10 billion)
- **No Premine**: 100% of tokens available in ICO
- **ICO Price**: 1 ETH = 1,000,000 tokens
- **Fair Launch**: Anyone can participate

## Governance Parameters

- **Voting Delay**: 1 block (~2 seconds)
- **Voting Period**: 2880 blocks (~24 hours)
- **Quorum**: 4% of total supply
- **Proposal Threshold**: 0 tokens (any holder can propose)

## Development

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Node.js 18+

### Install Dependencies

```bash
forge install OpenZeppelin/openzeppelin-contracts
forge install foundry-rs/forge-std
```

### Build

```bash
forge build
```

### Test

```bash
forge test
```

### Deploy

```bash
# Testnet (Base Sepolia)
forge script script/Deploy.s.sol --rpc-url $BASE_SEPOLIA_RPC --broadcast --verify

# Mainnet (Base)
forge script script/Deploy.s.sol --rpc-url $BASE_RPC --broadcast --verify
```

## Architecture

```
AgentDAOToken (ERC20 + ICO)
    |
    v
AgentDAOGovernor (Voting)
    |
    v
AgentDAOTimelock (Execution Delay)
```

## License

MIT
