// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {ERC20StorageVersioned} from "../src/ERC20StorageVersioned.sol";

contract DropletScript is Script {
    ERC20StorageVersioned public droplet;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        droplet = new ERC20StorageVersioned("DROPLET", "DROP");
        vm.stopBroadcast();
    }

    function runGrantRoles() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address token = address(0xABCD);
        address admin = address(0x1234);

        droplet = ERC20StorageVersioned(token);
        droplet.grantRole(droplet.TOKEN_MANAGER_ROLE(), admin);
        vm.stopBroadcast();
    }
}
