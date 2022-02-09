//File: /contracts/TokenBase.sol
//Contract: TokenBase
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

import "@openzeppelin/contracts/utils/Counters.sol"; //Help us increment a token id for each new token
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; //Functions to help with tokenURI (Metadata+Image)
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; //Basic ERC721 contract functionality


contract TokenBase is ERC721URIStorage{ //use tokenbase as a child of ERC721 having these name and symbol

    using Counters for Counters.Counter; 

    mapping(string => uint8) hashes; //mapping of string to uint8 (hash) for IPFS

    Counters.Counter private _tokenIds; //keep track of number of tokens created
    
    address public admin; //address of the owner of the token

    constructor(string memory name, string memory symbol) ERC721(name,symbol){
        /**
        Constructor for the TokenBase object.
        Just takes in name and symbol and relays it to the ERC721 Constructor as for now.
         */
    }

    function updateAdmin(address newAdmin) external {
        require(msg.sender == admin,'Only admin can update admin');
        admin = newAdmin;
    }

    function mint(address reciever, string memory tokenURI) virtual public returns(uint256){
        /**
        The createToken functions recieves the tokenURI as input.
        and returns the index of the token.

        Minting and Setting Token URI is done internally
         */

        require(msg.sender == admin,'Only admin can mint');

        _tokenIds.increment(); //Increment the number of existing tokens
        uint256 newItemId = _tokenIds.current(); //set the id of the new token (var to be used later)
        _mint(reciever,newItemId); //Mint the new token
        _setTokenURI(newItemId,tokenURI); //set the tokenURI
        return newItemId; //return the id of the token
    }

    function burn(uint256 tokenID) virtual public returns(bool){
        /**
        The createToken functions recieves the tokenURI as input.
        and returns the index of the token.

        Minting and Setting Token URI is done internally
         */

        require(msg.sender == admin,'Only admin can burn');
        ERC721URIStorage._burn(tokenID); //Burn the token
        _tokenIds.decrement(); //Increment the number of existing tokens
        return true; //success
    }
}