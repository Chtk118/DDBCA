// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract EtherTransfer {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    // Function to transfer Ether to a specific address
    function sendEther(address payable recipient) public payable {
        require(msg.value > 0, "Send some Ether");
        recipient.transfer(msg.value);
    }
    // Fallback function to accept Ether
    receive() external payable {}
}