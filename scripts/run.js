const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  // Compile contract and generate necessary files 
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  // Create local Ethereum network just for this contract
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1")
  });
  // Deploy the contract and fund it with 0.1 ETH
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address)

  // Get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);

  // Check that the contract has bee funded with 0.1 ETH
  console.log(`Contract balance: ${hre.ethers.utils.formatEther(contractBalance)}`);

  // Test the functionality of the wave functions
  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  const waveMap = new Map();
  // Wave to ourselves
  const firstWaveTxn = await waveContract.wave("A message to myself");
  await firstWaveTxn.wait();

  waveMap.set(owner.address, 1);

  // Check if the number of waves updated
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  const secondWaveTxn = await waveContract.connect(randomPerson).wave("A message from random person");
  await secondWaveTxn.wait();

  waveMap.set(randomPerson.address, 1);

  // Check that 0.0001 ETH was withdrawn from the contract when we waved
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);

  // Check that the contract has bee funded with 0.1 ETH
  console.log(`Contract balance: ${hre.ethers.utils.formatEther(contractBalance)}`);

  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  console.log(waveMap);

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0); // exit Node process without error
  } catch (error) {
    console.log(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
  // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
};

runMain();
