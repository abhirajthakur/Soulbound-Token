// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title SoulboundNft
 * @author Abhiraj Thakur
 * @notice This contract is used to mint NFTs that cannot be transferred.
 * 
 * https://sepolia.etherscan.io/address/0x0e123dd931138990880f012dd0833a837eaa3852
 */
contract SoulboundNft is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    error SoulboundNft__CannotBeTransferred();
    error SoulboundNft__NotOwner();

    constructor() ERC721("SoulboundNft", "SBT") {}

    /**
     * @notice This function is used to burn the NFT.
     * @param tokenId The ID of the NFT to be burned.
     * @dev This function can only be called by the owner of the NFT.
     */
    function burn(uint256 tokenId) external {
        if (ownerOf(tokenId) != msg.sender) {
            revert SoulboundNft__NotOwner();
        }
        _burn(tokenId);
    }

    /**
     * @notice This function is used to mint an NFT.
     */
    function mintNft() public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    /**
     * @notice This function is used to get the URI of the NFT.
     * @return The URI of the NFT.
     * @dev This function is required by the ERC721 standard.
     */
    function tokenURI(uint256 /* tokenId */ ) public pure override returns (string memory) {
        return _baseURI();
    }

    /**
     * @notice This function is used to burn the NFT.
     * @param tokenId The ID of the NFT to be burned.
     * @dev This function can only be called by the owner of the NFT.
     */
    function _burn(uint256 tokenId) internal override {
        super._burn(tokenId);
    }

    /**
     * @notice This function is used to get the base URI of the NFT.
     * @return The base URI of the NFT.
     */
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeigip4dvpgqqw7zgyimasd2auspgnf7goymdqz426rqk6xhmpnejiy/";
    }

    /**
     * @notice This function is used to check if the NFT can be transferred or not.
     * @param from The address from which the NFT is being transferred.
     * @param to The address to which the NFT is being transferred. 
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256,
        /* firstTokenId */
        uint256 /* batchSize */
    ) internal pure override {
        if (from != address(0) && to != address(0)) {
            revert SoulboundNft__CannotBeTransferred();
        }
    }
}
