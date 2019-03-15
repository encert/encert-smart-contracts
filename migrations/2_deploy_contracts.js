var Issuer = artifacts.require("./CertificateIssuer.sol");
var Storage = artifacts.require("./CertificateStorage.sol");

module.exports = async function (deployer) {
  await deployer.deploy(Storage);
  await deployer.deploy(Issuer, Storage.address);


};
