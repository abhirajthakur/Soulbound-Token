// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SoulboundNft} from "../src/SoulboundNft.sol";

contract SoulboundNftTest is Test {
    SoulboundNft nft;
    address user = makeAddr("user");
    address bob = makeAddr("bob");

    modifier mintNft() {
        vm.prank(user);
        nft.mintNft();
        _;
    }

    function setUp() public {
        nft = new SoulboundNft();
        vm.broadcast();
    }

    function testDeploy() public {
        assertEq(nft.name(), "SoulboundNft");
        assertEq(nft.symbol(), "SBT");
    }

    function testMintNft() external mintNft {
        assertEq(nft.ownerOf(0), user);
    }

    function testCannotTranferToken() external mintNft {
        vm.startPrank(user);
        vm.expectRevert(SoulboundNft.SoulboundNft__CannotBeTransferred.selector);
        nft.safeTransferFrom(user, bob, 0);
        vm.stopPrank();
    }

    function testBurn() external mintNft {
        vm.startPrank(user);
        nft.burn(0);
        vm.stopPrank();
        assertEq(nft.balanceOf(user), 0);
    }

    function testCannotBurnIfNotOwner() external mintNft {
        vm.expectRevert(SoulboundNft.SoulboundNft__NotOwner.selector);
        nft.burn(0);
    }
}
