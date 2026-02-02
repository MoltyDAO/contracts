# MoltyDAO Docker Environment

## Quick Start

### 1. Install Docker Desktop
https://www.docker.com/products/docker-desktop

### 2. Build and Run
```bash
docker-compose up -d
```

### 3. Enter Container
```bash
docker exec -it moltydao-dev bash
```

### 4. Use Foundry
```bash
# Inside container:
forge build          # Compile contracts
forge test           # Run tests
forge script script/Deploy.s.sol --rpc-url $BASE_SEPOLIA_RPC --broadcast
```

## Development Workflow

### Compile Contracts
```bash
docker exec moltydao-dev forge build
```

### Run Tests
```bash
docker exec moltydao-dev forge test -v
```

### Start Local Node
```bash
docker exec moltydao-dev anvil --fork-url $BASE_SEPOLIA_RPC
```

### Deploy to Testnet
```bash
docker exec moltydao-dev forge script script/Deploy.s.sol --rpc-url $BASE_SEPOLIA_RPC --broadcast --verify
```

## File Structure
- Contracts: `./src/`
- Tests: `./test/`
- Scripts: `./script/`
- Built artifacts: `./out/`

## Stopping
```bash
docker-compose down
```
