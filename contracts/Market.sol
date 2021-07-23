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
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    mapping(uint256 => MarketItem) private idToMarketItem;

    // Event when Market item is created
    event MarketItemCreated(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    // We are using external here bc external modifier is cheaper than public
    // Sacrificing internal calls for cheaper gas because external functions
    // Read directly from CALLDATA and the parameters do not have to be assigned in memory
    function getListingPrice() external view returns (uint256) {
        return listingPrice;
    }

    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        require(price > 0, "Price must be greater than zero!");
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );

        _itemsIds.increment();
        uint256 itemId = _itemsIds.current();

        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );

        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

        emit MarketItemCreated(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );
    }

    // Function to sell the NFT to a buyer
    // Transfers ownship of the item and pays the original owner
    function createMarketSale(address nftContract, uint256 itemId)
        public
        payable
        nonReentrant
    {
        uint256 price = idToMarketItem[itemId].price;
        uint256 tokenId = idToMarketItem[itemId].tokenId;

        require(price == msg.value);

        // Paying the seller
        idToMarketItem[itemId].seller.transfer(msg.value);

        // Transfering funds
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);

        // Setting owner in market place to new owner
        idToMarketItem[itemId].owner = payable(msg.sender);

        // Set item sold as true
        idToMarketItem[itemId].sold = true;
        _itemsSold.increment();

        // Sends listing price (in ETH) to owner of contract
        payable(owner).transfer(listingPrice);
    }

    // Returns all unsold market items
    // This function could be improved a bit by using pagination
    function fetchMarketItems() public view returns (MarketItem[] memory) {
        // Get current accumulators
        uint256 itemCount = _itemsIds.current();
        uint256 soldCount = _itemsSold.current();

        // Create array with size the difference of itemCount and soldCount
        MarketItem[] memory items = new MarketItem[](itemCount - soldCount);

        // index pointer
        uint256 index = 0;

        // Loop that iterates over all items and appends to array when
        // owner of a Market item is the 0 address
        for (uint256 i = 1; i <= itemCount; i++) {
            if (idToMarketItem[i].owner == address(0)) {
                items[index] = idToMarketItem[i];
                index += 1;
            }
        }
        return items;
    }
}
