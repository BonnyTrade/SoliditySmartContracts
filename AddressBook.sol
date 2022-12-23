// SPDX - License-Indentifier:Mit 

pragma solidity ^0.8.15;


contract AddressBook { 

    //maps an address to an address array
    //As an example your address to a list of addresses you are interested in.  This supports multiple people having an address book
    mapping ( address => address[] ) private _addresses;

    //maps an address to another map of address to a string
    //example - your address mapped to a mapping of your address book to its alias
    mapping ( address => mapping ( address => string )) private _aliases;

    //returns the list of addresses in the _addresses map
    function gatAddressArray ( address _adr ) public view returns ( address[] memory ) { 
        return _addresses[_adr];
    }

    //Gets the alias for your address
    function getAliase ( address _adrOne, address _adrTwo ) public view returns ( string memory ) {
        return _aliases[_adrOne][_adrTwo];
    }

    //get Length og Array
    function getArrayLength () public view returns ( uint ) { 
        return _addresses[msg.sender].length;
    }

    //adds address to your list of addresses in the _addresses map.
    //Uses push since it is an array
    //adds your address, address and alias to the _aliases map
    function addAddresses ( address _adr, string memory _aliace ) public { 
        _addresses[msg.sender].push(_adr);
         _aliases[msg.sender][_adr] = _aliace;
    }

    function removeAddress( address _adr ) public { 
        // get the length of the addresses in the array from the msg sender
        uint theLength = _addresses[msg.sender].length;
        for(uint i=0; i< theLength; i++) {
            // if the address that you want to remove = one of the addresses you own 
            //and is one of the iterations of the loop
            if ( _adr == _addresses[msg.sender][i] ) { 
                //once we find the item in the array we need to delete the item
                //then shift each item down 1.  You can't just delete an item in the middle of an array
                //make sure the length of the address is not < 1 (this is needed because we are going to reorder the array)
                if ( _addresses[msg.sender].length > 1 && i < theLength - 1 ) {
                    //shift the last item in the array to the position of the item that we are removing
                    _addresses[msg.sender][i] = _addresses[msg.sender][theLength - 1];
                }

                // delete the item we just swapped from
                delete _addresses[msg.sender][theLength - 1];
                //then decrement the length of the array by 1
                _addresses[msg.sender].pop();
                //delete the alias for it
                delete _aliases[msg.sender][_adr];
                
                break;

            } 
        }
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