// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMde} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundme;
    function setUp() external {
        DeployFundMde deployFundMe = new DeployFundMde();
        fundme = deployFundMe.run();
    }

    function testMinimumUsdIsFive() public {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    // check if the deployer is the same person as the sender
    function checkIfDeployerIsOwner() public{
        assertEq(fundme.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public{
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }
}
