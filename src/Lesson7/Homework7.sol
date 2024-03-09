 //SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

/**The following function checks function details
  passed in the data parameter.

  function checkCall(bytes calldata data) external{
  }

  The data parameter is bytes encoded
  representing the following
  Function selector
  Target address
  Amount (uint256)
  Complete the function body as follows
  The function should revert if the function is not
  an ERC20 transfer function.
  Otherwise extract the address and amount from
  the data variable and emit an event with those
  details
  event transferOccurred(address,uint256);*/
contract CallChecker{
    event transferOccurred(address target, uint256 amount);
    function checkCall(bytes calldata data) external {

        // Ensure data is at least 36 bytes (4 bytes for the function selector, 32 bytes each for address and uint256)
        require(data.length >= 36, "Invalid data length");

        // Extract function selector from data
        bytes4 functionSelector;
        assembly {
            functionSelector := mload(add(data, 0x20))
        }

        // Check if the function selector corresponds to the transfer function of an ERC20 token
        require(functionSelector == bytes4(keccak256("transfer(address,uint256)")), "Not an ERC20 transfer function");

        // Extract target address and amount from data
        address target;
        uint256 amount;
        assembly {
            target := mload(add(data, 0x24)) // Skip over the function selector (4 bytes) to get the target address (32 bytes)
            amount := mload(add(data, 0x44)) // Skip over the function selector and target address to get the amount (32 bytes)
        }

        // Emit an event with the details
        emit transferOccurred(target, amount);
}}