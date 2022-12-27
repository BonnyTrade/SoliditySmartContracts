// Remix IDE link - //https://remix.ethereum.org

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 

contract Multisender is Ownable { 

    IERC20 public token; 

    constructor (  address _token ) { 
        require ( _token != address(0), "ZERRO address");
        token = IERC20(_token);
    }

    function changeToken ( address _address ) external onlyOwner { 
        require ( _address != address(0), "ZERRO address");
        token = IERC20(_address);
    }

    // function sender with similar amount 
    function senderSimilarAmount ( address[] memory _addresses, uint amount ) external onlyOwner { 
        for ( uint i = 0; i < _addresses.length; i++) {
            require(_addresses[i] != address(0), "zerro address!");
            token.transferFrom(msg.sender, _addresses[i], amount);
        }
    }

    // function sender with different amount 
    function senderDifferentAnount ( address[] memory _addresses, uint[] memory amount ) external onlyOwner { 
        require ( _addresses.length == amount.length , " REJECTED" ); 
            for ( uint i = 0 ; i < amount.length; i++ ){ 
                require(_addresses[i] != address(0), "zerro address!");
                token.transferFrom(msg.sender, _addresses[i], amount[i]); 
            }
    }

}


//     Addresses Array 
// [
//     "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//     "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
//     "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
//     "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//     "0x617F2E2fD72FD9D5503197092aC168c91465E7f2",
//     "0x17F6AD8Ef982297579C203069C1DbfFE4348c372",
//     "0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678",
//     "0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7",
//     "0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
//     "0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC",
//     "0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c",
//     "0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C",
//     "0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB",
//     "0x583031D1113aD414F02576BD6afaBfb302140225"
// ]


//   Amount Array 
// [
//      5,
//      10,
//      15,
//      25,
//      50,
//      55,
//      25,
//      75,
//      12,
//      34,
//      37,
//      81,
//      45,
//      32  
// ]

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