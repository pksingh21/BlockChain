const MainBridge = artifacts.require("ETH-AVAX/MainBridge.sol");
const SideBridge = artifacts.require("ETH-AVAX/SideBridge.sol");
const LancheToken = artifacts.require("ETH-AVAX/LancheToken.sol");
const LancheTokenChild = artifacts.require("ETH-AVAX/LancheTokenChild.sol");

const fs = require('fs');
const EthAddress = fs.readFileSync('.eth-pub-key', 'utf8').toString().trim();
const AvaxAddress = fs.readFileSync('.avax-pub-key', 'utf8').toString().trim();
// its kinda deploy(contract, args)

//there exists token.address

module.exports = async (deployer, network, addresses) => {
    if(network === 'rinkeby'){
        await deployer.deploy(LancheToken);
        const LNK = await LancheToken.deployed();
        for(let i = 0; i < 6; i++){
            LNK.mint(EthAddress);
        }
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