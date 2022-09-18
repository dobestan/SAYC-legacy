// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./ERC5633/ERC5633.sol";

import "@openzeppelin/contracts/access/Ownable.sol";


contract Soulbound is ERC5633, Ownable {
    uint public constant REGISTERED = 0;

    // BDSM Tokens(Score): 0-100(Default: 50)
    uint public constant BD_B = 1;
    uint public constant BD_D = 2;
    uint public constant DS_D = 3;
    uint public constant DS_S = 4;
    uint public constant SM_S = 5;
    uint public constant SM_M = 6;

    uint public constant MALICIOUS = 7;

    constructor() ERC5633("") {
        _setSoulbound(REGISTERED, true);
        _setSoulbound(BD_B, true);
        _setSoulbound(BD_D, true);
        _setSoulbound(DS_D, true);
        _setSoulbound(DS_S, true);
        _setSoulbound(SM_S, true);
        _setSoulbound(SM_M, true);
        _setSoulbound(MALICIOUS, true);
    }

    function register(address soul, uint[6] calldata bdsm_score) external onlyOwner soulNotRegistered(soul) {
        _mint(soul, REGISTERED, 1, "");
        _mint(soul, BD_B, bdsm_score[0], "");
        _mint(soul, BD_D, bdsm_score[1], "");
        _mint(soul, DS_D, bdsm_score[2], "");
        _mint(soul, DS_S, bdsm_score[3], "");
        _mint(soul, SM_S, bdsm_score[4], "");
        _mint(soul, SM_M, bdsm_score[5], "");
    }

    function isRegistered(address soul) public view returns (bool) {
        return balanceOf(soul, REGISTERED) != 0;
    }

    modifier soulRegistered(address soul) {
        require(
            isRegistered(soul),
            "Soulbound: Soul should be register"
        );
        _;
    }

    modifier soulNotRegistered(address soul) {
        require(
            !isRegistered(soul),
            "Soulbound: Soul is already registered"
        );
        _;
    }
}