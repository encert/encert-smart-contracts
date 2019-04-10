pragma solidity 0.5.0;

import "./CertificateStorage.sol";
import "./Ownable.sol";
import "./IssuerStorage.sol";


contract CertificateManager is Ownable {

    event CertificateIssued(bytes32 certHash);
    event BatchCertificateIssued(bytes32[] certHashes);
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

    function verifyCertificate(address _issuer, bytes32 _certHash) public view returns (bool) {
        return certStore.data(_issuer, _certHash) && !certStore.revokeList(_certHash);
    }

    function isCertificateRevoked(bytes32 _certHash) public view returns (bool) {
        return certStore.revokeList(_certHash);
    }

    function setIssuerName(string memory _name) public onlyIssuer {
        issuerName = _name;
    }

    function issueCertificate(bytes32 _certHash) public onlyIssuer {
        certStore.setData(_certHash);
        emit CertificateIssued(_certHash);
    }

    function batchIssueCertificate(bytes32[] memory _certHashes) public onlyIssuer {
        for (uint i = 0; i < _certHashes.length; i++) {
            certStore.setData(_certHashes[i]);
        }
        emit BatchCertificateIssued(_certHashes);
    }

    function revokeCertificate(bytes32 _certHash) public onlyIssuer {
        certStore.setRevokeList(_certHash);
        emit CertificateRevoked(_certHash);
    }

    function setIssuer(address _newIssuer) public onlyOwner {
        issuerStore.setCurrentIssuer(_newIssuer);
        issuerStore.setPreviousIssuer(_newIssuer);
        emit IssuerAdded(_newIssuer);
    }
}