
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ExampleExternalContract {

  bool public completed;

  function complete() public payable {
    completed = true;
  }

  function contractBal() public view returns(uint256 balance) {
    return address(this).balance;
  }

}