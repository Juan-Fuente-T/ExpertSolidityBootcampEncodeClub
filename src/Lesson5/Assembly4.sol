//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;


contract Scope {
    uint256 public count = 10;

    function increment(uint256 num) public {
        // Modify state of the count variable from within
        // the assembly segment
        assembly {
            let memPtr := mload(0x40)
            // Update the count using the ".slot" suffix to access to an state variable
            sstore(count.slot, add(sload(count.slot), num))
            mstore (memPtr, sload(count.slot))
        }
    }
}