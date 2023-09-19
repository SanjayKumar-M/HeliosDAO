// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
contract Quasar is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 public blockReward;
    constructor(uint256 cap) ERC20("Quasar ", "QUA")  ERC20Capped(cap * (10** decimals())){ 
        owner = payable(msg.sender);
        // declaring initial supply of 50 million * 10^18 wei
        _mint(owner, 56000000 * (10 ** decimals()));
    }

    modifier onlyOwner{
        require(msg.sender == owner,"Permission Denied!");
        _;
    }

    function setBlockReward(uint56 reward) public onlyOwner{
        blockReward=  reward *(10 ** decimals());

    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to,uint256 amount) internal virtual override{

        
    }   
}
