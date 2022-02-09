//File: /contracts/LNK.sol
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
    constructor(string memory tokenURI) TokenBase("LancheToken", "LNK"){
        mint(msg.sender,tokenURI);
    }
}