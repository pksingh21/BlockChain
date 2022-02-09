// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MainBridge {
    IERC721 private mainToken;

    address gateway;
    
    event TokensLocked(address indexed requester, bytes32 indexed mainDepositHash, uint256 tokenId, uint timestamp);
    event TokensUnlocked(address indexed requester, bytes32 indexed sideDepositHash, uint256 tokenId, uint timestamp);

    constructor (address _mainToken, address _gateway) {
        mainToken = IERC721(_mainToken);
        gateway = _gateway;
    }

    
    function lockToken (address _requester, uint256 _tokenId, bytes32 _mainDepositHash) onlyGateway external {
        emit TokensLocked(_requester, _mainDepositHash, _tokenId, block.timestamp);
    }

    function unlockTokens (address _requester, uint256 _tokenId, bytes32 _sideDepositHash) onlyGateway external {
        mainToken.safeTransferFrom(mainToken.ownerOf(_tokenId),_requester, _tokenId); //transfer ownership to requester
        emit TokensUnlocked(_requester, _sideDepositHash, _tokenId, block.timestamp); //emit unocked event
    }

    modifier onlyGateway {
      require(msg.sender == gateway, "only gateway can execute this function");
      _;
    }
}