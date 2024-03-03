//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;


contract Homework3{
    
    uint256[] numsArray = [0, 1, 2];


    function changeArray(uint256[]  memory newArray) public {
        numsArray = newArray;
    }
}