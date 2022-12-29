// SPDX - License-Indentifier:Mit 

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";

contract ICOShop is Ownable { 

    BonnyToken public token; 
    uint public rate; 

    constructor ( uint tokenAmount , uint rateAmount ) { 
        createTokenForSell(tokenAmount);
        changeOwnerToken(msg.sender);
        rate = rateAmount; 

    }

    // function that will deploy our token
    function createTokenForSell ( uint _valueTokenForSale ) internal onlyOwner {
        BonnyToken newBonnyToken = new BonnyToken(_valueTokenForSale);
        token = BonnyToken(address(newBonnyToken));
    }

    //change Owner Function 
    function changeOwnerToken ( address _newOwner ) internal onlyOwner { 
        token.transferOwnership(_newOwner );
    }


    // get token balance on this contract 
    function tokenBalance () public  view returns ( uint ) { 
        return token.balanceOf(address(this));
    }
    // get this contract balance eher 
    function etherBalance () public view returns ( uint ) { 
        return address(this).balance;
    }
    // new address token function 
    function newToken ( address _adr ) external  onlyOwner { 
        require(_adr != address(0) , "Zerro Address!");
        token = BonnyToken(_adr);
    }
    // new Rate function
    function newRate ( uint amount )  external onlyOwner { 
        require(amount > 0 , "Rejected with 0 amount ");
        rate = amount;
    }
    //func withdraw all tokens if they are not selling 
    function tokenWithdraw () external onlyOwner { 
        require( tokenBalance() > 0 , " 0 amount of tokenBalance ");
        token.transfer(owner(), tokenBalance());
    }
    //func withdraw etherum from contract 
    function etherWithdrwaw () external onlyOwner { 
        require( address(this).balance > 0 , " 0 amount of contract balance ");
        payable(owner()).transfer(address(this).balance);
    }
    //buyToken Funciton 
    function buyToken () external payable {
        require(msg.value > 0 , " Rejected ");
        uint tokensAmount = msg.value / rate; 
        require( tokensAmount <= tokenBalance (), " Rejected " );
        token.transfer(msg.sender, tokensAmount);
    }
    //sellToken Function
    function sellToken ( uint _tokenAmount ) external { 
        uint allowanceToken = token.allowance(msg.sender, address(this));
        uint etheramount = _tokenAmount * rate; 
        require( allowanceToken >= _tokenAmount, "rejected "); 
        token.transferFrom(msg.sender , address(this), _tokenAmount);
        payable(msg.sender).transfer(etheramount);
    }

}

/*
                    ╔═════════════════════════════╗
                    ║       ADDITIONAL LINKS      ║
                    ╚═════════════════════════════╝

📹BonnyCrypto YouTube - https://www.youtube.com/channel/UC5M97bGzgZPC1w1jch4S7nQ
💬You can ask some questions in our Telegramm Chat - https://t.me/+3KEwJhVlSxUyY2Qy

💥My OpeanSean NFT - https://opensea.io/BonnyNFT

💸I reccomend Binance - https://accounts.binance.com/ru/register?ref=PZ2B9P6V
💸I reccomend ByBit - https://www.bybit.com/ru-RU/invite?ref=WMMJGM
💸I reccomend GATE.IO - https://www.gate.io/signup/12859730

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