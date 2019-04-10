pragma solidity 0.5.0;

import "./Ownable.sol";


contract IssuerStorage is Ownable {

    address public issuer;
    mapping (address => bool) public previousIssuers;

    function setCurrentIssuer(address _newIssuer) public onlyOwner {
        issuer = _newIssuer;
    }

    function setPreviousIssuer(address _newIssuer) public onlyOwner {
        previousIssuers[_newIssuer] = true;
    }
}