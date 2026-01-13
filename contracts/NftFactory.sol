// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract NftFactory {
    string public name = "ExampleNFT";
    string public symbol = "ENFT";

    struct NftData {
        uint256 id;
        address owner;
        string uri;
    }

    uint256 public nextId;
    mapping(uint256 => NftData) public nfts;
    mapping(address => uint256[]) public ownedTokens;

    event Mint(address indexed to, uint256 indexed tokenId, string uri);
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    constructor() {
        nextId = 1;
    }

    function mint(string memory uri) external {
        uint256 tokenId = nextId;
        nextId += 1;

        nfts[tokenId] = NftData({
            id: tokenId,
            owner: msg.sender,
            uri: uri
        });

        ownedTokens[msg.sender].push(tokenId);
        emit Mint(msg.sender, tokenId, uri);
    }

    function transfer(address to, uint256 tokenId) external {
        require(to != address(0), "Zero address");
        NftData storage token = nfts[tokenId];
        require(token.owner == msg.sender, "Not owner");

        token.owner = to;
        ownedTokens[to].push(tokenId);
        emit Transfer(msg.sender, to, tokenId);
    }

    function tokensOfOwner(address owner_) external view returns (uint256[] memory) {
        return ownedTokens[owner_];
    }
}
