const MainBridge = artifacts.require("bridge-contracts/MainBridge.sol");
const SideBridge = artifacts.require("bridge-contracts/SideBridge.sol");
const LancheToken = artifacts.require("token-contracts/LancheToken.sol");
const LancheTokenChild = artifacts.require("token-contracts/LancheTokenChild.sol");

const fs = require('fs');
const EthAddress = fs.readFileSync('./keys/eth-pub-key', 'utf8').toString().trim();
const EthKey = fs.readFileSync('./keys/eth-priv-key', 'utf8').toString().trim();
const AvaxAddress = fs.readFileSync('./keys/avax-pub-key', 'utf8').toString().trim();
const AvaxKey = fs.readFileSync('./keys/avax-priv-key', 'utf8').toString().trim();
const GatewayAddress = fs.readFileSync('./keys/gateway-pub-key', 'utf8').toString().trim();
const GatewayKey = fs.readFileSync('./keys/gateway-priv-key', 'utf8').toString().trim();
// its kinda deploy(contract, args)

//there exists token.address

module.exports = async (deployer, network, addresses) => {
    if(network === 'rinkeby'){
        await deployer.deploy(LancheToken);
        const LNK = await LancheToken.deployed();
        for(let i = 0; i < 6; i++){
            LNK.safeMint(EthAddress);
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