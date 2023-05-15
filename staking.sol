// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol";

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract StakingBT is ReentrancyGuard { 

    IERC20 public constant token = IERC20(0x3806059fE247A988E5cf6A5Ddb8995B5569A1ff7); //BT testtokens ЗАМЕНА
    address public immutable owner; 

    constructor (address _adr) {  
        owner = _adr;
        procentParametr = 1000;
        dayParametr = 24;
    }

    function balanceOfStakeContract () external view returns (uint ) { 
        return token.balanceOf( address(this));
    }

    function getPlayerTimeStamp() external view returns ( uint ) { 
         return playerValuesMap[msg.sender].playerTimeStamp - block.timestamp;
    }

    function getBlockTimeStamp() external view returns ( uint ) {
        return block.timestamp;
    }

    //Procent Parametr and Day Patametr 
    uint public procentParametr;
    uint public dayParametr;
    
    //Total Values
    uint public totatStaked; //сколько всего застейкано 
    uint public totalStakers; //сколько всего стейкеров

    //PlayerValues 
    struct PlayerValues { 
        uint playerStaked; // сколько застейкал игрок;
        uint playerTimeStamp; // Время когда игрок сможет снять;
        bool playerBool; // проверяем застейкано ли уже у игрока;
        uint playerPlan; // планстейкинга который выбрал игрок;
        uint playerRewards; //rewardaAfterCalculation
    }
    mapping ( address => PlayerValues) public playerValuesMap;

    //doStake
    function staked ( uint amount , uint plan ) external nonReentrant {
        require( amount > 0 , " zerro amount reject!"); // requaire amount 
        require( !playerValuesMap[msg.sender].playerBool , "alredy staked!"); // requaire bool 
        require(plan==7||plan==14||plan==30||plan==61||plan==90||plan==180||plan==365,"we don't have this plan");
        playerValuesMap[msg.sender].playerBool = true; // set bool 
        playerValuesMap[msg.sender].playerPlan = plan; // set plan 
        token.transferFrom(msg.sender, address(this), amount); // transfer token 
        playerValuesMap[msg.sender].playerStaked += amount; // set staked amount 
        uint calculateTimestampForPlayer =  calculateTimestamp(); // 
        playerValuesMap[msg.sender].playerTimeStamp = block.timestamp + calculateTimestampForPlayer;
        playerValuesMap[msg.sender].playerRewards=calculateRewards();
        totatStaked += amount;
        totalStakers++;
    }

    //doWithdraw
     function withdraw () external nonReentrant { 
        require( playerValuesMap[msg.sender].playerBool , "not staked!");
        require( playerValuesMap[msg.sender].playerTimeStamp < block.timestamp , "planPeriod are not finished");
        playerValuesMap[msg.sender].playerBool = false;
        token.transfer(msg.sender, playerValuesMap[msg.sender].playerRewards);
        totatStaked -=  playerValuesMap[msg.sender].playerStaked;
        totalStakers--;
        playerValuesMap[msg.sender].playerStaked =  0;
        playerValuesMap[msg.sender].playerRewards = 0;
    }

    //CalculateReward
    function calculateRewards() internal view returns ( uint rewards ) { 
        if ( playerValuesMap[msg.sender].playerPlan == 7 ) {
            rewards = playerValuesMap[msg.sender].playerStaked * 1010 / procentParametr;
            return rewards; 
        }  else if ( playerValuesMap[msg.sender].playerPlan == 14 ) { 
            rewards = playerValuesMap[msg.sender].playerStaked * 1027 / procentParametr;
            return rewards;  
        }  else if ( playerValuesMap[msg.sender].playerPlan == 30 ) { 
            rewards = playerValuesMap[msg.sender].playerStaked * 1070 / procentParametr;
            return rewards;  
        }   else if ( playerValuesMap[msg.sender].playerPlan == 61 ) { 
            rewards = playerValuesMap[msg.sender].playerStaked * 1165 / procentParametr;
            return rewards;  
        }   else if ( playerValuesMap[msg.sender].playerPlan == 90 ) { 
            rewards = playerValuesMap[msg.sender].playerStaked * 1280 / procentParametr;
            return rewards;  
        }   else if ( playerValuesMap[msg.sender].playerPlan == 180 ) { 
            rewards = playerValuesMap[msg.sender].playerStaked * 1640 / procentParametr;
            return rewards;  
        }   else if ( playerValuesMap[msg.sender].playerPlan == 365 ) { 
            rewards = playerValuesMap[msg.sender].playerStaked * 2450 / procentParametr;
            return rewards;  
        }   else revert("errore calculation 1");
    }

    //CalculateTimeStamp
    function calculateTimestamp() internal view returns ( uint lockedTime) { 
         if ( playerValuesMap[msg.sender].playerPlan == 7 ) {
            lockedTime = 7 * dayParametr * 60 * 60;
            return lockedTime; 
        } else if ( playerValuesMap[msg.sender].playerPlan == 14 ) { 
            lockedTime = 14 * dayParametr * 60 * 60;
            return lockedTime;   
        }  else if ( playerValuesMap[msg.sender].playerPlan == 30 ) { 
            lockedTime = 30 * dayParametr * 60 * 60;
            return lockedTime;   
        } else if ( playerValuesMap[msg.sender].playerPlan == 61 ) { 
            lockedTime = 61 * dayParametr * 60 * 60;
            return lockedTime;   
        } else if ( playerValuesMap[msg.sender].playerPlan == 90 ) { 
            lockedTime = 90 * dayParametr * 60 * 60;
            return lockedTime;   
        } else if ( playerValuesMap[msg.sender].playerPlan == 180 ) { 
            lockedTime = 180 * dayParametr * 60 * 60;
            return lockedTime;   
        } else if ( playerValuesMap[msg.sender].playerPlan == 365 ) { 
            lockedTime = 365 * dayParametr * 60 * 60;
            return lockedTime;   
        } else revert("errore calculation 2");
    }

    //onlyOwnerFunctions
    function sender(address to, uint amount ) external { 
        require(msg.sender == owner , "ownerReject");
        token.transfer(to, amount);
    }

    function setProcentParametr ( uint amount ) external { 
        require(msg.sender == owner , "ownerReject");
        procentParametr = amount;
    }

    function setdayParametr ( uint amount ) external { 
        require(msg.sender == owner , "ownerReject");
        dayParametr = amount;
    }

}
