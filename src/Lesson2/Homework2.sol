//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;
 /**. Write a function that will delete items (one at a
time) from a dynamic array without leaving
gaps in the array. You should assume that the
items to be deleted are chosen at random, and
try to do this in a gas efficient manner.
For example imagine your array has 12 items
and you need to delete the items at indexes 8,
2 and 7.
The final array will then have items
{0,1,3,4,5,6,9,10,11}
 */

/**
 * @title Homework2
 * @author Juan Fuente
 * @notice A contract to manage an array of integers with delete functionality.
 * @dev The contract includes methods to delete items from the array in an unordered and ordered manner.
 */
contract Homework2{
    
    uint[] dataArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

    event ItemDeleted(uint256 index);

    error IndexOutOfBounds();

    /**
    * @notice Deletes an item from the array in an unordered manner.
    * @param index The index of the item to delete.
    * @dev Replaces the item to delete with the last item in the array and then removes the last item.
    * @dev Emits an ItemDeleted event with the index of the deleted item.
    */
    function deleteItems(uint256  index) public {
        if(index == 0 && index >= dataArray.length){
            revert IndexOutOfBounds();
        }
        // we can directly replace since we don't need to keep order
        dataArray[index] = dataArray[dataArray.length-1];
        dataArray.pop();
        emit ItemDeleted(index);
    }

    /**
     * @notice Deletes an item from the array in an ordered manner.
     * @param index The index of the item to delete.
     * @dev Shifts all items after the deleted item one position to the left to maintain order, and removes last item.
     * @dev Emits an ItemDeleted event with the index of the deleted item.
     */
    function deleteOrderedItems(uint256  index) public {
        if(index == 0 && index >= dataArray.length){
            revert IndexOutOfBounds();
        }
        //we want keep the item's order
        uint256 arrayLenght = dataArray.length -1;
        for (uint256 i = index; i < arrayLenght;){
            dataArray[i] = dataArray[i+1];
            unchecked {
                i++;  
            } 
        }
        dataArray.pop();
        emit ItemDeleted(index);
    }

    /**
    * @notice Returns the current state of the data array.
    * @return An array of integers.
    */
    function getArray() public view returns(uint256[] memory ) {
        return dataArray;
    }
}