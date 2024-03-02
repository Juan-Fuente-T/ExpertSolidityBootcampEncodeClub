//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

contract Homework3 {

    uint256[] numsArray;

    function changeArray(uint256[] memory newArray) external {
        numsArray = newArray;
    }
}
/*
//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

contract Homework3 {

    uint256 num;

    function changeNum (uint256 newNum) external {
        num = newNum;
    }
}
*/