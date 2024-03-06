//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
/**
Create a Solidity contract with one function
The solidity function should return the amount of ETH that was passed to it, and the function
body should be written in assembly
 */
contract Assembly {
    /// @dev This function returns the amount of ether that was passed to it.
    function getEthAmount() external payable returns (uint256 amount) {
        assembly {
            amount := callvalue()
        }
    }
}

