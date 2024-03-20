require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config()

module.exports = {
  solidity: "0.8.24",
  
  networks:{
    sepolia:{
      url:"https://eth-sepolia.g.alchemy.com/v2/Yx40Yhrsh9kobCZ5m2W_2_jPOfioFMt3",
      accounts:['8736319d495123dada9b10099ddc0722624aaad321aa99df40cf620119c5fcce']

    }
    
  }
};
  

// Deploying contracts with the account: 0xF75362E0484D6B1A50cb723143C0344ca2a04465
// EcoCoin deployed to: 0xbBB22eF32E8B35459EA4e9FBfC6Cac0dF0b6ad88
// EcoCoinController deployed to: 0xF1B91E1557084D8A76617BC672b9cD295d9c54B3