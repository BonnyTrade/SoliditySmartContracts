// SPDX - License-Indentifier:Mit 
pragma solidity ^0.8.15;

contract Granny { 

    // counter of grandchildren
    uint8 public counter;

    // Granny Deposit 
    uint public bank; 

    //Granny address ( owner ) 
    address public owner; 

    //grandchildren structure 
    struct Grandchild { 
        string name;
        uint birthday;
        bool alreadyGotMoney;
        bool exist; 
    }

    //array to save address of each grandchilren
    address[] public arrGrandchildren; 

    // mapping that connect addreass of grandchild with grandchild structure
    mapping ( address => Grandchild ) public grandchilds;

    // constructor 
    constructor () { 
        owner = msg.sender; 
        counter = 0; 
    }

    //receive money function 
    receive() external payable {
        bank+=msg.value;
    }

    //balcance of contract function 
    function balanceOf () public view returns ( uint ) { 
        return address(this).balance; 
    }

    // onlyOwner modificator 
    modifier onlyOwner () {
        require(msg.sender == owner , " You are not owner ");
        _;
    }

    // add Grandchild function 
    function addGrandChild ( 
        address walletAddress, 
        string memory name, 
        uint birthday
    ) public onlyOwner { 
        require (birthday > 0 , " SomethingWronf with Birthday Date ");
        require(grandchilds[walletAddress].exist == false, " There Already such a Granchild ");

        grandchilds[walletAddress] = Grandchild(name, birthday, false, true );

        arrGrandchildren.push(walletAddress);
        counter++;        
    }


    // withdraw function 
    function withdraw () public  { 
        address payable walletAddress = payable(msg.sender);

        require(bank >0 ," Sorry, Bank is 0 ");

        require(grandchilds[walletAddress].exist == true, " There is no such Grandchild!");

        require(grandchilds[walletAddress].birthday <= block.timestamp, " Birthday hasn't Arrived yet ");

        require(grandchilds[walletAddress].alreadyGotMoney == false, "You have Already received Money");

        uint amount = bank/counter; 
        grandchilds[walletAddress].alreadyGotMoney == true;

        (bool sucess, ) = walletAddress.call{value: amount }("");
        require(sucess);
    
    }

    // function read Array Grandchilds 
    function readChildsArray ( uint start , uint length ) public view returns ( address[] memory ) { 
        address[] memory array = new address[](length);
        uint counter2 = 0;
        for ( uint i = start ; i < start + length; i ++) { 
            array[counter2] = arrGrandchildren[i];
            counter2++;
        }
        return array;
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