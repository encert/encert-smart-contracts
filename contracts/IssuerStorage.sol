pragma solidity 0.5.0;

import "./Ownable.sol";


contract IssuerStorage is Ownable {

    address public issuer;
    address public issuerContract;

    mapping (address => bool) public previousIssuers;

    modifier onlyIssuerContract {
        require(msg.sender == issuer);
        _;
    }

    function setIssuerContract(address _newIssuer) public onlyOwner {
        issuerContract = _newIssuer;
    }

    function setCurrentIssuer(address _newIssuer) public onlyIssuerContract {
        issuer = _newIssuer;
    }

    function setPreviousIssuer(address _newIssuer) public onlyIssuerContract {
        previousIssuers[_newIssuer] = true;
    }
}