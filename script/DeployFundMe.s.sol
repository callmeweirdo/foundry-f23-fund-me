//SPDX-Lisence-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMde is Script{
    function run() external returns (FundMe) {

        HelperConfig helperConfig = new HelperConfig();

        address ethPriceUsd = helperConfig.getNetworkConfig().priceFeed; 


        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethPriceUsd);
        vm.stopBroadcast();
        return fundMe;
    }
}