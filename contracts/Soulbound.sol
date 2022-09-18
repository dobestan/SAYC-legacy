// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./ERC5633/ERC5633.sol";


contract Soulbound is ERC5633 {
    uint public constant MALICIOUS = 0;

    // BDSM Tokens(Score): 0-100(Default: 50)
    uint public constant BD_B = 1;
    uint public constant BD_D = 2;
    uint public constant DS_D = 3;
    uint public constant DS_S = 4;
    uint public constant SM_S = 5;
    uint public constant SM_M = 6;

    constructor(uint[6] memory bdsm_score) ERC5633("") {
        _setSoulbound(MALICIOUS, true);
        _setSoulbound(BD_B, true);
        _setSoulbound(BD_D, true);
        _setSoulbound(DS_D, true);
        _setSoulbound(DS_S, true);
        _setSoulbound(SM_S, true);
        _setSoulbound(SM_M, true);

        _mint(msg.sender, BD_B, bdsm_score[0], "");
        _mint(msg.sender, BD_D, bdsm_score[1], "");
        _mint(msg.sender, DS_D, bdsm_score[2], "");
        _mint(msg.sender, DS_S, bdsm_score[3], "");
        _mint(msg.sender, SM_S, bdsm_score[4], "");
        _mint(msg.sender, SM_M, bdsm_score[5], "");
    }
}