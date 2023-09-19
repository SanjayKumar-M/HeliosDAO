require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config()

module.exports = {
  solidity: "0.8.19",
  
  networks:{
    polygon_mumbai:{
      url:process.env.API_KEY,
      
      accounts:[process.env.PRIVATE_KEY]
    }
  }
};
