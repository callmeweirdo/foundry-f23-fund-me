// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script{
    NetworkConfig public networkConfig;

    constructor(){
        if(block.chainid == 11155111){
            networkConfig = getSepoliaEthConfig();
        }else if(block.chainid == 1){
            networkConfig = getEthMainetConfig();
        }
        else{
            networkConfig = getAnvilEthConfig();
        }
        
    }

    struct NetworkConfig  {
        address priceFeed; // Eth/USD price feed address
    }

    function getNetworkConfig() public view returns(NetworkConfig memory) {
    return networkConfig;
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

    function getAnvilEthConfig() public pure returns (NetworkConfig memory) {
        
    }
}