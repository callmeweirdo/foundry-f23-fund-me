//SPDX-Lisence-Identifier: MIT;

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMde} from "../script/DeployFundMe.s.sol";
import {FundFundMe} from "../script/Interactions.s.sol";


contract IteractionTest is Test{
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_AMOUNT = 10 ether;

    function setUp() public {
        DeployFundMde deployFundMe = new DeployFundMde();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_AMOUNT);
    }

    function testUserCanFundInteraction() public{
        FundFundMe fundFundMe = new FundFundMe();

        vm.prank(USER);
        vm.deal(USER, 1e18);
        fundFundMe.fundFundMe(address(fundMe));

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }


}