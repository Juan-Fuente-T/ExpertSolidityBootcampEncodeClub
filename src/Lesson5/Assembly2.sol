//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Add {
    function addAssembly(uint256 x, uint256 y) public pure returns (uint256) {
        // Intermediate variables can't communicate between  assembly blocks
        // But they can be written to memory in one block
        // and retrieved in another.
        // Fix this code using memory to store the result between the blocks
        // and return the result from the second block
        assembly {
            let result := add(x, y)
            // Store the result in memory, in position 0x80
            mstore (0x80, result)
        }

        assembly {
            // Load the result from memory
            let result := mload(0x80)
            //  // Load the result from memory
            // The first part is the word position in memory,
            // the second part is how many bytes, in this case 0x20 = 32.
            return(0x80, 0x20)
        }
    }
}
