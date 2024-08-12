// SPDX-License-Identifier: MIT
pragma solidity 3.4.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract AllowanceManager is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public allowances;

    event AllowanceChanged(address indexed who, uint256 oldAllowance, uint256 newAllowance);

    // Define o allowance para um endereço específico
    function setAllowance(address who, uint256 amount) external onlyOwner {
        uint256 oldAllowance = allowances[who];
        allowances[who] = amount;
        emit AllowanceChanged(who, oldAllowance, amount);
    }

    // Reduz o allowance de um endereço específico
    function reduceAllowance(address who, uint256 amount) external {
        uint256 oldAllowance = allowances[who];
        require(oldAllowance >= amount, "Insufficient allowance");
        allowances[who] = oldAllowance.sub(amount);
        emit AllowanceChanged(who, oldAllowance, allowances[who]);
    }
}
