// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { ERC721Holder } from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract MainBridge is ERC721Holder {
    IERC721 private mainToken; //ERC721 token interface

    address gateway; //The address of the gateway
    
    //some events declared here, we'll emit them later
    event TokensLocked(address indexed requester, bytes32 indexed mainDepositHash, uint256 tokenId, uint timestamp);
    event TokensUnlocked(address indexed requester, bytes32 indexed sideDepositHash, uint256 tokenId, uint timestamp);
    
    //constructor using a IERC721 interface
    constructor (address _mainToken, address _gateway) {
        mainToken = IERC721(_mainToken);
        gateway = _gateway;
    }

    //Emit Lockdown event
    function lockToken (address _requester, uint256 _tokenId, bytes32 _mainDepositHash) onlyGateway external {
        emit TokensLocked(_requester, _mainDepositHash, _tokenId, block.timestamp);
    }

    //Transfer token to requester and emit event
    function unlockTokens (address _requester, uint256 _tokenId, bytes32 _sideDepositHash) onlyGateway external {
        mainToken.safeTransferFrom(mainToken.ownerOf(_tokenId),_requester, _tokenId); //transfer ownership to requester
        emit TokensUnlocked(_requester, _sideDepositHash, _tokenId, block.timestamp); //emit unocked event
    }

    //The onlyGateway modifier, so that only gateway uses these functions
    modifier onlyGateway {
      require(msg.sender == gateway, "only gateway can execute this function");
      _;
    }
}