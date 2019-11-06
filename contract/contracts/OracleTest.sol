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

}
