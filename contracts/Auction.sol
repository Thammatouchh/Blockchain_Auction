// SPDX-License-Identifier: MIT
pragma solidity >0.4.0 <0.9.0;

contract Auction {
    mapping(address => uint) biddersData;
    uint public highestBidAmount;
    address public highestBidder;
    address owner;
    uint startTime=block.timestamp;
    uint endTime;
    bool auctionEnded=false;
        constructor(){
            owner=msg.sender;
        }

    // put new bid
    function putBid() public payable {
        // Verify value is greater than zero
        require(msg.value > 0, "Add the amount before the Bid");
        // Check Session is Not ended
        require(auctionEnded==true,"Auction is Ended");
        require(block.timestamp<=endTime,"Auction is Ended");

        // Calculate the new bid amount
        uint calculateAmount = biddersData[msg.sender] + msg.value;

        // Check if the new bid amount is higher than the current highest bid
        require(calculateAmount > highestBidAmount, "Bid must be higher than the current highest bid");
        
        // Update bid amount, highest bid amount, and highest bidder
        biddersData[msg.sender] = calculateAmount;
        highestBidAmount = calculateAmount;
        highestBidder = msg.sender;
    }

    // Get a specific bidder's bid amount
    function getBiddersBid(address _address) public view returns (uint) {
        return biddersData[_address];
    }

    // Get the highest bid amount
    function getHighestBid() public view returns (uint) {
        return highestBidAmount;
    }

    // Get the address of the highest bidder
    function getHighestBidder() public view returns (address) {
        return highestBidder;
    }

    //put endtime
    function putEndTime(uint _endTime) public{
        endTime=_endTime;

    }

    //put endTime
    function endAuction() public {
        if(msg.sender==owner){
            auctionEnded=true;
        }
    }
    
    //withdraw bid
    function withdrawBid(address payable  _address) public {
    if(biddersData[_address]>0){
        _address.transfer(biddersData[_address]);
    }

     }
    
}
