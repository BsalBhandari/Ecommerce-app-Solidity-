const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const { abi, bytecode } = require('./compile');

const provider = new HDWalletProvider("unique spatial expire tragic coast myth include sign mutual wing skull cereal","https://sepolia.infura.io/v3/ab3a601580fd497b9effaca9f2ed3485");

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from account', accounts[0]);

    const laptopPrice = 1000;
    const laptopStock = 10;
    const watchPrice = 500;
    const watchStock = 20;
    const tvPrice = 1500;
    const tvStock = 5;

    const deployedContract = await new web3.eth.Contract(abi)
        .deploy({
            data: bytecode,
            arguments: [laptopPrice, laptopStock, watchPrice, watchStock, tvPrice, tvStock],
        })
        .send({ from: accounts[0], gasPrice: '8000000000', gas: '4700000' });

    console.log('Ecommerce Contract deployed to', deployedContract.options.address);
    provider.engine.stop();
};

deploy();
