# Nami Backend
The backend was written in Solidity and I used [Hardhat](https://hardhat.org/) as my environment. I used [QuickNode](https://www.quicknode.com/) to deploy my contract to the Goerli testnet. You can check out the corresponding frontend [here](https://github.com/ArKane-6418/Nami-Frontend).

## Project setup
1. Run `npm install` in your terminal to install all the required packages.
2. Create a `.env` file to hold your environment variables.
3. Create a [MetaMask account](https://metamask.io/), change your network to "Goerli test network", obtain your private key by going to your MetaMask account, clicking the three dots, and going to "Account Details" > "Export Private Key", and finally, copy your private key to your `.env` file under the environment variable `GOERLI_PRIVATE_KEY`.
4. Create a [QuickNode account](https://www.quicknode.com/) and copy the HTTP Provider link to your `.env` file under the environment variable `QUICKNODE_API_KEY_URL`. 

## Notes
If you want to make your own changes to the smart contract, make sure to:
  1. Run `npx hardhat compile` and `npx hardhat test` in your terminal to test that your changes are bug-free.
  2. Verify your changes work as expected by running `npx hardhat run scripts/run.js` in your terminal.
  3. Deploy the smart contract to the Goerli test network by running `npx hardhat run scripts/deploy.js --network goerli` in your terminal.
  4. Make note of the contract address and update the `contractAddress` variable in the `App.js` file in the [frontend repository](https://github.com/ArKane-6418/Nami-Frontend).
  5. Copy the `artifacts/contracts/WavePortal.sol/WavePortal.json` file to the utils folder in the [frontend repository](https://github.com/ArKane-6418/Nami-Frontend)
