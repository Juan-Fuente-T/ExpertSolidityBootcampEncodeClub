//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Intro {
    function intro() public pure returns (uint16) {
        uint256 mol = 420;

        // Yul assembly magic happens within assembly{} section
        assembly {
            // stack variables are instantiated with
            // let variable_name := VALßUE
            // instantiate a stack variable that holds the value of mol
            // To return it needs to be stored in memory
            // with command mstore(MEMORY_LOCATION, STACK_VARIABLE)
            // to return you need to specify address and the size from the starting point
            let variable := mol
            //Find empty storage location using "free memory pointer"
            let memPtr := mload(0x40)
            mstore(memPtr, variable)
             // Return memory position and size in bytes, 0x02 = 2
            return (memPtr, 0x02)
        }
    }
}