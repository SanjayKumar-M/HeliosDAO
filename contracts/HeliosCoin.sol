//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract HeliosCoin is ERC20{

   uint256  _initalsupply;
    
    mapping(address =>uint256 ) balances;
    mapping(address => mapping (address=> uint256)) allowed;
    // event Transfer(address indexed from, address indexed to, uint256 value);
    

    constructor(uint256 initalSupply) ERC20("HeliosCoin","HLOS"){
        _initalsupply = initalSupply;
        balances[msg.sender]= _initalsupply;

    }

    function totalSupply()public override  view returns (uint256) {
        return _initalsupply;

    }
    function balanceOf(address tokenOwner) public override  view returns (uint){
        return balances[tokenOwner];

    }
    function transfer(address reciever,uint256 Amount) public override  returns (bool){
        balances[msg.sender] = balances[msg.sender] - Amount;
        balances[reciever] += Amount;
        emit Transfer(msg.sender, reciever, Amount);
        return true; 
    }

    function transferFrom(address from,address to,uint256 value) public override returns(bool) {
            balances[from] -= value;
            balances[to] += value;
            allowed[msg.sender][from] -= value;
            return true;

    }
    function approve(address spender,uint256 value) public override returns(bool){
        allowed[spender][msg.sender] = value;
        return true;
    }
    function allowance(address owner,address spender)public override view returns(uint256){
        return allowed[spender][owner];

    }
}