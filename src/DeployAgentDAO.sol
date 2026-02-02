// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AgentDAOToken.sol";
import "./AgentDAOGovernor.sol";
import "./AgentDAOTimelock.sol";

/**
 * @title DeployAgentDAO
 * @notice Deployment script for the AI Agent DAO
 * @dev Deploys: Token -> Timelock -> Governor
 */
contract DeployAgentDAO {
    function run() external {
        // This will be executed via Foundry
        // In production, use proper deployment script with private key
    }
    
    /**
     * @notice Deploy full DAO stack
     * @param tokenName Name of the DAO token
     * @param tokenSymbol Symbol of the DAO token
     * @param initialOwner Address of the initial owner (before governance transfer)
     * @return token Address of deployed token
     * @return timelock Address of deployed timelock
     * @return governor Address of deployed governor
     */
    function deploy(
        string memory tokenName,
        string memory tokenSymbol,
        address initialOwner
    ) external returns (address token, address timelock, address governor) {
        // 1. Deploy Token
        AgentDAOToken daoToken = new AgentDAOToken(tokenName, tokenSymbol, initialOwner);
        token = address(daoToken);
        
        // 2. Deploy Timelock
        // Initially, proposers and executors are empty - will be set to Governor
        address[] memory empty = new address[](0);
        AgentDAOTimelock daoTimelock = new AgentDAOTimelock(
            1 days, // minDelay
            empty, // proposers (set to Governor later)
            empty, // executors (set to Governor later)
            initialOwner // admin
        );
        timelock = address(daoTimelock);
        
        // 3. Deploy Governor
        AgentDAOGovernor daoGovernor = new AgentDAOGovernor(
            IVotes(token),
            TimelockController(timelock),
            string.concat(tokenName, " Governor")
        );
        governor = address(daoGovernor);
        
        // 4. Setup permissions
        // Grant proposer and executor roles to Governor
        daoTimelock.grantRole(daoTimelock.PROPOSER_ROLE(), governor);
        daoTimelock.grantRole(daoTimelock.EXECUTOR_ROLE(), governor);
        
        // 5. Transfer token ownership to timelock (governance controls the treasury)
        daoToken.transferOwnership(timelock);
        
        return (token, timelock, governor);
    }
}
