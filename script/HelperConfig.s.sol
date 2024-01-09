// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/MockV3Aggregator.sol";

contract HelperConfig is Script{
    NetworkConfig public activeNetworkConfig;
    
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    constructor(){
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        }else if(block.chainid == 1){
            activeNetworkConfig = getEthMainetConfig();
        }
        else{
            activeNetworkConfig = getOCreateAnvilEthConfig();
        }
        
    }

    struct NetworkConfig  {
        address priceFeed; // Eth/USD price feed address
    }

    function getNetworkConfig() public view returns(NetworkConfig memory) {
    return activeNetworkConfig;
    }


    function getSepoliaEthConfig() public pure returns (NetworkConfig memory ){
        // priceFeed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getEthMainetConfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory ethMainetConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethMainetConfig;
    }

    function getOCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if(activeNetworkConfig.priceFeed != address(0) ){
            return activeNetworkConfig;
        }
        vm.startBroadcast();
            MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });

        return anvilConfig;
    }
}