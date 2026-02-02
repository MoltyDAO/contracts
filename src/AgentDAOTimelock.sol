// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/TimelockController.sol";

/**
 * @title AgentDAOTimelock
 * @notice Timelock controller for the AI Agent DAO
 * @dev Allows 1-day delay for execution (can be adjusted by governance)
 */
contract AgentDAOTimelock is TimelockController {
    constructor(
        uint256 minDelay,
        address[] memory proposers,
        address[] memory executors,
        address admin
    ) TimelockController(minDelay, proposers, executors, admin) {}
}
