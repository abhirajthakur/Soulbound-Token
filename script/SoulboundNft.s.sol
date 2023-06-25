// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {SoulboundNft} from "../src/SoulboundNft.sol";

contract SoulboundNftScript is Script {
    function run() external {
        vm.startBroadcast();
        SoulboundNft nft = new SoulboundNft();
        vm.stopBroadcast();
    }
}
