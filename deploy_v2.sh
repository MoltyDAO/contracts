#!/bin/bash
# Deploy script to run inside Docker container

export BASE_SEPOLIA_RPC_URL=https://sepolia.base.org
export PRIVATE_KEY=0xd5f4028135f227dcc86cdbacc436e6210bdaf8d8d66313d5a0e3e8db1bb14e47

echo "Checking balance..."
cast balance 0x4D7765B7Da7384F0c966681cbE90C830Df2c6275 --rpc-url $BASE_SEPOLIA_RPC_URL

echo ""
echo "Deploying V2..."
forge script script/DeployV2.s.sol --rpc-url $BASE_SEPOLIA_RPC_URL --broadcast -vvvv
