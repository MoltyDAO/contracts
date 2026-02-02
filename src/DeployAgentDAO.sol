// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AgentDAOToken} from "./AgentDAOToken.sol";
import {AgentDAOGovernor} from "./AgentDAOGovernor.sol";
import {IVotes} from "@openzeppelin/contracts/governance/utils/IVotes.sol";

/**
 * @title DeployAgentDAO
 * @notice Deployment script for the AI Agent DAO
 * @dev Deploys: Token -> Governor (Timelock can be added in v2)
 */
contract DeployAgentDAO {
    /**
     * @notice Deploy DAO contracts
     * @param tokenName Name of the DAO token
     * @param tokenSymbol Symbol of the DAO token
     * @param initialOwner Initial owner address
     * @return token Token contract address
     * @return governor Governor contract address
     */
    function deploy(
        string memory tokenName,
        string memory tokenSymbol,
        address initialOwner
    ) external returns (address token, address governor) {
        // 1. Deploy Token
        AgentDAOToken daoToken = new AgentDAOToken(tokenName, tokenSymbol, address(this));
        token = address(daoToken);
        
        // 2. Deploy Governor
        AgentDAOGovernor daoGovernor = new AgentDAOGovernor(IVotes(token));
        governor = address(daoGovernor);
        
        // 3. Transfer token ownership to governor
        daoToken.transferOwnership(governor);
        
        return (token, governor);
    }
}
