pragma solidity >=0.4.24 <0.5.12;

contract Trash {
    mapping (string => bool) dict;
    address owner;

    constructor () public{
        owner = msg.sender;
    }

    function addValue(string memory bob) public returns(bool) {
        dict[bob] = true;
        return true;
    }
}
