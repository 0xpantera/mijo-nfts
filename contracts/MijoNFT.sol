// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Import some OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

 // Inherit the imported contract.
 contract MijoNFT is ERC721URIStorage {
     // OpenZeppelin magic to keep track of tokenIds.
     using Counters for Counters.Counter;
     Counters.Counter private _tokenIds;

     // Need to pass the name of the NFT token and its symbol.
     constructor() ERC721 ("MijoNFT", "MIJO") {
         console.log("Mijo NFT contract. LFG!");
     }

     // A function our user will hit to get their NFT
     function makeMijoNFT() public {
         // Get the current tokenId, this starts at 0.
         uint256 newItemId = _tokenIds.current();

         // Actually mint the NFT to the sender using msg.sender.
         _safeMint(msg.sender, newItemId);

         // Set the NFTs data.
         _setTokenURI(newItemId, "https://jsonkeeper.com/b/R6JH");
         console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);


         // Increment the counter for when the next NFT is minted.
         _tokenIds.increment();
     }
 }