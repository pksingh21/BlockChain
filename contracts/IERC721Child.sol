// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IERC721Child is IERC721{
      /**
   * @notice called by bridge gateway when tokens are deposited on root chain
   * Should handle deposits by minting the required amount for the recipient
   *
   * @param _to an address for whom minting is being done
   * @param _tokenId total amount to mint
   */
    function mint(address _to, uint256 _tokenId) external;

    /**
    * @notice called by bridge gateway when tokens are withdrawn from root chain
    * Should handle withdrawals by burning the required amount for the recipient
    *
    * @param _tokenId tokenId of the NFT to burn
    */
    function burn(uint256 _tokenId) external;

    /**
    * @notice called by bridge gateway when tokens are withdrawn from root chain
    * Should handle withdrawals by burning the required amount for the recipient
    *
    * @param _from address from where to burn
    * @param _tokenId tokenId of the NFT to burn
    */
    function burnFrom(address _from, uint256 _tokenId) external;

}