// SPDX-License-Identifier: MIT
pragma solidity 3.4.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./AllowanceManager.sol";

contract SimpleWallet is Ownable {
    using SafeMath for uint256;

    AllowanceManager public allowanceManager;

    event Deposited(address indexed from, uint256 amount);
    event Withdrawn(address indexed to, uint256 amount);
    event MoneyReceived(address indexed from, uint256 amount);
    event MoneySent(address indexed to, uint256 amount);
    event InsufficientFunds(address indexed caller, uint256 requestedAmount, uint256 availableAmount);

    constructor(address _allowanceManager) {
        allowanceManager = AllowanceManager(_allowanceManager);
    }

    receive() external payable {
        emit Deposited(msg.sender, msg.value);
        emit MoneyReceived(msg.sender, msg.value);
    }

    modifier onlyOwnerOrPermitted(uint256 amount) {
        require(owner() == msg.sender || allowanceManager.allowances(msg.sender) >= amount, "Not permitted");
        _;
    }

    function withdraw(uint256 amount, address payable to) external onlyOwnerOrPermitted(amount) {
        uint256 contractBalance = address(this).balance;
        require(contractBalance >= amount, "Insufficient funds in contract");

        if (msg.sender != owner()) {
            allowanceManager.reduceAllowance(msg.sender, amount);
        }

        to.transfer(amount);
        emit Withdrawn(to, amount);
        emit MoneySent(to, amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function renounceOwnership() public override onlyOwner {
        revert("Renouncing ownership is not allowed.");
    }
}
