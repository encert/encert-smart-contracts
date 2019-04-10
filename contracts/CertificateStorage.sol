pragma solidity 0.5.0;

import "./Ownable.sol";


contract CertificateStorage is Ownable {

    event IssuerAdded(address _newIssuer);

    mapping(address => mapping(bytes32 => bool)) public data;
    mapping(bytes32 => bool) public revokeList;
    mapping(address => bool) public issuerContracts;

    modifier onlyIssuerContract {
        require(issuerContracts[msg.sender]);
        _;
    }

    modifier onlyCertificateIssuerContract(bytes32 _certHash) {
        require(data[msg.sender][_certHash]);
        _;
    }
    
    function setData(bytes32 _certHash) public onlyIssuerContract {
        data[msg.sender][_certHash] = true;
    }
    
    function setIssuerContract(address _newIssuer) public onlyOwner {
        issuerContracts[_newIssuer] = true;
    }
    
    function setRevokeList(bytes32 _certHash) public onlyCertificateIssuerContract(_certHash) {
        revokeList[_certHash] = true;
    }
}