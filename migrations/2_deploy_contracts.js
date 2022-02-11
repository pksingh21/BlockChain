const MainBridge = artifacts.require("ETH-AVAX/MainBridge.sol");
const SideBridge = artifacts.require("ETH-AVAX/SideBridge.sol");
const LancheToken = artifacts.require("ETH-AVAX/LancheToken.sol");
const LancheTokenChild = artifacts.require("ETH-AVAX/LancheTokenChild.sol");

const fs = require('fs');
const EthAddress = fs.readFileSync('.eth-pub-key', 'utf8').toString().trim();
const AvaxAddress = fs.readFileSync('.avax-pub-key', 'utf8').toString().trim();
// its kinda deploy(contract, args)

// const fuckYou = async () => {
//     const LNKC = await LancheTokenChild.deployed();
//     const SBridge = await SideBridge.deployed();
//     await LNKC.setSideBridge(SBridge.address);
//     const MBridge = await MainBridge.deployed();
//     await LNKC.setMainBridge(MBridge.address);
// }

//there exists token.address

module.exports = async (deployer, network, addresses) => {
    if(network === 'rinkeby'){
        await deployer.deploy(LancheToken);
        const LNK = await LancheToken.deployed();
        LNK.mint(EthAddress, "123456789qwertyuio");
        //DO NOT MIGRATE
        //INCOMPLETE FILE
        await deployer.deploy(MainBridge,LNK.address, EthAddress);
        //Take the bridge address and set it in the LancheToken contract
        // const MBridge = await MainBridge.deploayed();
        //DO NOT MIGRATE
        //INCOMPLETE FILE
    }
    if(network === 'fuji'){
        await deployer.deploy(LancheTokenChild);
        const LNKC = await LancheTokenChild.deployed();
        //DO NOT MIGRATE
        //INCOMPLETE FILE
        await deployer.deploy(SideBridge, LNKC.address, AvaxAddress);
        //note the bridge address and set it here
        const SBridge = await SideBridge.deployed();
        LNKC.setBridgeAddress(SBridge.address);
        //DO NOT MIGRATE
        //INCOMPLETE FILE
    }
}