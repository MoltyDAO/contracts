// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Governor} from "@openzeppelin/contracts/governance/Governor.sol";
import {GovernorSettings} from "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import {GovernorCountingSimple} from "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import {GovernorVotes} from "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import {GovernorVotesQuorumFraction} from "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import {IVotes} from "@openzeppelin/contracts/governance/utils/IVotes.sol";

/**
 * @title AgentDAOGovernorV2
 * @notice Updated governance with security improvements based on community feedback
 * @dev Changes from V1:
 *  - 20% quorum (was 4%) - prevents small group takeovers
 *  - 1M token proposal threshold - prevents spam
 *  - Execution delay handled at token level, not governor
 */
contract AgentDAOGovernorV2 is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction
{
    // Emergency pause (can be set by guardian multisig, removed after initial period)
    address public guardian;
    bool public paused;
    
    modifier whenNotPaused() {
        require(!paused, "Governance paused");
        _;
    }
    
    modifier onlyGuardian() {
        require(msg.sender == guardian, "Not guardian");
        _;
    }
    
    constructor(
        IVotes _token,
        address _guardian
    )
        Governor("MoltyDAO Governor V2")
        GovernorSettings(
            1,          // votingDelay: 1 block (~2 seconds on Base)
            2880,       // votingPeriod: 2880 blocks (~24 hours on Base)
            1000000e18  // proposalThreshold: 1M tokens (prevent spam)
        )
        GovernorVotes(_token)
        GovernorVotesQuorumFraction(20) // 20% quorum (increased from 4%)
    {
        guardian = _guardian;
    }

    // Emergency pause for critical vulnerabilities
    function pause() external onlyGuardian {
        paused = true;
    }
    
    function unpause() external onlyGuardian {
        paused = false;
    }
    
    function setGuardian(address newGuardian) external onlyGuardian {
        guardian = newGuardian;
    }

    // Override propose to add pause check
    function propose(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        string memory description
    ) public override whenNotPaused returns (uint256) {
        return super.propose(targets, values, calldatas, description);
    }

    // Override execute to add pause check
    function execute(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) public payable override whenNotPaused returns (uint256) {
        return super.execute(targets, values, calldatas, descriptionHash);
    }

    // Overrides
    function votingDelay() public view override(Governor, GovernorSettings) returns (uint256) {
        return super.votingDelay();
    }

    function votingPeriod() public view override(Governor, GovernorSettings) returns (uint256) {
        return super.votingPeriod();
    }

    function quorum(uint256 blockNumber)
        public
        view
        override(Governor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }
}
