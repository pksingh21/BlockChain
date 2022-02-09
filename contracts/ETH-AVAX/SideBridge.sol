// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721Child } from "./IERC721Child.sol";

contract SideBridge {
    //Some Events here
    event BridgeInitialized(uint indexed timestamp);
    event TokensBridged(address indexed requester, bytes32 indexed mainDepositHash, uint256 tokenId, uint timestamp);
    event TokensReturned(address indexed requester, bytes32 indexed sideDepositHash, uint256 tokenId, uint timestamp);
    
    IERC721Child private sideToken;
    bool bridgeInitState;
    address owner;
    address gateway;

    constructor (address _gateway) {
        gateway = _gateway;
        owner = msg.sender;
    }

    function initializeBridge (address _childTokenAddress) onlyOwner external {
        sideToken = IERC721Child(_childTokenAddress);
        bridgeInitState = true;
    }

    function bridgeTokens (address _requester, uint256 _tokenId, bytes32 _mainDepositHash) verifyInitialization onlyGateway  external {
        sideToken.mint(_requester,_tokenId);
        emit TokensBridged(_requester, _mainDepositHash, _tokenId, block.timestamp);
    }

    function returnTokens (address _requester, uint256 _tokenId, bytes32 _sideDepositHash) verifyInitialization onlyGateway external {
        sideToken.burn(_tokenId);
        emit TokensReturned(_requester, _sideDepositHash, _tokenId, block.timestamp);
    }

    //Access Modifiers
    modifier verifyInitialization {
      require(bridgeInitState, "Bridge has not been initialized");
      _;
    }

    modifier onlyGateway {
      require(msg.sender == gateway, "Only gateway can execute this function");
      _;
    }

    modifier onlyOwner {
      require(msg.sender == owner, "Only owner can execute this function");
      _;
    }
}