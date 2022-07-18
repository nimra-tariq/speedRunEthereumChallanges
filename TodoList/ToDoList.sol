// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ToDoList {

    using SafeMath for uint256;

    struct Task {
        string name;
        string description;
        string status;
    }
    
    //map user address with task list (array)
    mapping(address=>Task[]) public tasks;
    
    //add new task
    function addTask(string memory _name,string memory _description, string memory _status) public{
        tasks[msg.sender].push(Task(_name,_description,_status));
    }

    //update task status
    function updateTask(uint256 _taskNo,string memory _status) public{
        tasks[msg.sender][_taskNo].status=_status;
    }

    //view task list of the caller
    function viewAllTasks() public view returns(Task[] memory taskList){
        return tasks[msg.sender];
    }

}