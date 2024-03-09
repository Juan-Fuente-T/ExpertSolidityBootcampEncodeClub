// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.8;

contract GasContract {
    mapping(address => uint256) public balances;
    // mapping(address => Payment[]) public payments;
    mapping(address => uint256) public whitelist;
    mapping(address => ImportantStruct) public whiteListStruct;
    address internal _owner;

    address[5] public administrators;
    // enum PaymentType {
    //     Unknown,
    //     BasicPayment,
    //     Refund,
    //     Dividend,
    //     GroupPayment
    // }
    // PaymentType constant defaultPayment = PaymentType.Unknown;
    // History[] public paymentHistory; // when a payment was updated

    struct ImportantStruct {
        uint256 amount;
        bool paymentStatus;
    }

    // struct Payment {
    //     uint256 amount;
    //     address admin; // administrators address
    //     PaymentType paymentType;
    //     bool adminUpdated;
    //     bytes8 recipientName; // max 8 characters
    //     address recipient;
    // }

    // struct History {
    //     address updatedBy;
    //     uint256 blockNumber;
    // }

    error Unauthorized();
    error ExceedsMaximumAdministratorsAllowed();
    error InsufficientBalance();
    error RecipientNameTooLong();
    error InvalidWhitelistTier();
    error NotWhitelisted();
    error AmountTooSmall();

    event AddedToWhitelist(address userAddress, uint256 tier);
    event Transfer(address recipient, uint256 amount);
    event WhiteListTransfer(address indexed);

    modifier onlyAdminOrOwner() {
        if (!checkForAdmin(msg.sender) || msg.sender != _owner) {
            revert Unauthorized();
        }

        _;
    }


    constructor(address[] memory _admins, uint256 _totalSupply) {
        if (_admins.length > 5) {
            revert ExceedsMaximumAdministratorsAllowed();
        }
        //ii is 0 by default. ii cannot have overflow. It's more efficient to have the length out.
        _owner = msg.sender;
        uint256 adminsLength = _admins.length;
        for (uint256 ii; ii < adminsLength;) {
            administrators[ii] = _admins[ii];
            unchecked {
                ii++; 
            }
        }

        balances[_owner] = _totalSupply;
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        //ii is 0 by default. ii cannot have overflow. 
        for (uint256 ii; ii < administrators.length;) {
            if (administrators[ii] == _user) {
                return true;
            }
            unchecked{
                ii++;
            }
        }
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return balances[_user];
    }

    function getTradingMode() public pure returns (bool mode_) {
        return true;
    }

    // function addHistory(address _updateAddress) private {
    //     History memory history;
    //     history.blockNumber = block.number;
    //     history.updatedBy = _updateAddress;
    //     paymentHistory.push(history);
    // }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public{
        //Removing the modifier saves more gas.
        if (_amount > balances[msg.sender]) {
            revert InsufficientBalance();
        }
        if (bytes(_name).length > 8) {
            revert RecipientNameTooLong();
        }

        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(_recipient, _amount);
        // Payment memory payment;
        // payment.paymentType = PaymentType.BasicPayment;
        // payment.recipient = _recipient;
        // payment.amount = _amount;
        // bytes8 nameBytes = bytes8(bytes(_name));
        // payment.recipientName = nameBytes;
        // payments[msg.sender].push(payment);
    }

    function addToWhitelist(
        address _userAddrs,
        uint256 _tier
    ) public onlyAdminOrOwner {
        //Removing the modifier saves more gas.
        if (_tier > 254) {
            revert InvalidWhitelistTier();
        }
        //Removining the if-else saves more gas.
        whitelist[_userAddrs] = _tier > 2 ? 3 : _tier;

        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public{
        uint256 usersTier = whitelist[msg.sender];
        if (usersTier > 0 && usersTier < 4) {
         
            if (_amount > balances[msg.sender]) {
                revert InsufficientBalance();
            }
            if (_amount < 4) {
                revert AmountTooSmall();
            }
        } else {
            revert NotWhitelisted();
        }

        whiteListStruct[msg.sender].amount = _amount;
        whiteListStruct[msg.sender].paymentStatus = true;

        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        balances[msg.sender] += whitelist[msg.sender];
        balances[_recipient] -= whitelist[msg.sender];

        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(
        address sender
    ) public view returns (bool, uint256) {
        return (
            whiteListStruct[sender].paymentStatus,
            whiteListStruct[sender].amount
        );
    }

    receive() external payable {
        payable(msg.sender).transfer(msg.value);
    }

    fallback() external payable {
        payable(msg.sender).transfer(msg.value);
    }
}