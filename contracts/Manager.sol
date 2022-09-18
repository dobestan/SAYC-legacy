// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;


import "./Soulbound.sol";


contract Manager {
    address public soulbound;

    constructor() {
        soulbound = address(new Soulbound());
    }

    function register(uint[6] calldata bdsm_score) external {
        Soulbound(soulbound).register(msg.sender, bdsm_score);
    }
}