// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;
contract HelloWorld {
    event messageChanged(string oldMessage, string newMessage);
    string private message = "No tengo mensaje";

    function getMessage() public view returns(string memory) {
        return message;
    }

    function setMessage(string calldata _message) public {
        emit messageChanged(message, _message);
        message = _message;
    }
}