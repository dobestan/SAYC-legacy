// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;


import "./Soulbound.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Manager is Ownable {
    address public soulbound;
    Match[] public matches; 

    struct Match {
        address account0;
        address account1;
    }

    event Matched(address indexed accountA, address indexed accountB);

    constructor() {
        soulbound = address(new Soulbound());
    }

    function register(uint[6] calldata bdsm_score) external {
        Soulbound(soulbound).register(msg.sender, bdsm_score);
    }

    function _asOrderedAddresses(address accountA, address accountB) public pure returns (address account0, address account1) {
        // account0/account1 is Ordered
        // accountA/accountB is Unordered
        return accountA < accountB ? (accountA, accountB) : (accountB, accountA);
    }

    function createMatch(address accountA, address accountB) public onlyOwner {
        (address address0, address address1) = _asOrderedAddresses(accountA, accountB);
        Match memory createdMatch = Match(address0, address1);
        matches.push(createdMatch);

        emit Matched(address0, address1);
        emit Matched(address1, address0);
    }

    function createMatches(address[] calldata accountAs, address[] calldata accountBs) public onlyOwner {
        require(
            accountAs.length == accountBs.length,
            "Manager: matching addresses length is mismatched"
        );

        for (uint i; i < accountAs.length; i++) {
            createMatch(accountAs[i], accountBs[i]);
        }
    }
}