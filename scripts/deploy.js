const hre = require("hardhat")

const main =  async() =>{
  const quasarContract = await hre.ethers.getContractFactory("Quasar")

  const deployContract = await quasarContract.deploy(100000000,25); //market cap and blockreward
  await deployContract.waitForDeployment();
  
  console.log(`Contract deployed successfully to ${deployContract.target}`);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
