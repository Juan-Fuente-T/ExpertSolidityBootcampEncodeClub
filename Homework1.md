# ExpertSolidityBootcamp

## Homeworks from the Expert Solidity Bootcamp 24 Cohort 1 https://www.encode.club/expert-solidity-bootcamp

### HomeWork1

- 1. Why is client diversity important for Ethereum?
     The variety of customers contributes to the scalability of Blockchain. At the time that the volume of transactions grew, it was seen that the necessary computing was too much to keep everything in a single layer, so the variety facilitates the distribution of data and computing and therefore enhances scalability
- 2. Where is the full Ethereum state held ?
     The "World State" in Ethereum is a mapping between addresses (accounts) and their respective states, stored in a data structure known as a Merkle Patricia Tree. This mapping is not stored on the blockchain, but it is expected that implementations store it in a trie. Information about Ethereum accounts resides in the "World State" and is stored in the trie of the "World State".
- 3. What is a replay attack ? , which 2 pieces of information can prevent it ?
     A replay attack is an attack from a malicious actor that intercepts and repeats a valid data transmission on another network (occured during the hard fork). V is either 27 or 28 in Bitcoin and Ethereum before EIP 155, since then, the chain ID is used in the calculation of v, to give protection against replaying transaction v = {0,1} + CHAIN_ID \* 2 + 35
- 4. In a contract, how do we know who called a view function ?
     Using msg.sender
