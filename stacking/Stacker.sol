// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  //mapping balances investors to their donation funds
  mapping (address=>uint256) public balances;
  uint256 public constant threshold = 1 ether;
  uint256 deadline = block.timestamp + 60 seconds;

  //stack event
  event Stake(address investor, uint256 stack);

  //modifier thresholdMet
  modifier thresholdMet(){
    require(address(this).balance>=threshold,"threshold not met");
    _;
  }

  //modifier deadlineExceeded
  modifier deadlineExceeded(){
    require(block.timestamp>deadline,"deadline not exceeded yet");
    _;
  }

  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  // ( Make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
  function stake() public payable{
   uint256 stack = msg.value;
   balances[msg.sender]=stack;
   emit Stake(msg.sender,stack);
  }

  // After some `deadline` allow anyone to call an `execute()` function
  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
  function execute() deadlineExceeded thresholdMet public{
    exampleExternalContract.complete{value:address(this).balance}();
  }

  // If the `threshold` was not met, allow everyone to call a `withdraw()` function
  // Add a `withdraw()` function to let users withdraw their balance
  function withdraw() deadlineExceeded public {
    require(address(this).balance<threshold,"threshold met you can't withdraw");
    require(balances[msg.sender]!=0,"you havn't contributed");
    payable(address(msg.sender)).transfer(balances[msg.sender]);
    delete balances[msg.sender];
  }

  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  function timeLeft() public view returns(uint second){
    return (block.timestamp>deadline) ?  0 seconds :  deadline-block.timestamp;
  }

  // Add the `receive()` special function that receives eth and calls stake()
  receive() external payable{
    stake();
  }

   function amountStacked() public view returns(uint256 stack) {
    return address(this).balance;
  }

}