const MainBridge = artifacts.require("ETH-AVAX/MainBridge.sol");
const SideBridge = artifacts.require("ETH-AVAX/SideBridge.sol");
const LancheToken = artifacts.require("ETH-AVAX/LancheToken.sol");
const LancheTokenChild = artifacts.require("ETH-AVAX/LancheTokenChild.sol");

module.exports = async (deployer, network, addresses) => {
    if(network === 'rinkeby'){
        await deployer.deploy(LancheToken);
        const LNK = await LancheToken.deployed();
        //DO NOT MIGRATE
        //INCOMPLETE FILE
        await deployer.deploy(MainBridge);
        const MBridge = await MainBridge.deployed();
        //DO NOT MIGRATE
        //INCOMPLETE FILE
    }
    if(network === 'fuji'){
        await deployer.deploy(LancheTokenChild);
        const LNKC = await LancheTokenChild.deployed();
        //DO NOT MIGRATE
        //INCOMPLETE FILE
        await deployer.deploy(SideBridge);
        const SBridge = await SideBridge.deployed();
        //DO NOT MIGRATE
        //INCOMPLETE FILE
    }
}