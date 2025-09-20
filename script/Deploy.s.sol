pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import {ClaimForwarder7702} from "../contracts/ClaimForwarder7702.sol";

contract Deploy is Script {
    function run() external {
        uint256 pk = vm.envUint("DEPLOYER_PK");
        vm.startBroadcast(pk);
        ClaimForwarder7702 impl = new ClaimForwarder7702();
        console2.log("ClaimForwarder7702 deployed at:", address(impl));
        vm.stopBroadcast();
    }
}
