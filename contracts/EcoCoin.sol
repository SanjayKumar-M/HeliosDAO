// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EcoCoin is ERC20, Ownable {
    using SafeMath for uint256;

    AggregatorV3Interface public ethPriceFeed;
    uint256 public lastRebaseTimestamp;
    uint256 public targetPrice = 1 * 10**18; // 1 ECO = 1 USD

    mapping(address => bool) public excludedFromRebase;

    event Rebase(uint256 prevSupply, uint256 newSupply);

    constructor(address _ethPriceFeed) ERC20("EcoCoin", "ECO") {
        _mint(owner(), 100000 * 10**decimals()); // Initial supply of 100,000 tokens
        ethPriceFeed = AggregatorV3Interface(_ethPriceFeed);
        lastRebaseTimestamp = block.timestamp;
    }

    function setTargetPrice(uint256 _targetPrice) external onlyOwner {
        targetPrice = _targetPrice;
    }

    function excludeFromRebase(address account, bool excluded) external onlyOwner {
        excludedFromRebase[account] = excluded;
    }

    function rebase() external onlyOwner {
        uint256 prevSupply = totalSupply();
        (, int256 latestPrice, , , ) = ethPriceFeed.latestRoundData();
        uint256 currentEthPrice = uint256(latestPrice);
        uint256 newSupply = (prevSupply * targetPrice * 10**decimals()) / currentEthPrice;

        if (newSupply > prevSupply) {
            _mint(owner(), newSupply.sub(prevSupply));
        } else {
            _burn(owner(), prevSupply.sub(newSupply));
        }

        for (uint256 i = 0; i < totalSupply(); i++) {
            address account = _holderAt(i);
            if (!excludedFromRebase[account]) {
                uint256 balance = balanceOf(account);
                _burn(account, balance);
                _mint(account, (balance * newSupply) / prevSupply);
            }
        }

        lastRebaseTimestamp = block.timestamp;
        emit Rebase(prevSupply, newSupply);
    }

    function _holderAt(uint256 index) internal view returns (address) {
        uint256 numHolders = totalSupply() / 10**decimals();
        for (uint256 i = 0; i < numHolders; i++) {
            if (index == i) {
                return holderAt(i);
            }
            index -= uint256(balanceOf(holderAt(i)));
        }
        revert("Index out of bounds");
    }

    function holderAt(uint256 index) internal pure returns (address) {
        return address(uint160(uint256(index)));
    }
}

contract EcoCoinController is Ownable {
    EcoCoin public immutable ecoCoin;

    constructor(address _ethPriceFeed, address _initialOwner) {
        ecoCoin = new EcoCoin(_ethPriceFeed);
        ecoCoin.transferOwnership(_initialOwner);
    }

    function setTargetPrice(uint256 _targetPrice) external onlyOwner {
        ecoCoin.setTargetPrice(_targetPrice);
    }

    function excludeFromRebase(address account, bool excluded) external onlyOwner {
        ecoCoin.excludeFromRebase(account, excluded);
    }

    function rebase() external onlyOwner {
        ecoCoin.rebase();
    }
}