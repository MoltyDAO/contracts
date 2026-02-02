# Manual Deployment Guide

## Option 1: MetaMask Deployment (Easiest)

### Prerequisites:
- MetaMask with Base Sepolia network added
- 0.01 Sepolia ETH in your wallet
- Visit: https://sepolia.basescan.org

### Steps:

1. **Add Base Sepolia to MetaMask:**
   - Network Name: Base Sepolia
   - RPC URL: https://sepolia.base.org
   - Chain ID: 84532
   - Currency Symbol: ETH
   - Block Explorer: https://sepolia.basescan.org

2. **Deploy Token Contract:**
   Since Foundry isn't broadcasting properly, use this alternative:

   **A) Via Remix:**
   - Go to https://remix.ethereum.org
   - Create file: `AgentDAOToken.sol`
   - Copy contract code from GitHub
   - Compile with Solidity 0.8.20
   - Deploy via "Injected Provider - MetaMask"
   - Constructor args: "MoltyDAO Token", "MOLTY", [your_address]

   **B) Via Direct Transaction:**
   Send Sepolia ETH to: `0x4D7765B7Da7384F0c966681cbE90C830Df2c6275`
   This wallet will attempt deployment via script

## Option 2: Fix Foundry (Recommended for Future)

### Install Foundry natively on Windows:

```powershell
# Using Chocolatey (recommended)
choco install foundry

# Or download manually from:
# https://github.com/foundry-rs/foundry/releases
```

### Then deploy:
```bash
cd C:\Users\szcze\.openclaw\workspace\agent-dao
forge script script/DeployV2.s.sol --rpc-url https://sepolia.base.org --broadcast --private-key 0xd5f4028135f227dcc86cdbacc436e6210bdaf8d8d66313d5a0e3e8db1bb14e47
```

## Option 3: Use Backend Wallet

Once you send Sepolia ETH to `0x4D7765B7Da7384F0c966681cbE90C830Df2c6275`, I can:
1. Generate the raw transaction
2. You sign it via MetaMask
3. I broadcast it

## Current Issue Summary:

**Problem:** Docker container simulates transactions but doesn't broadcast them to the blockchain.

**Root cause:** Foundry's `--broadcast` flag requires interactive terminal or specific network config that's not working in Docker.

**Solution:** Either install Foundry natively OR use Remix/online deployment tools.

## What I Need:

1. **Send 0.01 Sepolia ETH** to: `0x4D7765B7Da7384F0c966681cbE90C830Df2c6275`
2. **Choose deployment method:**
   - A) You deploy via Remix (I provide exact steps)
   - B) Install Foundry on Windows (permanent fix)
   - C) I generate tx data, you sign via MetaMask

**Which option do you prefer?**
