pragma solidity ^0.8.0;

//A game where the 7th person that deposit ether wins all the ether in the contract
//the winner will auto claim the 7 ether

contract EtherGame {

    uint public constant targetAmount = 7 ether;
    uint public balance;
    address public winner;
 
    //to play you need to call the deposit function and send 1 ether
    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");
        
        balance+= msg.value;
        
        if (balance == targetAmount) {
            winner = msg.sender;
            claimReward();
            balance = 0;
        }
    }

    // function auto calimReward
    function claimReward() internal {
        payable (winner).transfer(balance);
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