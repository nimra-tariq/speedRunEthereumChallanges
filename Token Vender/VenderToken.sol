// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
pragma solidity ^0.8.2;

contract VenderToken is ERC20 {
    constructor() ERC20("Vendor","VT"){
        //mint is an internal function can be called in derived contract
        //1000 token and 10**18 18 decimals
        _mint(msg.sender,1000*(10**18));
    } 
}