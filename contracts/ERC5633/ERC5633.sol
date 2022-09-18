// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./IERC5633.sol";


contract ERC5633 is ERC1155, IERC5633 {
    mapping(uint => bool) private _soulbounds; 

    constructor(string memory uri_) ERC1155(uri_) {
    }

    // TODO: supportsInterface
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol#L40

    function isSoulbound(uint256 id) external view override returns (bool) {
        return _soulbounds[id];
    }

    function _setSoulbound(uint id, bool soulbound) internal {
        require(_soulbounds[id] != soulbound, "ERC5633: Already Soulbound");
        _soulbounds[id] = soulbound;
        emit Soulbound(id, soulbound);
    }

    // TODO: _beforeTokenTransfer
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol#L429
}