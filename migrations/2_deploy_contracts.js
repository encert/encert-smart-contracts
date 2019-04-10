var CertificateStorage = artifacts.require("./CertificateStorage.sol");
var IssuerStorage = artifacts.require("./IssuerStorage.sol");
var CertificateManager = artifacts.require("./CertificateManager.sol");

module.exports = async function (deployer) {
  await deployer.deploy(CertificateStorage);
  await deployer.deploy(IssuerStorage);
  await deployer.deploy(CertificateManager, CertificateStorage.address, IssuerStorage.address);
};
