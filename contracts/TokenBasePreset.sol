//File: /contracts/TokenBasePreset.sol
//Contract: TokenBasePreset
//Created: 2019-05-13
//Author: Kaushik Dey
//SPDX-License-Identifier: MIT

/**
This Is to be used as the token base contract for all the token contracts
Special Thanks to https://dev.to/emanuelferreira/how-to-create-a-smart-contract-to-mint-a-nft-2bbn
From where this code is inspired
 */
pragma solidity ^0.8.0; //declare solidity version

/**
Use the OpenZeppelin library to create a contract that can be deployed to the Ethereum blockchain.

Currently We will be using the ERC721 standard to create a NFT that represents a Eth Token (ETHT)
No specific 
*/

import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol"; //Basic ERC721 contract functionality



contract TokenBasePreset is ERC721PresetMinterPauserAutoId{ //use tokenbase as a child of ERC721 having these name and symbol

    address public admin; //address of the owner of the token

    constructor(string memory name, string memory symbol, string memory baseURI) ERC721PresetMinterPauserAutoId(name,symbol,baseURI){
        /**
        Constructor for the TokenBase object.
        Just takes in name and symbol and relays it to the ERC721 Constructor as for now.
         */
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