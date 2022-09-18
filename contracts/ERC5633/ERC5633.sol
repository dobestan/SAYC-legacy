// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./IERC5633.sol";


contract ERC5633 is ERC1155, IERC5633 {
    mapping(uint => bool) private _soulbounds; 

    constructor(string memory uri_) ERC1155(uri_) {
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    // TODO: IERC5633Receiver Implementation
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155) returns (bool) {
        return
            interfaceId == type(IERC5633).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function isSoulbound(uint256 id) public view override returns (bool) {
        return _soulbounds[id];
    }

    function _setSoulbound(uint id, bool soulbound) internal {
        require(_soulbounds[id] != soulbound, "ERC5633: Already Soulbound");
        _soulbounds[id] = soulbound;
        emit Soulbound(id, soulbound);
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint[] memory ids,
        uint[] memory amounts,
        bytes memory data
    ) internal virtual override {
        // _beforeTokenTransfer called on 
        // _safeTransferFrom, _safeBatchTransferFrom, _mint, _mintBatch, _burn, _burnBatch.
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        for (uint i=0; i < ids.length; i++) {
            if (isSoulbound(ids[i])) {
                require(from == address(0) || to == address(0));
                // SBT only allows transfer via _mint, _burn.
            }
        }
    }

}