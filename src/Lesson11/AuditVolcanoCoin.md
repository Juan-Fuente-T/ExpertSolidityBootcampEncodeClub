Checklist from https://gist.github.com/shayanb/cd495e23c7cf1a8b269f8ce7fd198538

- All functions inherited from the ERC20 interface are at the same time virtual and nullified. It's necessry?
- The VolcanoCoin constructor is trying to mint 124\*1e26 when the decimals should be 18. There may be confusion with the quantities.

### Allowance

- The `increaseAllowance` and `decreaseAllowance` protect the allowance, but the `_approve` should only be called if the allowance is set to zero.
- Perhaps `increaseAllowance` should be called only if allowance is greater than zero.
- approve() it's both virtual and override (like many other functions). Could it be manipulated due to that virtual?

## decimals()

- The number of decimals is not being assigned in the constructor. It is inheriting 18 decimal places from ERC20.

## External Calls

- No external calls

## Transfers

- In the transfer(), at user's balance, and transferFrom(), at user's alowance, is being evaluated with an unchecked.
  An over or underflow could occur?
- In transferFrom (), the sender's allowance is checked before calling \_transfer()
- The \_beforeTokenTransfer() function is being called but this is an empty function.
- It is both virtual and override (like many other functions). Could it be manipulated due to that virtual?

## BalanceOf()

- It is both virtual and override (like many other functions). Could it be manipulated due to that virtual?

## Blacklistable

- No blacklisted addresses

## Mintable/Burnable

- They are both calling the \_beforeTokenTransfer() function which is empty.
- Both are using emit Transfer() which could cause confusion.
- In the \_burn(), the balance is being evaluated with an unchecked. Would an overflow or overflow be possible?

## Pauseable

- Contract functions are not pauseable

### Take fees from transfers

- No

### AirDrop interest to token holders

#### Internal Accounting discrepancy with the Actual Balance?

The VolcanoCoin constructor is trying to mint 124\*1e26 when the decimals should be 18. There may be confusion with the quantities.

### Missing Return Values

-

### Reentrance Attack

- In transferFrom() does not use checks-effects-interactions pattern. Thus reentrance is possible.

### Unprotected transferFrom()

- It is public, therefore anyone can call it, thus unprotected.
- Further open to reentrance attacks.

### DoS with unexpected revert

-
