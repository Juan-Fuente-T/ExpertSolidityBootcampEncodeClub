// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * @title Store
 * @notice A contract to manage payments and store data related to them.
 * @dev The contract includes a struct for payments and methods to manipulate the stored data.
 */
contract OptimizedStore {

    struct payments {
        bool valid;
        bool checked;
        address sender;
        address receiver;
        uint8 paymentType;
        uint256 amount;
        uint256 initialAmount;
        uint256 finalAmount;
    }
    payments[8] topPayments;
    uint8 index;
    bool flag1;
    bool flag2;
    bool flag3;
    address admin;
    address admin2;
    uint256 public number;
    mapping (address=>uint256) balances;


    constructor(){

    }


    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}

