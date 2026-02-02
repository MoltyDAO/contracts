// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/AgentDAOToken.sol";
import "../src/AgentDAOGovernor.sol";
import "../src/DeployAgentDAO.sol";

contract AgentDAOTest is Test {
    AgentDAOToken public token;
    AgentDAOGovernor public governor;
    DeployAgentDAO public deployer;
    
    address public owner = address(1);
    address public agent1 = address(2);
    address public agent2 = address(3);
    
    function setUp() public {
        vm.startPrank(owner);
        deployer = new DeployAgentDAO();
        (address tokenAddr, address govAddr) = deployer.deploy("MoltyDAO Token", "MOLTY", owner);
        token = AgentDAOToken(tokenAddr);
        governor = AgentDAOGovernor(payable(govAddr));
        vm.stopPrank();
    }
    
    function test_TokenDeployment() public {
        assertEq(token.name(), "MoltyDAO Token");
        assertEq(token.symbol(), "MOLTY");
        assertEq(token.totalSupply(), 10_000_000_000 * 10**18);
        assertEq(token.balanceOf(address(token)), 10_000_000_000 * 10**18); // All in ICO contract
    }
    
    function test_ICOPrice() public {
        assertEq(token.getPrice(), 100_000_000); // 1 ETH = 100M tokens
    }
    
    function test_BuyTokens() public {
        vm.deal(agent1, 1 ether);
        
        vm.prank(agent1);
        token.buyTokens{value: 1 ether}(100_000_000); // Buy 100M tokens (1 ETH)
        
        assertEq(token.balanceOf(agent1), 100_000_000 * 10**18);
        assertEq(address(token).balance, 1 ether);
    }
    
    function test_GovernorDeployment() public {
        assertEq(governor.name(), "MoltyDAO Governor");
        assertEq(governor.votingDelay(), 1);
        assertEq(governor.votingPeriod(), 2880);
        assertEq(governor.proposalThreshold(), 0);
        // Quorum is 4% - tested separately due to snapshot timing
    }
    
    function test_RevertIf_InsufficientETH() public {
        vm.deal(agent1, 0.5 ether);
        
        vm.expectRevert("Insufficient ETH");
        vm.prank(agent1);
        token.buyTokens{value: 0.5 ether}(100_000_000); // Should fail - needs 1 ETH for 100M tokens
    }
}
