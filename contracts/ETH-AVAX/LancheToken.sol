//File: /contracts/LancheToken.sol
//Contract: LancheToken
//Created: 2022-02-09
//Author: Kaushik Dey
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {TokenBase} from "./TokenBase.sol";

/**
IMPLEMENTATION NOTES:

1. LancheToken is a child class of TokenBase, from now on abbreviated as LNK.
2. 
 */

contract LancheToken is TokenBase{
    constructor() TokenBase("LancheToken", "LNK"){
        //Find a way to determine some URI and use them to mint a specific number of coins here
        //for id = 0-100, mint 100 LNK keeping tokenURI = sha256(id)
        mint(msg.sender,tokenURI);
    }
}