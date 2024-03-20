const { ethers } = require("hardhat");

async function main() {
  const sepoliaEthUsdPriceFeed = "0x694AA1769357215DE4FAC081bf1f309aDC325306";
  // Deploy EcoCoin
  const EcoCoin = await ethers.getContractFactory("EcoCoin");
  const ecoCoin = await EcoCoin.deploy();

  console.log("EcoCoin deployed to:", ecoCoin.target);

  // Deploy EcoCoinController
  const EcoCoinController = await ethers.getContractFactory("EcoCoinController");
  const ecoCoinController = await EcoCoinController.deploy(
    ecoCoin.address,
    sepoliaEthUsdPriceFeed
  );
  
  console.log("EcoCoinController deployed to:", ecoCoinController.target);

  // Transfer ownership of EcoCoin to EcoCoinController in a separate script
  // or by interacting with the deployed contracts directly
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});