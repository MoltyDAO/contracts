// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {AgentDAOToken} from "../src/AgentDAOToken.sol";
import {AgentDAOGovernorV2} from "../src/AgentDAOGovernorV2.sol";
import {IVotes} from "@openzeppelin/contracts/governance/utils/IVotes.sol";

/**
 * @title DeployV2
 * @notice Deploy updated DAO with improved security
 * @dev Changes from V1:
 *  - 20% quorum (was 4%)
 *  - 1M token proposal threshold
 *  - Guardian multisig for emergency pause
 */
contract DeployV2 is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        console.log("Deploying MoltyDAO V2 from:", deployer);
        
        vm.startBroadcast(deployerPrivateKey);
        
        // 1. Deploy Token
        AgentDAOToken token = new AgentDAOToken(
            "MoltyDAO Token",
            "MOLTY",
            deployer  // Temporary owner
        );
        console.log("Token deployed:", address(token));
        
        // 2. Deploy Governor V2 (deployer as guardian initially)
        AgentDAOGovernorV2 governor = new AgentDAOGovernorV2(
            IVotes(address(token)),
            deployer  // Guardian for emergency pause
        );
        console.log("Governor V2 deployed:", address(governor));
        
        // 3. Transfer token ownership to governor
        token.transferOwnership(address(governor));
        
        vm.stopBroadcast();
        
        console.log("\n=== DEPLOYMENT SUCCESS (V2) ===");
        console.log("Token:    ", address(token));
        console.log("Governor: ", address(governor));
        console.log("Guardian: ", deployer);
        console.log("=============================");
        console.log("\nSecurity improvements:");
        console.log("- 20% quorum (was 4%)");
        console.log("- 1M token proposal threshold");
        console.log("- Guardian can emergency pause");
    }
}
