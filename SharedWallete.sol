pragma solidity ^0.8.0;

contract SharedWallete { 

    //the creator is the owner of the wallet
    address private owner; 

    constructor () {
        owner = msg.sender;
    }

    //events 
    event DepositFunds ( address from, address to, uint amount);
    event WithdrawFunds ( address from , uint amount); 
    event TranferFunds ( address from , address to, uint amount);

    //create a mapping to safe owners address inside of it  
    mapping ( address => uint ) public _owners; 

    // onlyOwnerModificator 
    modifier onlyOwner() {
        require(msg.sender == owner || _owners[msg.sender] == 1 , "you are not Owner!");
        _;
    }

    //this function is used to add owners of the wallet.
    function addOwner( address __owner ) public onlyOwner { 
        _owners[__owner] = 1; 
    }  

    //remove an owner from the wallet.  0 means disabled
    function removeOwner ( address __owner ) public onlyOwner {
        _owners[__owner] = 0;
    }

    //Anyone can deposit funds into the wallet and emit an event called depositfunds
    function getpayment () public payable {
        emit DepositFunds(msg.sender,  address(this), msg.value );
    }

    //to withdraw you need to be an owner, the amount needs to be >= balance of acct.
    function withdrowFunds ( uint amount ) public onlyOwner { 
        require(address(this).balance >= amount  , " Not enough Balance ");
        payable (msg.sender).transfer(amount);
        emit WithdrawFunds(address(this), amount);
    }

    // transfer Funciton 
    function transferTo ( address payable to , uint amount ) public onlyOwner { 
        require(address(this).balance >= amount  , " Not enough Balance ");
        to.transfer(amount);
        emit TranferFunds(address(this), to, amount);
    }



}


/*
                    ╔═════════════════════════════╗
                    ║       ADDITIONAL LINKS      ║
                    ╚═════════════════════════════╝

📹BonnyCypro YouTube - https://www.youtube.com/channel/UC5M97bGzgZPC1w1jch4S7nQ
💬You can ask some questions in our Telegramm Chat - https://t.me/+3KEwJhVlSxUyY2Qy

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