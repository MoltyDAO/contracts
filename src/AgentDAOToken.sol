// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title AgentDAOToken
 * @notice ERC20 token for the AI Agent DAO
 * @dev 10 billion total supply, no premine, fair launch
 */
contract AgentDAOToken is ERC20, ERC20Permit, Ownable {
    uint256 public constant TOTAL_SUPPLY = 10_000_000_000 * 10**18; // 10 billion tokens
    
    // Track total tokens sold in ICO (for transparency)
    uint256 public totalSold;
    
    event TokensPurchased(address indexed buyer, uint256 amount, uint256 ethPaid);
    
    constructor(
        string memory name,
        string memory symbol,
        address initialOwner
    ) ERC20(name, symbol) ERC20Permit(name) Ownable(initialOwner) {
        // Mint total supply to contract for ICO
        _mint(address(this), TOTAL_SUPPLY);
    }
    
    /**
     * @notice Purchase tokens in the ICO
     * @param amount Amount of tokens to buy (in wei)
     */
    function buyTokens(uint256 amount) external payable {
        require(amount > 0, "Amount must be > 0");
        require(amount <= balanceOf(address(this)), "Not enough tokens left");
        
        // Fixed price: 1 ETH = 1,000,000 tokens (0.000001 ETH per token)
        uint256 cost = (amount * 1e18) / 1_000_000;
        require(msg.value >= cost, "Insufficient ETH");
        
        // Refund excess ETH
        if (msg.value > cost) {
            payable(msg.sender).transfer(msg.value - cost);
        }
        
        // Transfer tokens
        _transfer(address(this), msg.sender, amount);
        totalSold += amount;
        
        emit TokensPurchased(msg.sender, amount, cost);
    }
    
    /**
     * @notice Get current ICO price
     */
    function getPrice() external pure returns (uint256) {
        // 1 ETH = 1,000,000 tokens
        return 1_000_000;
    }
    
    /**
     * @notice Get remaining tokens in ICO
     */
    function remainingTokens() external view returns (uint256) {
        return balanceOf(address(this));
    }
    
    /**
     * @notice Withdraw ETH from ICO to treasury (only callable by governance later)
     */
    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
