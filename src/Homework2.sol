//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

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
 
//When you try to delete the 7 it is actually the index 6
//so deleting 7 is actually deleting 8
contract Homework{
    
    uint[] homeworkArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

    error IndexOutOfBounds();

    function deleteItems(uint256  index) public {
        //require(index >= 0 && index < homeworkArray.length,"Out of bounds");
        if(index == 0 && index >= homeworkArray.length){
            revert IndexOutOfBounds();
        }
        uint256 arrayLenght = homeworkArray.length -1;
        for (uint256 i = index; i < arrayLenght;){
            homeworkArray[i] = homeworkArray[i+1];
            unchecked {
                i++;  
            } 
        }
        homeworkArray.pop();
    }
    function getArray() public view returns(uint256[] memory ) {
        return homeworkArray;
    }
}