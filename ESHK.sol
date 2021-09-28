// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20VotesComp.sol";
import "./IGetOwner.sol";
import "./Freezeable.sol";

contract ESHK is ERC20VotesComp, Ownable, Pausable, IGetOwner, Freezeable{
    constructor() ERC20("eShark Token", "ESHK") ERC20Permit("eShark Token") {
        _mint(owner(), 10**(11+8));
    }   

    function decimals() public override pure returns(uint8) {
        return 8;
    }

    function getOwner() public override view returns(address) {
        return owner();
    }

    function burn(uint256 amount) public onlyOwner{
        _burn(_msgSender(), amount);
    }

    function pause() public onlyOwner{
        super._pause();
    }

    function unpause() public onlyOwner{
        super._unpause();
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "ERC20Pausable: token transfer while paused");
        require(!isFroze(from), "Freezeable: address status is froze");
    }
}