// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FunctionModifierDemo {
    address public owner;
    bool public locked;
    uint public x = 10;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier noReentrancy() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Zero address");
        owner = _newOwner;
    }

    function decrement(uint i) public noReentrancy {
        x -= i;
        if (i > 1) {
            decrement(i - 1);
        }
    }
}
