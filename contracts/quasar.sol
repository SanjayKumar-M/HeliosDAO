// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
contract Quasar is ERC20Capped, ERC20Burnable {
    // address payable public owner;
    constructor(uint256 cap) ERC20("Quasar ", "QUA")  ERC20Capped(cap * (10** decimals())){ 
        // owner = payable(msg.sender);
        // declaring initial supply of 50 million * 10^18 wei
        _mint(payable(msg.sender), 56000000 * (10 ** decimals()));
    }
}
