pragma solidity ^0.8.0;


// one can deposit ether into this contract but you must wait 1 week before you can withdraw your funds

contract BankDeposit {

    address private ownerBank;

    // amount of ether you deposited is saved in balances
    mapping(address => uint) public balances;
  

    // when you can withdraw is saved in lockTime
    mapping(address => uint) public lockTime;

    constructor () payable { 
        ownerBank = msg.sender; 
    }

    //deposit function
    function deposit() external payable {

        //set minimal deposit 1 ether
        require(msg.value >= 5 ether, "not enough funds");

        //update balance
        balances[msg.sender] +=msg.value;

        //updates locktime 1 week from now
        lockTime[msg.sender] = block.timestamp + 15;  //15 seconds

    }

    // if we want to increase locktime;
    function increaseLockTime(uint _secondsToIncrease) public {
        require(msg.sender == ownerBank, "You are not owner");
        lockTime[msg.sender] += _secondsToIncrease;
    }


    // function withdraw
    function withdraw() public {

        // check that the now time is > the time saved in the lock time mapping
        require(block.timestamp > lockTime[msg.sender], "lock time has not expired");

        // bonusamount
        uint bonusamount;
        if ( block.timestamp - lockTime[msg.sender] > 40 )  { 
            bonusamount = 4 ether;
        } 

        if ( block.timestamp - lockTime[msg.sender] > 20 )  { 
            bonusamount = 2 ether;
        }
        
        //withdraw
        uint amount = balances[msg.sender] + bonusamount;
        payable(msg.sender).transfer(amount);
        balances[msg.sender] =0;
    }
}