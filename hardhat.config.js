require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config()

module.exports = {
  solidity: "0.8.19",
  
  networks:{
    mumbai:{
      url:process.env.API_KEY,
      
      accounts:[process.env.PRIVATE_KEY]
    },
    xinfin:{
      url:process.env.NETWORK_URL,
      accounts:[process.env.THE_PRIVATE_KEY]
    }
  }
};
  