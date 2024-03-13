# ExpertSolidityBootcamp

## Homeworks from the Expert Solidity Bootcamp 24 Cohort 1 Encode Club https://www.encode.club/expert-solidity-bootcamp

### HomeWork10

## Question 1:

Audit 1
Imagine you have been given the following code
to audit
DogCoinGame.sol
with the following note from the team
"DogCoinGame is a game where players are
added to the contract via the addPlayer
function, they need to send 1 ETH to play.
Once 200 players have entered, the UI will be
notified by the startPayout event, and will pick
100 winners which will be added to the winners
array, the UI will then call the payout function to
pay each of the winners.
The remaining balance will be kept as profit for
the developers."
Write out the main points that you would include
in an audit report.

#### Findings

- Use of .send() for Ether Transfers: The payWinners function uses .send() to transfer Ether to winners. This can be problematic as .send() does not throw exceptions if the call fails, potentially leading to situations where funds are not transferred as expected. It is recommended to use .transfer() instead.

- Control of Player Arrival: The condition to start the payout (if (numberPlayers > 200)) is ambiguous and does not provide a clear way to "stop" the game once the number of players reaches the threshold. This could lead to the contract continuing to accept players and collecting funds even after the necessary number of players has been reached to initiate the payout.

- Selection of Winners: There is no clear mechanism for selecting winners in a fair and random manner, making the process centralized and potentially unreliable.

- Determination of Game Start: There is no clear mechanism for determining when the game starts, which could lead to confusion about when players should be added and when winners should be selected.

- Use of the currentPrize Variable: The currentPrize variable is not used anywhere in the contract, suggesting it may be an error or that the functionality related to the current prize has not been fully implemented.

- Requirement of Contract Balance: The requirement that the contract balance must be 100 to set the prize is confusing and could be part of a security mechanism or an error in the contract logic.
  Recommendations

##### It is recommended:

- Replace .send() with .transfer() in the payWinners function to prevent potential transfer failures.

- Implement a clear mechanism to "stop" the game once the necessary number of players has been reached to initiate the payout.

- Develop a fair and random mechanism for selecting winners.

- Establish a clear mechanism for determining when the game starts.

- Utilize the currentPrize variable or remove it if it is not necessary.

- Clarify the requirement of contract balance to set the prize.

## Question 2:

Audit 2

This contract is the winner of this years
underhanded solidity contest, it mimics the
OpenSea application.
Can you spot the flaws in it
⛽🏌This is a gas-golfed version of Zora v3's
Offers module!
🤩 A bidder can call createBid to bid on the NFT
of their dreams.
💰 The NFT owner can call acceptBid to accept
one of these on-chain bids.
🤝 Assets exchange hands.
😤 What could possibly go wrong?
Hints
Look at the Solmate contracts used, and the
way transferFrom is implemented.

###### https://github.com/ExtropyIO/ExpertSolidityBootcamp/blob/main/exercises/audit/BrokenSea.sol

- The Erc20 does not have a safeTransferFrom() function, like the one being used in this way in the line 67 _erc20Token.safeTransferFrom(bidder, msg.sender, price);_

The contract is using SafeTransferLib for ERC20, but the safeTransferFrom() function takes 4 params but only 3 are being used:

    function safeTransferFrom(
        ERC20 token,
        address from,
        address to,
        uint256 amount
    )

#### Spanish Version:

#### Hallazgos

Question 1

- Uso de .send() para Transferencias de Ether: La función payWinners utiliza .send() para transferir Ether a los ganadores. Esto puede ser problemático ya que .send() no lanza excepciones si la llamada falla, lo que podría llevar a situaciones donde los fondos no se transfieren como se esperaba. Se recomienda utilizar .transfer() en su lugar.

- Control de Llegada de Jugadores: La condición para iniciar el pago (if (numberPlayers > 200)) es confusa y no proporciona una forma clara de "detener" el juego una vez que se alcanza el número de jugadores. Esto podría llevar a que el contrato siga aceptando jugadores y recaudando fondos incluso después de que se haya alcanzado el número de jugadores necesario para iniciar el pago.

- Selección de Ganadores: No hay un mecanismo claro para seleccionar ganadores de manera justa y aleatoria, lo que hace que el proceso sea centralizado y poco fiable.

- Determinación del Inicio del Juego: No hay un mecanismo claro para determinar cuándo comienza el juego, lo que podría llevar a confusiones sobre cuándo se deben agregar jugadores y cuándo se deben seleccionar ganadores.

- Uso de la Variable currentPrize: La variable currentPrize no se utiliza en ninguna parte del contrato, lo que sugiere que podría ser un error o que la funcionalidad relacionada con el premio actual no se ha implementado completamente.

- Requerimiento de Balance del Contrato: El requisito de que el balance del contrato sea 100 para establecer el premio es confuso y podría ser parte de un mecanismo de seguridad o un error en la lógica del contrato.
  Recomendaciones

##### Se recomienda:

- Reemplazar .send() por .transfer() en la función payWinners para prevenirposibles fallos en las transferencias.

- Implementar un mecanismo claro para "detener" el juego una vez que se alcanza el número de jugadores necesario para iniciar el pago.

- Desarrollar un mecanismo justo y aleatorio para seleccionar ganadores.

- Establecer un mecanismo claro para determinar cuándo comienza el juego.

- Utilizar la variable currentPrize o eliminarla si no es necesaria.

- Clarificar el requisito de balance del contrato para establecer el premio.

Question 2

El contrato ERC20 no tiene una función safeTransferFrom() como la que se está utilizando de esta manera en la línea 67 _erc20Token.safeTransferFrom(bidder, msg.sender, price);_

El contrato está usnado usin SafeTransferLib for ERC20, pero la función safeTransferFrom() toma 4 parámetros, y en el contrato solo se están utilizando 3:

function safeTransferFrom(
ERC20 token,
address from,
address to,
uint256 amount
)
