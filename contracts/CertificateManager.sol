pragma solidity 0.5.0;

import "./CertificateStorage.sol";
import "./Ownable.sol";
import "./IssuerStorage.sol";


contract CertificateManager is Ownable {

    event CertificateIssued(bytes32 certHash);
    event CertificateRevoked(bytes32 fileHash);
    event IssuerAdded(address _newIssuer);

    string public issuerName;

    CertificateStorage public certStore;
    IssuerStorage public issuerStore;

    modifier onlyIssuer {
        require(msg.sender == issuerStore.issuer());
        _;
    }

    constructor(string memory _issuerName, address _certStorage, address _issuerStorage) public {
        issuerName = _issuerName;
        certStore = CertificateStorage(_certStorage);
        issuerStore = IssuerStorage(_issuerStorage);
    }

    function setIssuerName(string memory _name) public onlyIssuer {
        issuerName = _name;
    }
    
    function issueCertificate(bytes32 _certHash) public onlyIssuer {
        certStore.setData(_certHash);
        emit CertificateIssued( _certHash);
    }

    function revokeCertificate(bytes32 _certHash) public onlyIssuer {
        certStore.setRevokeList(_certHash);
        emit CertificateRevoked( _certHash);
    }

    function setIssuer(address _newIssuer) public onlyOwner {
        issuerStore.setCurrentIssuer(_newIssuer);
        issuerStore.setPreviousIssuer(_newIssuer);
        emit IssuerAdded(_newIssuer);
    }
}