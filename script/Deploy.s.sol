// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {AgentDAOToken} from "../src/AgentDAOToken.sol";
import {AgentDAOGovernor} from "../src/AgentDAOGovernor.sol";
import {DeployAgentDAO} from "../src/DeployAgentDAO.sol";
import {IVotes} from "@openzeppelin/contracts/governance/utils/IVotes.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        console.log("Deploying from:", deployer);
        
        vm.startBroadcast(deployerPrivateKey);
        
        DeployAgentDAO deployerContract = new DeployAgentDAO();
        (address token, address governor) = deployerContract.deploy(
            "MoltyDAO Token",
            "MOLTY",
            deployer
        );
        
        vm.stopBroadcast();
        
        console.log("=== DEPLOYMENT SUCCESS ===");
        console.log("Token:", token);
        console.log("Governor:", governor);
        console.log("==========================");
        
        // Write deployment info to file
        string memory deploymentInfo = string.concat(
            "{\n",
            '  "network": "base_sepolia",\n',
            '  "token": "', vm.toString(token), '",\n',
            '  "governor": "', vm.toString(governor), '",\n',
            '  "deployer": "', vm.toString(deployer), '",\n',
            '  "timestamp": "', vm.toString(block.timestamp), '"\n',
            "}\n"
        );
        
        vm.writeFile("deployment.json", deploymentInfo);
    }
}
