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
         _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiQ2hpc3B1ZG8iLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSB1bmtub3duIG1pam8gY29sbGVjdGlvbiIsCiAgICAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJIVmxJaUF2UGdvZ0lDQWdQSFJsZUhRZ2VEMGlOVEFsSWlCNVBTSTFNQ1VpSUdOc1lYTnpQU0ppWVhObElpQmtiMjFwYm1GdWRDMWlZWE5sYkdsdVpUMGliV2xrWkd4bElpQjBaWGgwTFdGdVkyaHZjajBpYldsa1pHeGxJajVqYUdsemNIVmtiend2ZEdWNGRENEtQQzl6ZG1jKyIKfQ==");
         console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);


         // Increment the counter for when the next NFT is minted.
         _tokenIds.increment();
     }
 }