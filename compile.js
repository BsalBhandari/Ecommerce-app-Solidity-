const path = require('path');
const fs = require('fs');
const solc = require('solc');

const contractPath = path.resolve(__dirname, 'contracts', 'Ecommerce.sol');
const contractSource = fs.readFileSync(contractPath, 'utf8');

const input = {
    language: 'Solidity',
    sources: {
        [contractPath]: {
            content: contractSource,
        },
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ['*'],
            },
        },
    },
};

const compiledContract = JSON.parse(solc.compile(JSON.stringify(input)));

const outputDir = 'compiled';
if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir);
}

const contractName = 'Ecommerce';
const bytecode = compiledContract.contracts[contractPath][contractName].evm.bytecode.object;
const abi = compiledContract.contracts[contractPath][contractName].abi;

fs.writeFileSync(path.join(outputDir, 'EcommerceBytecode.json'), bytecode, 'utf8'); // No need to stringify bytecode
fs.writeFileSync(path.join(outputDir, 'EcommerceABI.json'), JSON.stringify(abi), 'utf8');

console.log('Contract compiled successfully.');
