// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 1 ether;
    
    // function fundFundMe(address mostRecentlyDeployed) public {
    //     FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
    //     console.log("funded the FundMe with the value of", SEND_VALUE);
    // }

    function fundFundMe(address mostRecentlyDeployed) public {
    FundMe fundMeInstance = FundMe(payable(mostRecentlyDeployed));
    uint256 balance = fundMeInstance.getOwner().balance;
    require(balance > 0, "Not enough funds to fund the contract");
    uint256 valueToSend = balance > SEND_VALUE ? SEND_VALUE : balance; // Send the smaller of the two amounts
    fundMeInstance.fund{value: valueToSend}();
    console.log("funded the FundMe with the value of", valueToSend);
}



    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script{
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}