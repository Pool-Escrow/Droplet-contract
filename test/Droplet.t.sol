// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Droplet} from "../src/Droplet.sol";

contract DropletTest is Test {
    Droplet public droplet;

    function setUp() public {
        droplet = new Droplet("Droplet", "DROP");
    }

    function test_Increment() public {
        droplet.mint(address(this), 100);
        assertEq(droplet.balanceOf(address(this)), 100);
    }

    function test_Burn() public {
        droplet.mint(address(this), 100);
        droplet.burn(address(this), 50);
        assertEq(droplet.balanceOf(address(this)), 50);
    }

    function test_transfer() public {
        droplet.mint(address(this), 100);
        droplet.transfer(address(1), 50);
        assertEq(droplet.totalSupply(), 100);
        assertEq(droplet.balanceOf(address(this)), 50);
        assertEq(droplet.balanceOf(address(1)), 50);

        droplet.upgradeStorage("Droplet.storage.version.2");
        assertEq(droplet.balanceOf(address(this)), 0);
        assertEq(droplet.balanceOf(address(1)), 0);

        assertEq(droplet.totalSupply("Droplet.storage.version.1"), 100);
        assertEq(droplet.balanceOf(address(this), "Droplet.storage.version.1"), 50);
        assertEq(droplet.balanceOf(address(1), "Droplet.storage.version.1"), 50);
    }

    function test_UpgradeStorage() public {
        test_Increment();
        droplet.upgradeStorage("Droplet.storage.version.2");
        assertEq(droplet.balanceOf(address(this)), 0);
        assertEq(droplet.totalSupply(), 0);

        droplet.totalSupply("Droplet.storage.version.1");
        droplet.balanceOf(address(this), "Droplet.storage.version.1");
    }
}   
