// SPDX - License-Indentifier:Mit 
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; 
//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol

import "@openzeppelin/contracts/access/Ownable.sol"; 
//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Drop is Ownable { 

    //We need Token that we will call , so let's create interface for our Token;
    IERC20 public token;

    //Bool Mapping To understand, each adress got AirDrop or NO. If Bool True = Airdrop Get, If false = NOT Get; 
    mapping ( address => bool ) public verification;

    // uint variable = how much tokens we will send for each address;
    uint public dropAmount; 

    // even creation for Transfer DropToken 
    event TransferDrop ( address _to , uint amount);
    event Withdraw ( address _to, uint amout);

    //in constructor we will set token address,that we will call. And dropAmount value; With 0 address require;
    constructor (address _token, uint _dropAmount) { 
        require(address(_token) != address(0), " REJECTED with 0 Address");
        token = IERC20(_token);
        dropAmount =_dropAmount;
    } 

    //function getDrop 
    function getDrop () external { 
        require(verification[msg.sender] != true , "aleady claim AirDrop");
        require(msg.sender != address(0), "Rejected with 0 address");
        verification[msg.sender] = true;
        token.transfer(msg.sender, dropAmount);
        emit TransferDrop ( msg.sender, dropAmount);
    }

    // function that return amount Of Tokens that are not Droped Yet;
    function getBalance () public view onlyOwner returns ( uint )  { 
        return token.balanceOf(address(this));
    }

    //function withdrow , we need this function if some tokens are not droped and some tokens remained
    function withdraw () external onlyOwner {
        uint remainedAmount = getBalance();
        require(remainedAmount > 0 , " Not Enough Remained Tokens");
        token.transfer( owner() , remainedAmount );
        emit Withdraw ( owner(), remainedAmount);
    }

    // function that will change dropAmount;
    function dropAmountChange ( uint _amount ) external onlyOwner { 
        require(_amount > 0 , " REJECTED 0 amount ");
        dropAmount = _amount;
    }

    //function for Token address change, this need to be  our contract multipurpose;
    function changeToken ( address _newTokenAdress ) external onlyOwner { 
        token = IERC20(_newTokenAdress);
    }

    //function that allow for Owner to change status for Dropper, 
    //for example we can provide for Dropper the second   opportunity to take Drop;
    function changeVerification ( address _dropper) external onlyOwner { 
        verification[_dropper] = false;
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