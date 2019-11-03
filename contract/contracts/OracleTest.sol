// pragma solidity ^0.4.24;
pragma solidity >=0.4.24 <0.5.12;

import "github.com/provable-things/ethereum-api/provableAPI_0.4.25.sol";

contract OracleTest is usingProvable  {
    address public owner;
    string public data;
    string public ethPrice;

    event LogConstructorInitiated(string nextStep);
    event LogPriceUpdated(string price);
    event LogNewProvableQuery(string description);

    constructor() public {
        owner = msg.sender;
        emit LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Provable Query.");
    }

    function getData() public view returns(string memory){
        return data;
    }

    function getPrice() public view returns(string memory){
        return ethPrice;
    }

    function __callback(bytes32 myid, string result) public {
        require(msg.sender == provable_cbAddress(), "caller should be the one making the Provable request");
        ethPrice = result;
        emit LogPriceUpdated(result);
    }

    function updatePrice() public payable {
        if (provable_getPrice("URL") > this.balance) {
            emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewProvableQuery("Provable query was sent, standing by for the answer..");
            provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
        }
    }
    
    

}