// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Import some OpenZeppelin Contracts
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

 // Inherit the imported contract.
 contract MijoNFT is ERC721URIStorage {
    // OpenZeppelin magic to keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Base SVG code that all NFTs can use.
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Random words, each with their own theme.
    string[] firstWords = ["Milic", "Patojo", "Cerote", "Viejo", "Chavo", "Wiro", "Jefe", "Cuate", "Colocho", "Canche", "Tigre", "Cuate"];
    string[] secondWords = ["Chispudo", "Guapo", "Sheca", "Baboso", "Mula", "Cerote", "Trompudo", "Yuca", "Pistudo", "Bracas", "Deahuevo", "Shute", "Culebra"];
    string[] thirdWords = ["Bolo", "Caquero", "Casaquero", "Clavero", "Chambeador", "Gallo", "Pajero", "Borracho", "Tikinay", "Basura", "Shuco", "Gato", "Parrandero"];

    // Need to pass the name of the NFT token and its symbol.
    constructor() ERC721 ("MijoNFT", "MIJO") {
        console.log("Mijo NFT contract. LFG!");
    }

    // Randomly pick a word for each array.
    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
        // Seed the random generator.
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));

        // Squash the # between 0 and n to avoid going out of bounds.
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // A function our user will hit to get their NFT
    function makeMijoNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Randomly grab one word from each of the three arrays.
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        // Concatenate and close <text> and <svg> tags.
        string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, third, "</text></svg>"));
        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiQ2hpc3B1ZG8iLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSB1bmtub3duIG1pam8gY29sbGVjdGlvbiIsCiAgICAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJIVmxJaUF2UGdvZ0lDQWdQSFJsZUhRZ2VEMGlOVEFsSWlCNVBTSTFNQ1VpSUdOc1lYTnpQU0ppWVhObElpQmtiMjFwYm1GdWRDMWlZWE5sYkdsdVpUMGliV2xrWkd4bElpQjBaWGgwTFdGdVkyaHZjajBpYldsa1pHeGxJajVqYUdsemNIVmtiend2ZEdWNGRENEtQQzl6ZG1jKyIKfQ==");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);


        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
     }
 }