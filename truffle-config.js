let HDWalletProvider = require('truffle-hdwallet-provider');
let mnemoic = "volcano memory stereo animal drift nuclear stairs dice venture mercy random sniff";

module.exports = {
    networks: {
        rinkeby: {
            provider: function () {
                return new HDWalletProvider(mnemoic, 'https://rinkeby.infura.io/v3/a2cecf6103164d56b460c9ac6283ae24')
            },
            network_id: 4,
        },
        ropsten: {
            provider: function () {
                return new HDWalletProvider(mnemoic, 'https://ropsten.infura.io/v3/a2cecf6103164d56b460c9ac6283ae24')
            },
            network_id: 3
        },
        development: {
            host: "localhost",
            port: 8545, // Using ganache as development network
            network_id: "*"
        }
    },
    solc: {
        optimizer: {
            enabled: true
        }
    }
};
