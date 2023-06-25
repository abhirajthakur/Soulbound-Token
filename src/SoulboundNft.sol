// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";

/**
 * https://sepolia.etherscan.io/address/0xbff947f922ba3b4ffb1fb876ad7d915ccb98bb5e#code
 */
contract SoulboundNft is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    error SoulboundNft__CannotBeTransferred();
    error SoulboundNft__NotOwner();

    constructor() ERC721("SoulboundNft", "SBT") {}

    function burn(uint256 tokenId) external {
        if (ownerOf(tokenId) != msg.sender) {
            revert SoulboundNft__NotOwner();
        }
        _burn(tokenId);
    }

    function mintNft() public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256 /* tokenId */ ) public pure override returns (string memory) {
        return _baseURI();
    }

    function _burn(uint256 tokenId) internal override {
        super._burn(tokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeigip4dvpgqqw7zgyimasd2auspgnf7goymdqz426rqk6xhmpnejiy/";
    }

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
