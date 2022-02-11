//File: /contracts/TokenBasePreset.sol
//Contract: TokenBasePreset
//Created: 2019-05-13
//Author: Kaushik Dey
//SPDX-License-Identifier: MIT

/**
This Is to be used as the token base contract for all the token contracts
Special Thanks to https://dev.to/emanuelferreira/how-to-create-a-smart-contract-to-mint-a-nft-2bbn
Also Special Thanks to https://ethereum-blockchain-developer.com/120-erc721-supply-chain-aisthisi/03-openzeppelin-erc721-token-preset/
From where this code is heavily inspired
 */
pragma solidity ^0.8.0; //declare solidity version

/**
Use the OpenZeppelin library to create a contract that can be deployed to the Ethereum blockchain.

Currently We will be using the ERC721 standard to create a NFT that represents a Eth Token (ETHT)
No specific 
*/

import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol"; //Basic ERC721 contract functionality
import "@openzeppelin/contracts/utils/Strings.sol";


contract LancheTokenBase is ERC721PresetMinterPauserAutoId{ //use tokenbase as a child of ERC721 having these name and symbol

    address public admin; //address of the owner of the token

    //Returns base URI
    function _baseURI() internal override view virtual returns (string memory) {
        return "";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(super.tokenURI(tokenId),".json"));
    }

    /**
    The Default Token Constructor for the Main Chain
    */
    constructor() ERC721PresetMinterPauserAutoId("LancheToken","LNK",_baseURI()){
        admin = msg.sender;
    }

    function updateAdmin(address newAdmin) external {
        require(msg.sender == admin,'Only admin can update admin');
        admin = newAdmin;
    }

    function mint(address reciever) virtual override public{
        /**
        The createToken functions recieves the tokenURI as input.
        and returns the index of the token.

        Minting and Setting Token URI is done internally
         */

        require(msg.sender == admin,'Only admin can mint');
        super.mint(reciever); //Mint the new token
    }

    function burn(uint256 tokenID) virtual override public{
        /**
        The createToken functions recieves the tokenURI as input.
        and returns the index of the token.

        Minting and Setting Token URI is done internally
         */

        require(msg.sender == admin,'Only admin can burn');
        super.burn(tokenID); //Burn the token
    }
}