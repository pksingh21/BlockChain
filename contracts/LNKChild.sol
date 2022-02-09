//File: /contracts/LNK.sol
//Contract: LancheTokenChild
//Created: 2022-02-09
//Author: Kaushik Dey
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {TokenBase} from "./TokenBase.sol";

/**
IMPLEMENTATION NOTES:

1. LancheToken is a child class of TokenBase, from now on abbreviated as LNK.
2. LanceTokenChild is LNK implementation on the
 */

contract LancheTokenChild is TokenBase{
    address public bridge;

    constructor(address _bridge) TokenBase("LancheToken", "LNK"){
        bridge = _bridge;
    }

    function mint (address recipient, string memory tokenURI) public override virtual onlyBridge returns(uint256){
        return super.mint(recipient, tokenURI);
    }

    function burn (uint256 tokenID) public override virtual onlyBridge returns(bool){
        return super.burn(tokenID);
    }

    

    modifier onlyBridge {
      require(msg.sender == bridge, "only bridge has access to this child token function");
      _;
    }
}