// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract dBank {

  //assign Token contract to variable
  Token private token;
  //add mappings
  mapping (address => uint) public etherBalanceOf;
  mapping (address => uint) public depositStart;
  mapping (address => bool) public isDeposited;
  
  
  //add events
  event Deposit(address indexed user, uint etherAmount, uint timeStart);
  event Withdraw(address indexed user, uint etherAmount, uint depositTime, uint interest);
  
  

  //pass as constructor argument deployed Token contract
  constructor(Token _token) public {
    //assign token deployed contract to variable
    token = _token;

  }

  function deposit() payable public {
    //check if msg.sender didn't already deposited funds
    //check if msg.value is >= than 0.01 ETH

    require(isDeposited[msg.sender] == false, "Error, Should be true");
    require(msg.value >= 1e16, "Error, should be >= 0.01 ETH");
    
    etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender] + msg.value;
    depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;
    isDeposited[msg.sender] = true;
    emit Deposit(msg.sender, msg.value, block.timestamp);

    //increase msg.sender ether deposit balance
    //start msg.sender hodling time

    //set msg.sender deposit status to true
    //emit Deposit event
  }

  function withdraw() public {
    //check if msg.sender deposit status is true

    require(isDeposited[msg.sender] == true," Error, did not deposit");
    uint userBalance = etherBalanceOf[msg.sender];
    
    //assign msg.sender ether deposit balance to variable for event
    uint depositTime = block.timestamp - depositStart[msg.sender];

    //check user's hodl time

    //calc interest per second
    //calc accrued interest
    uint interestPerSecond = 31668017*(etherBalanceOf[msg.sender]/1e16);
    uint interest = interestPerSecond*depositTime;

    //send eth to user
    msg.sender.transfer(userBalance);
    token.mint(msg.sender, interest);
    //send interest in tokens to user

    //reset depositer data
    etherBalanceOf[msg.sender] = 0;
    depositStart[msg.sender] = 0;
    isDeposited[msg.sender] = false;
    //emit event
    emit Withdraw(msg.sender, userBalance , depositTime, interest);
  }

  function borrow() payable public {
    //check if collateral is >= than 0.01 ETH
    //check if user doesn't have active loan

    //add msg.value to ether collateral

    //calc tokens amount to mint, 50% of msg.value

    //mint&send tokens to user

    //activate borrower's loan status

    //emit event
  }

  function payOff() public {
    //check if loan is active
    //transfer tokens from user back to the contract

    //calc fee

    //send user's collateral minus fee

    //reset borrower's data

    //emit event
  }
}