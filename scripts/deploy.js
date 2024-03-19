const { ethers } = require("ethers");

// Contract ABI (Generated from compiled Solidity code)
const ecoCoinControllerABI = [
  // ABI for EcoCoinController contract...
];

// Provider
const provider = new ethers.providers.JsonRpcProvider("https://eth-sepolia.g.alchemy.com/v2/Qn_vr7rgg9vT6Dv3aZJ5O2SoT4_DDxeK");

// Signer (Wallet)
const privateKey = "8736319d495123dada9b10099ddc0722624aaad321aa99df40cf620119c5fcce";
const wallet = new ethers.Wallet(privateKey, provider);

// Contract address (Deployed EcoCoinController contract address)
const contractAddress = "YOUR_CONTRACT_ADDRESS";

// Contract instance
const ecoCoinController = new ethers.Contract(contractAddress, ecoCoinControllerABI, wallet);

// Function to deploy EcoCoinController contract
async function deployEcoCoinController(usdPriceFeedAddress) {
  // Load contract factory
  const EcoCoinController = new ethers.ContractFactory(ecoCoinControllerABI, ecoCoinController.bytecode, wallet);

  // Deploy contract
  const deployedContract = await EcoCoinController.deploy(usdPriceFeedAddress);
  console.log("EcoCoinController deployed at:", deployedContract.address);

  // Wait for transaction to be mined
  await deployedContract.deployed();

  return deployedContract;
}

// Function to trigger rebase
async function triggerRebase() {
  // Trigger rebase
  const tx = await ecoCoinController.rebase();
  console.log("Rebase transaction hash:", tx.hash);

  // Wait for transaction to be mined
  await tx.wait();
  console.log("Rebase successful!");
}

// Main function
async function main() {
  try {
    // Deploy EcoCoinController contract
    const deployedContract = await deployEcoCoinController("USD_PRICE_FEED_ADDRESS");

    // Test rebase functionality
    await triggerRebase();

    // Additional testing (transfer tokens, etc.)
    // Add your test cases here...

  } catch (error) {
    console.error("Error:", error);
  }
}

// Execute main function
main();
