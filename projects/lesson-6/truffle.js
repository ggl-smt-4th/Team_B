// module.exports = {
//   migrations_directory: "./migrations",
//   networks: {
//     development: {
//       host: "localhost",
//       port: 8545,
//       network_id: "*" // Match any network id
//     }
//   }
// };

var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "arch spatial depth spy unknown vacuum arch tomorrow sight tilt syrup submit";
module.exports = {
  migrations_directory: "./migrations",
  networks: {
    ropsten: {
      provider: function () {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/B80OEuzYGGJH7qqAYUrJ");
      },
      network_id: '3'
    }
  }
};