// SPDX-License-Indentifier: MIT

// Stating the pragma is necessary to prevent compilation problems in
// future releases of the solidity compilier. This is a standard thing many'
// programming languages have.

// The ^ is used to denote compatability with all subversions of 0.8.X
pragma solidity ^0.8.3;

// Counters: a simple way to get a counter that can only be incremented or decremented. 
// Very useful for ID generation, counting contract activity, among others.
import "@openzeppelin/contracts/utils/Counters.sol";

// Provides a function modifier that protects agianst function reentrancy
// Reentrancy is when a vunerable function is executed that calls an external contract
// This contract then can call the same or other functions in your smart contract
// to take advantage of logic that has not been executed yet.
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFTMarket is ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _itemsIds;
    Counters.Counter private _itemsSold;

    // Payable means addresses of functions can receive Ether
    address payable owner;

    // ether is a type of unit. 1 ether = 1e18 gwei, it takes a int to some power basically
    uint256 listingPrice = 0.025 ether;

    constructor() {
        owner = payable(msg.sender);
    }

    struct MarketItem {
        uint itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
     }

     mapping(uint256 => MarketItem) private idToMarketItem;

     // ended here 7/8/2021 cashd

}




