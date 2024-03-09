# ExpertSolidityBootcamp

## Homeworks from the Expert Solidity Bootcamp 24 Cohort 1 Encode Club https://www.encode.club/expert-solidity-bootcamp

### HomeWork7

- Question 1:
  The parameter X represents a function.
  Complete the function signature so that X is a
  standard ERC20 transfer function (other than
  the visibility)
  The query function should revert if the ERC20
  function returns false

function transfer(address recipient, uint256 amount) public returns (bool);

- Question 2:
  The following function checks function details passed in the data parameter.
  function checkCall(bytes calldata data)
  external{
  }

  ##### The solution for this question can be found in Homework7.sol

  The data parameter is bytes encoded
  representing the following
  Function selector
  Target address
  Amount (uint256)
  Complete the function body as follows
  The function should revert if the function is not
  an ERC20 transfer function.
  Otherwise extract the address and amount from
  the data variable and emit an event with those
  details
  event transferOccurred(address,uint256);

##### Explicaion of the function step by step, explaining each part in detail:

function checkCall(bytes calldata data) external {
// Ensuring data is at least 36 bytes (4 bytes for the function selector, 32 bytes each for address and uint256)
require(data.length >= 36, "Invalid data length");

/_Here, we're checking that the data parameter is at least 36 bytes long, which is the minimum length required for the function selector (4 bytes) plus the address (32 bytes) and the uint256 amount (32 bytes)._/

    // Extract function selector from data
    bytes4 functionSelector;
    assembly {
        functionSelector := mload(add(data, 0x20))
    }

/_In this section, we use inline assembly to load the function selector from the provided data. The add(data, 0x20) calculates the memory position after skipping the first 32 bytes (0x20 in hexadecimal) of the data, which is where the function selector is stored._/

    // Check if the function selector corresponds to the transfer function of an ERC20 token
    require(functionSelector == bytes4(keccak256("transfer(address,uint256)")), "Not an ERC20 transfer function");

/_Here, we compare the extracted function selector with the expected function selector for an ERC20 transfer function. If they don't match, it means the provided data doesn't represent a transfer function, and we revert with an error message._/

    // Extract target address and amount from data
    address target;
    uint256 amount;
    assembly {
        target := mload(add(data, 0x24))
        // Skip over the function selector (4bytes)
        //to get the target address (32 bytes)
        amount := mload(add(data, 0x44))
        // Skip over the function selector and
        //target address to get the amount (32bytes)
    }

/_This part of the code uses assembly to extract the target address and amount from the data. We skip the first 32 bytes to get the target address and another 32 bytes to get the amount._/

    // Emit an event with the details
    emit transferOccurred(target, amount);

}
/_Finally, we emit an event called transferOccurred with the extracted target address and amount. This event provides information about the ERC20 transfer operation.
The purpose of this function is to verify if the provided data represents a valid ERC20 transfer function call and, if so, extract and emit relevant details. If not, it reverts with an error._/
