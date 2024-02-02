// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Thrift {

    address owner;

    mapping(address => uint256)  public  _balance;

    struct Person {
        address owner;
        uint256 amount;
    }
    
    constructor(){
        owner = msg.sender;
    }
    
    // Deposit function section
    function deposit() external payable {
        require(msg.value == 1 ether, "You can contribute");
        _balance[msg.sender] += msg.value;
    }

    // you can only withdraw your contribution
    function withdrawal() public {
        require(_balance[msg.sender] >= 2 ether, "Contribution is not yet complete");
        payable(msg.sender).transfer(_balance[msg.sender]);
        _balance[msg.sender] = 0;
    }
}
