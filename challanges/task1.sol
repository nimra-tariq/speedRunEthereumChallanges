// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Task1{

    struct Student {
        string name;
        uint256 cnic;
    }
    mapping(uint256=>Student) studensts;

    function setStudent(uint256 _rollNo , string memory _name, uint256 _cnic ) public {
        studensts[_rollNo].name= _name;
        studensts[_rollNo].cnic=_cnic;
    }

    function getStudent(uint256 _rollNo) public view returns(Student memory){
        return studensts[_rollNo];
    }
}