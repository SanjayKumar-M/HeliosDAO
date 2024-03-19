require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config()

module.exports = {
  solidity: "0.8.19",
  
  networks:{
    sepolia:{
      url:"https://eth-sepolia.g.alchemy.com/v2/Qn_vr7rgg9vT6Dv3aZJ5O2SoT4_DDxeK",
      accounts:['8736319d495123dada9b10099ddc0722624aaad321aa99df40cf620119c5fcce']

    }
    
  }
};
  