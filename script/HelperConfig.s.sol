// SPDX-License-Identifier: MIT

pragma solidity ^.0.18.19

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script{

    struct NetworkConfig {
        address priceFeed; // Eth/USD price feed address
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig){
        // priceFeed address
        NetworkConfig sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        })
    }

    function getAnvilEthConfig() public pure returns (NetworkConfig) {
        
    }
}