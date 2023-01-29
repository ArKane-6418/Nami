// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;

  uint256 private seed;
  // Events are inheritable members of the contract, which stores the arguments passed into the transaction when emitted
  // Used to inform the application of the current state of the contract
  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  // Create a new array of Wave structs

  Wave[] waves;

  // Add a mapping that will store the last time a particular address waved at us
  mapping(address => uint256) public lastWavedAt;

  // Add the payable keyword to allow us to send money to users
  constructor () payable {
    console.log("This is a contract");

    // Generate initial seed
    // Block difficulty is mainly determined by the number of transactions
    seed = (block.difficulty + block.timestamp) % 100;
  }

  function wave(string memory _message) public {

    // We will set our cooldown to 10 minutes

    require(
      lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
      "You need to wait 30 seconds before waving again"
    );

    // If the check passes, update the timestamp they waved at
    lastWavedAt[msg.sender] = block.timestamp;
    totalWaves += 1;

    console.log("%s waved with the following message: %s", msg.sender, _message);

    // Push the new Wave struct to the array
    waves.push(Wave(msg.sender, _message, block.timestamp));

    // Generate a new seed using the previous seed
    // Our goal is to only award a waver with ETH 25% of the time

    seed = (block.difficulty + block.timestamp + seed) % 100;
    console.log("Random # generated: %d", seed);

    if (seed <= 24) {
      console.log("The winner is %s!", msg.sender);
      uint256 amount = 0.0001 ether;

      // require is like an assert statement, if the check fails, the second argument gets logged, the function ends and the traansaction fails
      // In particular, we cannot give an amount that is greater than the contract's balance
      require(
        amount <= address(this).balance,
        "Trying to withdraw more ethereum than the contract has"
      );

      // Send money to the person who waved at us
      // Perform a call to the contract and return if it was successful
      (bool success, ) = (msg.sender).call{value: amount}("");
      require(success, "Failed to withdraw money from the contract");
    }

    emit NewWave(msg.sender, block.timestamp, _message);
  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves", totalWaves);
    return totalWaves;
  }
}
