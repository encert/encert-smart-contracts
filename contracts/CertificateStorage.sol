pragma solidity ^0.5.0;

import "./Ownable.sol";

contract CertificateStorage is Ownable{

    event DataEdited(bytes32 fileHash);
    event IssuerEdited(address _newIssuer);
    event CertificateRevoked(bytes32 fileHash);

    mapping(address => mapping(bytes32 => bool)) public data;
    mapping(bytes32 => bool) public revokeList;
    mapping(address => bool) public issuers;


    modifier onlyIssuer{
        require(issuers[msg.sender] == true);
        _;
    }

    constructor() public {
    }
    
    function setData(bytes32 _fileHash) public onlyIssuer{
        data[msg.sender][_fileHash] = true;
        emit DataEdited( _fileHash);
    }
    
     function setIssuer(address _newIssuer) public onlyOwner{
        issuers[_newIssuer] = true;
        emit IssuerEdited( _newIssuer);

     }
    
    function revokeCertificate(bytes32 _fileHash) public onlyIssuer {
        revokeList[_fileHash] = true;
        emit CertificateRevoked( _fileHash);

    }
    
}

