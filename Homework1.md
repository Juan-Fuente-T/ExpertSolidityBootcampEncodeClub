# ExpertSolidityBootcamp

## Homeworks from the Expert Solidity Bootcamp 24 Cohort 1 Encode Club https://www.encode.club/expert-solidity-bootcamp

### HomeWork1

- 1. Why is client diversity important for Ethereum?

     The variety of clients contributes to the scalability of Blockchain. When the volume of transactions grew, it was seen that the computing power and the cost of storing data in each of the blocks was too high, so the variety of layers facilitates the distribution of data and distribution of computing, therefore enhancing scalability. It is positive because it lowers prices and improves efficiency and speed.

/_Official response:_/ Decentralisation and resilience

- 2. Where is the full Ethereum state held ?

     The "World State" in Ethereum is a mapping between addresses (accounts) and their respective states, stored in a data structure known as a Merkle Patricia Trie. This mapping is not stored on the blockchain, but it is expected that implementations store it in a tree. Information about Ethereum accounts resides in the "World State" and is stored in the trie of the "World State".

/_Official response:_/ In the client software on an archive node

- 3. What is a replay attack ? , which 2 pieces of information can prevent it ?

     A replay attack is an attack from a malicious actor that intercepts and repeats a valid data transmission on another network (occurred during the hard fork). V is either 27 or 28 in Bitcoin and Ethereum before EIP 155, since then, the chain ID is used in the calculation of v, to give protection against replaying transaction v = {0,1} + CHAIN_ID \* 2 + 35

/_Official response:_/ a-: Where a previously accepted transaction is re submitted to the network
b-: The chain ID and the nonce

- 4. In a contract, how do we know who called a view function ?
     Using msg.sender. This is one the solidity globbal variables. It's used to identify the sender of the current call.
     https://docs.soliditylang.org/en/latest/units-and-global-variables.html

/_Official response:_/ Although msg.sender may have the address we cannot rely on this.
