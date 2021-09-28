// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IFreezeable.sol";

contract Freezeable is IFreezeable, Ownable{

    mapping(address => bool) private _freezeAddress;
    address[] private _listFreezeAddress;


    function freezeAddress(address target) override public onlyOwner {
        require(!_freezeAddress[target], "Freezeable: address already froze");
        _freezeAddress[target] = true;
        _listFreezeAddress.push(target);
        emit FreezeAddress(target);
    }

    function unfreezeAddress(uint256 targetIndex) override public onlyOwner{
        require(targetIndex<_listFreezeAddress.length, "Freezeable: address status is not froze");
        address targetAddress = _listFreezeAddress[targetIndex];
        _freezeAddress[targetAddress] = false;
        _listFreezeAddress[targetIndex] = _listFreezeAddress[_listFreezeAddress.length-1];
        _listFreezeAddress.pop();
        emit UnfreezeAddress(targetAddress);
    }
  
    function getFreezeAddresses() override public view returns (address[] memory){
        return _listFreezeAddress;
    }
    function isFroze(address target) override public view returns (bool){
        return _freezeAddress[target];
    }
}