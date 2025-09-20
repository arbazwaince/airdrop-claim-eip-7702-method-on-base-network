// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/Script.sol";

contract Nonce is Script {
    function run() external view {
        console2.log("nonce:", vm.getNonce(vm.envAddress("ADDR_A")));
    }
}
