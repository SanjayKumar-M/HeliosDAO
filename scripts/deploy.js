const hre = require("hardhat")
const main = async() =>{

    const HeliosCoin = await hre.ethers.getContractFactory("HeliosCoin");

    const deployContract = await HeliosCoin.deploy("20000000") ;

    await deployContract.waitForDeployment();

    const address = deployContract.address;
    
    console.log(`Contract deployed successfully to ${address}`);
     

}

main().catch((err)=>{console.log(err)})


//Token address => 0x27075464e8238a0FB3deD56d3dBba753DD2882F4
//contract address => 0x27075464e8238a0FB3deD56d3dBba753DD2882F4