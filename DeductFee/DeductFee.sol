// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FeeDeduction is Ownable,ERC20 {

    using SafeMath for uint256;

    //contructor 
    constructor(uint256 _initialSupply) ERC20("FeeDeduction","FDT") Ownable() {
        _mint(_msgSender(),_initialSupply);
    } 


    function _deductFee(address from, address to, uint256 amount ) private {
        
        //transfer 10% to owner
        uint256 ownerFee=amount * 5/100;
        _transfer(from, owner(), ownerFee);

        //burn 5% of the sender
        uint256 burnAbleFee=amount * 5/100;
        _burn(from,burnAbleFee);

        //transfer remaining to the receiver
        _transfer(from, to, amount-(ownerFee+burnAbleFee));

    }

    //over ride ERC20 transferFrom function

        function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _deductFee(from,to,amount);
        return true;
    }

    //over riding erc20 transfer function

      function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _deductFee(owner,to,amount);
        return true;
    }
}