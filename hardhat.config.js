require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config()

module.exports = {
  solidity: "0.8.24",
  
  networks:{
    sepolia:{
      url: process.env.RPC_URL,
      accounts: process.env.PRIVATE_KEY

    }
    
  }
};
  

// Deploying contracts with the account: 0xF75362E0484D6B1A50cb723143C0344ca2a04465
// EcoCoin deployed to: 0xbBB22eF32E8B35459EA4e9FBfC6Cac0dF0b6ad88
// EcoCoinController deployed to: 0xF1B91E1557084D8A76617BC672b9cD295d9c54B3