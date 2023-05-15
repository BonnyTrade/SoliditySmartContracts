// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract SwapBTtoBGTandBGTtoBT { 

    uint public minimalWithdrawAmount;
    uint public maximalWithdrawAmount;

    ERC20 public constant token = ERC20(0x3806059fE247A988E5cf6A5Ddb8995B5569A1ff7); //BT testtokens ЗАМЕНА

    address public immutable owner; 
    address public backendOwner;

    constructor (address _adrOwner, address _adrbackenOwner, uint minAmount, uint maxAmount) { 
        owner = _adrOwner;
        backendOwner = _adrbackenOwner;
        minimalWithdrawAmount = minAmount;
        maximalWithdrawAmount = maxAmount;
    }

    // ownerFunctions
    function setMinimalWithdrawAmount ( uint amount ) external {
        require(msg.sender == owner, "owner rejected errore");
        minimalWithdrawAmount = amount;
    }

    function setMaximalWithdrawAmount ( uint amount ) external {
        require(msg.sender == owner, "owner rejected errore");
        maximalWithdrawAmount = amount;
    }

    function setBackendOwner (address  _adr) external {
        require(msg.sender == owner, "owner rejected errore");
        backendOwner = _adr;
    }


    // transfer functions
    function bttobgt ( uint amount ) external  { 
        require(0 < amount , " amount is zero");
        token.transferFrom(msg.sender, address(this), amount); 
    }

    function bgttobt ( uint amount , address player ) external { 
        require(msg.sender == backendOwner, "ackendOwner rejected errore");
        require( amount  >= minimalWithdrawAmount, "you withdraw less than you can");
        require( amount  <= maximalWithdrawAmount, "you withdraw more than you can");
        token.transfer(player, amount); 
    }
}
