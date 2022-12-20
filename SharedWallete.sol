pragma solidity ^0.8.0;

 
contract sharedWallet {

    event DepositFunds(address from, uint amount);
    event WithdrawFunds(address from, uint amount);
    event TransferFunds(address from, address to, uint amount);

    address private _owner;

    //the creator is the owner of the wallet
    constructor() {
        _owner = msg.sender;
    }

    //create a mapping so other addresses can interact with this wallet.
    mapping(address => uint8) private _owners;


    //in order to interact with the wallet you need to be the owner so added a require statement then execute the function _;
    modifier isOwner() {
        require(msg.sender == _owner || _owners[msg.sender] == 1, "Not a owner");
        _;
    }

   
    //this function is used to add owners of the wallet.  Only the isOwner can add addresses.  1 means enabled
    function addOwner(address owner) 
        isOwner 
        public {
        _owners[owner] = 1;
    }

    
    //remove an owner from the wallet.  0 means disabled
    function removeOwner(address owner)
        isOwner
        public {
        _owners[owner] = 0;   
    }

    
    //Anyone can deposit funds into the wallet and emit an event called depositfunds
    function getPayment()
        external
        payable {
        emit DepositFunds(msg.sender, msg.value);
    }

    
    //to withdraw you need to be an owner, the amount needs to be >= balance of acct.  then transfer and emit an event
    function withdraw (uint amount)
        isOwner
        public {
        require(address(this).balance >= amount);
        payable(msg.sender).transfer(amount);
        emit WithdrawFunds(msg.sender, amount);
    }

    // function transfer 
    function transferTo(address payable to, uint amount) 
        isOwner
        public {
        require(address(this).balance >= amount);
        to.transfer(amount);
        emit TransferFunds(msg.sender, to, amount);
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