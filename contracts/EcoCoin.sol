// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract EcoCoin is Ownable {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    string public name = "EcoCoin";
    string public symbol = "ECO";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * (10 ** uint256(decimals));
        balances[msg.sender] = totalSupply;
    }

    function updateTotalSupply(uint256 newTotalSupply) external onlyOwner {
        totalSupply = newTotalSupply;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(to != address(0), "Invalid address");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        require(spender != address(0), "Invalid address");
        
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(from != address(0), "Invalid sender address");
        require(to != address(0), "Invalid recipient address");
        require(balances[from] >= amount, "Insufficient balance");
        require(allowances[from][msg.sender] >= amount, "Allowance exceeded");
        
        allowances[from][msg.sender] -= amount;
        _transfer(from, to, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 amount) internal {
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
    }
}
