//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract SubOverflow {
    // Modify this function so that on overflow it returns the value 0
    // otherwise it should return x - y
    function subtract(uint256 x, uint256 y) public pure returns (uint256 result) {
        //uint256 result;
        // Write assembly code that handles overflows
        assembly {
            //Find empty storage location using "free memory pointer"
            let memPtr := mload(0x40)
            result := sub(x, y)
            if lt(x, y) {
               // Store 0 in memory position memPtr
               mstore(memPtr, 0)
                // Return memory position and size in bytes, 0x1 = 1
               return(memPtr, 0x1)
            }
            if gt(x, y){
                mstore(memPtr, result)
                // Return memory position and size in bytes, 0x20 = 32
                return(memPtr, 0x20)
            }
        }
    }
}

