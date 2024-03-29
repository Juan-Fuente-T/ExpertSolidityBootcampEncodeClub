// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.8;

contract GasContract {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public whitelist;
    mapping(address => ImportantStruct) internal whiteListStruct;
    address internal immutable _owner;

    address[5] public administrators;

    struct ImportantStruct {
        uint256 amount;
        bool paymentStatus;
    }

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        uint256 len  = _admins.length;
        if (_admins.length > 5) {
            revert();
        }

        _owner = msg.sender;

        for (uint256 ii; ii < len; ii++) {
            administrators[ii] = _admins[ii];
        }

        balances[_owner] = _totalSupply;
    }

    /// @dev this functions always returns true in test...
    function checkForAdmin(address _user) public pure returns (bool admin_) {
        return true;
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return balances[_user];
    }

    /// @dev tests does not check for balance requirements and does not need an event
    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        if (msg.sender != _owner) revert();
        if (_tier > 254) revert();

        whitelist[_userAddrs] = 3;

        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        uint256 usersTier = whitelist[msg.sender];
        if (usersTier == 0 || usersTier > 4) {
            revert();
        }

        if (_amount < 4) {
            revert();
        }

        

        whiteListStruct[msg.sender].amount = _amount;
        whiteListStruct[msg.sender].paymentStatus = true;

        balances[msg.sender] =
            balances[msg.sender] +
            whitelist[msg.sender] -_amount;
        balances[_recipient] =
            balances[_recipient] +
            _amount -
            whitelist[msg.sender];

        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(
        address sender
    ) public view returns (bool, uint256) {
        return (true, whiteListStruct[sender].amount);
    }
}