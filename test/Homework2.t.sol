// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

//import {Test, console, console2} from "lib/forge-std/lib/ds-test/src/test.sol";
import {Test, console, console2} from "lib/forge-std/src/Test.sol";
import {Homework2} from "../src/Lesson2/Homework2.sol";

/**
* @title Homework2Test
* @dev Test contract for the Homework2 contract.
*/
contract Homework2Test is Test {
    Homework2 public hm2;
    uint256[] public array = new uint256[](12);

    event ItemDeleted(uint256 index);

/**
* @notice Sets up the test environment.
* @dev Initializes the Homework2 contract before each test.
*/
    function setUp() public {
        hm2 = new Homework2();
        array = hm2.getArray();
    }

/**
* @notice Tests the deletion of items.
* @dev Verifies that items are correctly deleted from the array.
*/
    function testDeleteItems() public {
        assertEq(array[8], 8);
        assertEq(array.length, 12);

        vm.expectEmit();
        emit ItemDeleted(8);
        hm2.deleteItems(8);
        array= hm2.getArray();
        assertEq(array[8], 11);
        assertEq(array.length, 11);

        vm.expectEmit();
        emit ItemDeleted(2);
        hm2.deleteItems(2);
        array = hm2.getArray();
        assertEq(array[2], 10);
        assertEq(array.length, 10);

        vm.expectEmit();
        emit ItemDeleted(7);
        hm2.deleteItems(7);
        array = hm2.getArray();
        assertEq(array[7], 9);
        assertEq(array.length, 9);
    }

/**
* @notice Tests the deletion of items.
* @dev Verifies that the function reverts with incorret values.
*/
    function testFailDeleteItems() public {
        assertEq(array[8], 8);
        assertEq(array.length, 12);
        vm.expectRevert(abi.encodeWithSignature("IndexOutOfBounds()"));
        hm2.deleteItems(0);
        array= hm2.getArray();
        assertEq(array[8], 8);
        assertEq(array.length, 12);
        vm.expectRevert(abi.encodeWithSignature("IndexOutOfBounds()"));
        hm2.deleteItems(19);
        array= hm2.getArray();
        assertEq(array[8], 8);
        assertEq(array.length, 12);
    }    
/**
* @notice Tests the deletion of ordered items.
* @dev Verifies that ordered items are correctly deleted from the array.
*/
    function testDeleteOrderedItems() public {
        assertEq(array.length, 12);
        assertEq(array[8], 8);

        vm.expectEmit();
        emit ItemDeleted(8);
        hm2.deleteOrderedItems(8);
        array = hm2.getArray();
        assertEq(array.length, 11);
        assertEq(array[8], 9);

        vm.expectEmit();
        emit ItemDeleted(2);
        hm2.deleteOrderedItems(2);
        array = hm2.getArray();
        assertEq(array.length, 10);
        assertEq(array[2], 3);

        vm.expectEmit();
        emit ItemDeleted(7);
        hm2.deleteOrderedItems(7);
        array = hm2.getArray();
        assertEq(array.length, 9);
        assertEq(array[7], 10);
    }
/**
* @notice Tests the deletion of ordered items.
* @dev Verifies that the function reverts with incorret values.
*/
    function testFailDeleteOrderedItems() public {
        assertEq(array[8], 8);
        assertEq(array.length, 12);
        vm.expectRevert(abi.encodeWithSignature("IndexOutOfBounds()"));
        hm2.deleteOrderedItems(0);
        array= hm2.getArray();
        assertEq(array[8], 8);
        assertEq(array.length, 12);
        vm.expectRevert(abi.encodeWithSignature("IndexOutOfBounds()"));
        hm2.deleteOrderedItems(19);
        array= hm2.getArray();
        assertEq(array[8], 8);
        assertEq(array.length, 12);
    }    
    
}


