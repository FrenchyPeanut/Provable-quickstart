pragma solidity >=0.4.24 <0.5.12;

import "github.com/provable-things/ethereum-api/provableAPI_0.4.25.sol";

contract YouTubeViewsWatchdog is usingProvable  {
    address public owner;
    string public youtubeViews;
    mapping (bytes32 => bool) validProvableId;
    event LogConstructorInitiated(string nextStep);
    event LogNewProvableQuery(string description);
    event LogYoutubeViewCountUpdated(string views);
    uint public test = 0;

    constructor() public {
        owner = msg.sender;
        emit LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Provable Query.");
    }

    function getViews() public view returns(string memory){
        return youtubeViews;
    }

    function __callback(bytes32 myid, string result) public {
        require(validProvableId[myid], "Error, the Provable query ID doesn't exist in the contract history");
        require(msg.sender == provable_cbAddress(), "caller should be the one making the Provable request");
        youtubeViews = result;
        test++;
        // Once the query is exectuted, we can remove it from our history:
        validProvableId[myid] = false;
        emit LogYoutubeViewCountUpdated(result);
    }

    function getYoutubeViews() public payable {
        // Use of this.balance is deprecated . . . if (provable_getPrice("URL") > this.balance) {
        if (provable_getPrice("URL") > address(this).balance) {
            emit LogNewProvableQuery("Error with the Provable query; not enough ETH to cover for the query fee");
        } else {
            emit LogNewProvableQuery("Provable query sent, standing by for the answer. . ."); // view-count style-scope yt-view-count-renderer
            // provable_query("URL", 'html(https://www.youtube.com/watch?v=9bZkp7q19f0).xpath(//*[contains(@class, "watch-view-count")]/text())');
            // first value in the query allows for a timer; interesting for callbacks and query repeats
            bytes32 currentQueryId = provable_query("URL", 'html(https://www.youtube.com/watch?v=BoJzfHKNpyk).xpath(//*[contains(@class, "watch-view-count")]/text())');
            // bytes32 currentQueryId = provable_query("URL", 'html(https://www.youtube.com/watch?v=BoJzfHKNpyk).xpath(//*[contains(@class, "yt-view-count-renderer")]/text())');
            validProvableId[currentQueryId] = true;
        }
    }
}
