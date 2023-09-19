const hre = require("hardhat")

const main =  async() =>{
  const quasarContract = await hre.ethers.getContractFactory("Quasar")
  const deployContract = await quasarContract.deploy();
  await deployContract.deployed();
  const address = deployContract.address;
  console.log(`Contract deployed successfully to ${address}`);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
