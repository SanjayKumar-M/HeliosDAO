const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners(); // Get the deployer account
  console.log("Deploying contracts with the account:", deployer.address);

  const EcoCoin = await ethers.getContractFactory("EcoCoin");
  const chainlinkEthUsdFeed = "0x694AA1769357215DE4FAC081bf1f309aDC325306"; // Sepolia ETH/USD Chainlink price feed

  const EcoCoinController = await ethers.getContractFactory("EcoCoinController");

  const ecoCoin = await EcoCoin.deploy(chainlinkEthUsdFeed)
  // Deploy both contracts in a single transaction
  const ecoCoinController = await EcoCoinController.deploy(
    ecoCoin.target,
    deployer.address // Pass deployer address as the initial owner of EcoCoin
  );
  await ecoCoin.getDeployedCode();
  
  await ecoCoinController.getDeployedCode();

  
  console.log("EcoCoin deployed to:", ecoCoin.target);
  console.log("EcoCoinController deployed to:", ecoCoinController.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
