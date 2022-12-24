//Create Token Here - https://docs.openzeppelin.com/contracts/4.x/wizard

// SPDX - License-Indentifier:Mit 
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BonnyToken is ERC20 {
    constructor() ERC20("BonnyToken", "BT") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}