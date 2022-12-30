pragma solidity ^0.8.0;

contract HotelRoom { 

    //create an emun with 2 status so we can keep track of our hotel room
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus; 

    
    
    //create an event to owner, owner need information about one who rented and amount of money
    event Occupy ( address _occupant, uint _value);

    // owner variable, constructor, and current room status

    address public  owner;
    address public tenant; 

    constructor () { 
        owner = msg.sender; 
        currentStatus = Statuses.Vacant;
    }

    // modificator if only Vacant , we get payment; 
    modifier onlyWhileVacant { 
        require(currentStatus == Statuses.Vacant, " Currently Occupied");
        _;
    }

    // Room price Modificator 
    modifier price ( uint _amount ) { 
        require(msg.value >= _amount, "Not enough Money!");
    _;
    }

    // recive function , owner will get money, the Room status will be Occupied
    receive () external payable onlyWhileVacant price( 2 ether ) {
        currentStatus = Statuses.Occupied;
        payable(owner).transfer(msg.value);
        emit Occupy (msg.sender, msg.value);
        tenant = msg.sender;
        

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
