const MainBridge = artifacts.require("ETH-AVAX/MainBridge.sol");
const SideBridge = artifacts.require("ETH-AVAX/SideBridge.sol");
const LancheToken = artifacts.require("ETH-AVAX/LancheToken.sol");
const LancheTokenChild = artifacts.require("ETH-AVAX/LancheTokenChild.sol");

const fs = require('fs');
const EthAddress = fs.readFileSync('.eth-priv-key', 'utf8').toString().trim();
const AvaxAddress = fs.readFileSync('.avax-priv-key', 'utf8').toString().trim();
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
        await deployer.deploy(MainBridge,LNK.address, EthAddress);
    }
    if(network === 'fuji'){
        await deployer.deploy(LancheTokenChild);
        const LNKC = await LancheTokenChild.deployed();
        await deployer.deploy(SideBridge, AvaxAddress);
        //note the bridge address and set it here
        const SBridge = await SideBridge.deployed();
        LNKC.setBridgeAddress(SBridge.address);
        SBridge.initializeBridge(LNKC.address);
        //DO NOT MIGRATE
        //INCOMPLETE FILE
    }
}