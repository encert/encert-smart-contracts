pragma solidity 0.5.0;

import "./Ownable.sol";


contract CertificateStorage is Ownable {

    event IssuerAdded(address _newIssuer);

    mapping(address => mapping(bytes32 => bool)) public data;
    mapping(bytes32 => bool) public revokeList;
    mapping(address => bool) public issuers;

    modifier onlyIssuer {
        require(issuers[msg.sender]);
        _;
    }

    modifier onlyCertificateIssuer(bytes32 _certHash) {
        require(data[msg.sender][_certHash]);
        _;
    }
    
    function setData(bytes32 _certHash) public onlyIssuer {
        data[msg.sender][_certHash] = true;
    }
    
    function setIssuer(address _newIssuer) public onlyOwner {
        issuers[_newIssuer] = true;
    }
    
    function setRevokeList(bytes32 _certHash) public onlyCertificateIssuer(_certHash) {
        revokeList[_certHash] = true;
    }
}