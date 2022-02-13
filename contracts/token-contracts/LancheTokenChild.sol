// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LancheTokenChild is ERC721, ERC721Enumerable, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    address public bridge;
    constructor(address _bridge) ERC721("LancheToken", "LNK") {
        bridge = _bridge;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmYSHpTcQRnJY9krbTfZotdEb4CFr88q7WkyERv8Bs71fQ/";
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint (address recipient,uint256 tokenId) public virtual onlyBridge{
        return super._safeMint(recipient,tokenId);
    }
    
    function burn (uint256 tokenId) public override virtual onlyBridge{
        return super._burn(tokenId);
    }
    
    modifier onlyBridge {
      require(msg.sender == bridge, "only bridge has access to this child token function");
      _;
    }
}