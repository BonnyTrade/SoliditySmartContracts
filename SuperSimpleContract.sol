// SPDX - License-Indentifier:Mit 

pragma solidity ^0.8.15;

contract simpleContract { 

    uint private age;
    string private name;

    //set 

    function setName ( string memory _name) public { 
        name = _name;
    }

    function setAge ( uint _age ) public {
        age = _age;
    }

    //get 

    function getName () public view returns ( string memory ) { 
        return name;
    }

    function getAge () public view returns ( uint ) { 
        return age;
    }
}



/*

You can ask some questions in our Telegramm Chat - https://t.me/+3KEwJhVlSxUyY2Qy

My OpeanSean NFT - https://opensea.io/BonnyNFT

I reccomend Binance - https://accounts.binance.com/ru/register?ref=PZ2B9P6V
I reccomend ByBit - https://www.bybit.com/ru-RU/invite?ref=WMMJGM
I reccomend ByBit GATE.IO - https://www.gate.io/signup/12859730

Create Trade Bots Here - https://3commas.io/?c=tc514514

You can buy Stocks Apple, Netflix here  - https://currency.com/trading/signup?c=6cknw8a6&pid=referral

Grow your crypto securely with Ledger - https://shop.ledger.com?r=bd3c85107f00

You can Support me,  with crypto Transaction 
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
