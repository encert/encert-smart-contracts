pragma solidity ^0.5.0;

import "./CertificateStorage.sol";
import "./Ownable.sol";


contract CertificateIssuer is Ownable{
    
    modifier onlyIssuer{
        require(msg.sender == issuer);
        _;
    }

    address public issuer;

    CertificateStorage public store;

    constructor(address _storageAddress) public {
        store = CertificateStorage(_storageAddress);
        
    }
    
    function setIssuer(address _newIssuer) public onlyOwner{
        issuer = _newIssuer;
    }
    
    function issueCertificate(bytes32 _fileHash) public onlyIssuer{
        store.setData(_fileHash);
    }
    
}

