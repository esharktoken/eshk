// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IFreezeable{
    function freezeAddress(address target) external ;

    function unfreezeAddress(uint256 targetIndex) external ;

    function getFreezeAddresses() external view returns (address[] memory);
    function isFroze(address target) external view returns (bool);
    event FreezeAddress(address target);
    event UnfreezeAddress(address target);
}