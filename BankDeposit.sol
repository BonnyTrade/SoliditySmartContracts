pragma solidity ^0.8.0;


// one can deposit ether into this contract but you must wait before you can withdraw your funds

contract BankDeposit {

    // create owner and contructor
    address private ownerBank;
    constructor () payable { 
        ownerBank = msg.sender; 
    }

    // amount of ether you deposited is saved in balances
    mapping(address => uint) public balances;
  

    // when you can withdraw is saved in lockTime
    mapping(address => uint) public lockTime;

    //deposit function
    function deposit() external payable {

        //set minimal deposit 5 ether
        require(msg.value >= 5 ether, "not enough funds");

        //update balance
        balances[msg.sender] +=msg.value;

        //updates locktime 
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

/*
                    ╔═════════════════════════════╗
                    ║       ADDITIONAL LINKS      ║
                    ╚═════════════════════════════╝
                    
📹BonnyCrypto YouTube - https://www.youtube.com/channel/UC5M97bGzgZPC1w1jch4S7nQ

💬You can ask some questions in our Telegramm Chat - https://t.me/+3KEwJhVlSxUyY2Qy
💬My Linkedin - http://www.linkedin.com/in/bonnytrade

💥My OpeanSean NFT - https://opensea.io/BonnyNFT

💸I reccomend Binance - https://accounts.binance.com/ru/register?ref=PZ2B9P6V
💸I reccomend ByBit - https://www.bybit.com/ru-RU/invite?ref=WMMJGM
💸I reccomend ByBit GATE.IO - https://www.gate.io/signup/12859730

🤖Create Trade Bots Here - https://3commas.io/?c=tc514514

💼You can buy Stocks Apple, Netflix here  - https://currency.com/trading/signup?c=6cknw8a6&pid=referral

🗝Grow your crypto securely with Ledger - https://shop.ledger.com?r=bd3c85107f00

⚡️You can Support me,  with crypto Transaction ⬇️
TRX (TRC20) - TAYPRikcdT3kyyVSf3MaNJ52wsQrJFgdJF
BSC (BEP20) - 0x139558e66ad386a7bac46a67baf5cadbcd4405c0
BTC (Bitcoin) - 1F8jv1bipH8T5ehjbcourynN1CtbwEsTyP
SOL (Solana) - 79hsAuuGUEzRsHHg3a62tZtodzZqhnrkZdLn11oPhHiR

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/