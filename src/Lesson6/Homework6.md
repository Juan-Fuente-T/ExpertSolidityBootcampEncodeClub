# ExpertSolidityBootcamp

## Homeworks from the Expert Solidity Bootcamp 24 Cohort 1 Encode Club https://www.encode.club/expert-solidity-bootcamp

### HomeWork6

#### Assembly 2

1. What is doing this code?
   push9 0x601e8060093d393df3
   msize
   mstore # mem = 000...000 601e8060093d393df3
   #= 000...000 spawned constructor payload
   #copy the runtime bytecode after the constructor code in mem
   codesize # cs
   returndatasize # 0 cs
   msize # 0x20 0 cs
   codecopy # mem = 000...000 601e8060093d393df3
   RUNTIME_BYTECODE # --- stack ---
   push1 9 # 9
   codesize # cs 9
   add # cs+9 = CS = total codesize in memory
   push1 23 # 23 CS
   returndatasize # 0 23 CS
   dup3 # CS 0 23 CS
   dup3 # 23 CS 0 23 CS
   callvalue # v 23 CS 0 23 CS
   create # addr1 0 23 CS
   pop # 0 23 CS
   create # addr2
   selfdestruct

- It is executing the initcode, running the constructor and loading the rest of the bitcode into memory. It obtains the value of the ether sent and then it is deploying a first contract, then it is deploying a second contract and finally it is doing a selfdestruct.

2. Explain what the following code is doing in the Yul ERC20 contract

   function allowanceStorageOffset(account, spender) -> offset {
   offset := accountToStorageOffset(account)
   mstore(0, offset)
   mstore(0x20, spender)
   offset := keccak256(0, 0x40)
   }

- The function calculates a unique storage location for the allowance amount that an account has approved for a spender.
  It obtains the value of one account using accountToStorageOffset() function
  It stores this value in memory at position 0.
  It stores the spender's address in memory at position 0x20.
  Calculates the Keccak-256 hash of the data stored in memory from position 0 to 0x40 and assigns this hash value back to offset.
