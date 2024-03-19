// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

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

contract EcoCoinController is Ownable {
    EcoCoin public ecoCoin;

    AggregatorV3Interface public inrPriceFeed;

    uint256 public targetPrice = 1 * 10**18; // 1 ECO = 1 INR
    uint256 public lastRebaseTimestamp;
    uint256 public rebaseFrequency = 1 days; // Rebase daily

    event Rebase(uint256 prevSupply, uint256 newSupply);

    constructor(address _inrPriceFeed) {
        ecoCoin = new EcoCoin(100000); // Initial supply of 100,000 EcoCoins
        inrPriceFeed = AggregatorV3Interface(_inrPriceFeed);
        lastRebaseTimestamp = block.timestamp;
    }

    function shouldRebase() public view returns (bool) {
        return block.timestamp >= lastRebaseTimestamp + rebaseFrequency;
    }

    function rebase() external onlyOwner {
        require(shouldRebase(), "Rebase not yet due");
        
        uint256 prevSupply = ecoCoin.totalSupply();
        (, int256 latestPrice, , , ) = inrPriceFeed.latestRoundData();
        require(latestPrice > 0, "Invalid price data");

        uint256 currentPrice = uint256(latestPrice);
        uint256 newSupply = (prevSupply * targetPrice) / currentPrice;

        ecoCoin.totalSupply() = newSupply;
        lastRebaseTimestamp = block.timestamp;

        emit Rebase(prevSupply, newSupply);
    }
}









































































































































// //SPDX-License-Identifier: MIT

// pragma solidity ^0.8.19;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



// contract HeliosCoin is ERC20{

//    uint256  _initalsupply;
    
//     mapping(address =>uint256 ) balances;
//     mapping(address => mapping (address=> uint256)) allowed;
//     // event Transfer(address indexed from, address indexed to, uint256 value);
    

//     constructor(uint256 initalSupply) ERC20("HeliosCoin","HLOS"){
//         _initalsupply = initalSupply;
//         balances[msg.sender]= _initalsupply;

//     }

//     function totalSupply()public override  view returns (uint256) {
//         return _initalsupply;

//     }
//     function balanceOf(address tokenOwner) public override  view returns (uint){
//         return balances[tokenOwner];

//     }
//     function transfer(address reciever,uint256 Amount) public override  returns (bool){
//         balances[msg.sender] = balances[msg.sender] - Amount;
//         balances[reciever] += Amount;
//         emit Transfer(msg.sender, reciever, Amount);
//         return true; 
//     }

//     function transferFrom(address from,address to,uint256 value) public override returns(bool) {
//             balances[from] -= value;
//             balances[to] += value;
//             allowed[msg.sender][from] -= value;
//             return true;

//     }
//     function approve(address spender,uint256 value) public override returns(bool){
//         allowed[spender][msg.sender] = value;
//         return true;
//     }
//     function allowance(address owner,address spender)public override view returns(uint256){
//         return allowed[spender][owner];

//     }
// }