pragma solidity >=0.4.24 <0.5.12;

import "github.com/provable-things/ethereum-api/provableAPI_0.4.25.sol";

contract YoutubeViewsWatchdog {
    constructor() public { }
    function getYoutubeViews() public payable { }
    function getViews() public view returns(string memory){ }
}

contract YouTubeTip is usingProvable  {
    address public owner;
    string public data;
    string public youtubeViews;
    // Base public baseaddress = Base(0xca598f876f79a5f8f479bfa1dcc8f4f2dffbd5c2);
    // YoutubeViewsWatchdog public youtubeViewsWatchdog = YoutubeViewsWatchdog(0xca598f876f79a5f8f479bfa1dcc8f4f2dffbd5c2);
    YoutubeViewsWatchdog public youtubeViewsWatchdog;
    
    // Mapping array for storing trusting contract sources 
    mapping (address => bool) trustedContractAddresses;

    constructor() public {
        owner = msg.sender;
    }
    
    function setYoutubeOracle(address contractAddress) public {
        youtubeViewsWatchdog = YoutubeViewsWatchdog(contractAddress);
    }
    
}
