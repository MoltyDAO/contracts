// Deployment bytecode for MetaMask/Remix
// Copy this data and use "Deploy Bytecode" in Remix, or use MetaMask with custom data

const DEPLOYMENT_DATA = {
  // Token contract bytecode (generated from compilation)
  token: {
    abi: [...],  // Will be filled
    bytecode: "0x...",  // Will be filled
    expectedAddress: "0x..."
  },
  governor: {
    abi: [...],
    bytecode: "0x...",
    expectedAddress: "0x..."
  }
};

// Instructions for manual deployment:
// 1. Go to https://remix.ethereum.org
// 2. Create new file: AgentDAOToken.sol
// 3. Paste the contract code
// 4. Compile with Solidity 0.8.20
// 5. Deploy to "Injected Provider - MetaMask" with Base Sepolia network
// 6. Repeat for AgentDAOGovernorV2.sol
