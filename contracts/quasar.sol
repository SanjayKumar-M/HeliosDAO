// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
contract Quasar is ERC20Capped {
    address payable public owner;
    uint256 public blockReward;
    constructor(uint256 cap,uint256 reward) ERC20("Quasar ", "QUA")  ERC20Capped(cap * (10** decimals())){ 
        owner = payable(msg.sender);
        // declaring initial supply of 50 million * 10^18 wei
        _mint(owner, 56000000 * (10 ** decimals()));
        blockReward = reward *(10 ** decimals());
    }

    modifier onlyOwner{
        require(msg.sender == owner,"Permission Denied!");
        _;
    }

    function _mint(address account, uint256 amount) internal virtual override(ERC20Capped){
        require(ERC20.totalSupply()+amount <=cap(),"Cap exceeded");
        super._mint(account,amount);
    }

    function setBlockReward(uint56 reward) public onlyOwner{
        blockReward=  reward *(10 ** decimals());

    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to,uint256 amount) internal virtual override{
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)){
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from,to,amount);
        

    }   

    
}
