//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
/**
 Write some Yul to
1. Add 0x07 to 0x08
2. store the result at the next free memory location.
3. (optional) write this again in opcodes
 */
contract Homework5{

function addition() public pure{
    assembly {
        let x := 0x07 
        let y := 0x08
        let z := add (x, y) 
        //Find empty storage location using "free memory pointer"    
        let memPtr := mload(0x40)
        mstore(memPtr, z) //store result in memory
    }
}
}
/** ***********OPCODES*********
PUSH1 0x07
PUSH1 0x08
ADD
MLOAD
MSTORE*/




