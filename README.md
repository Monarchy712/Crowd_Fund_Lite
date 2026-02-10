# CrowdFundLite

A minimal time-bound crowdfunding smart contract built in Solidity.

## Overview

CrowdFundLite enables a project owner to raise funds within a fixed duration:

- Contributors fund the campaign before the deadline  
- If the funding goal is reached, the owner can withdraw the funds  
- If the goal is not met, contributors can claim refunds  

The contract enforces a clear state-driven lifecycle: Active → Successful → Failed.

## Key Features

- Time-bound campaign using `block.timestamp`
- Goal-based fund release mechanism
- Refund logic for unsuccessful campaigns
- Enum-based state machine design
- Secure ETH handling using the Checks-Effects-Interactions pattern
- Role-based access control (owner vs contributors)

## Concepts Demonstrated

- Enums for state management
- Mappings for contribution tracking
- Dynamic arrays for contributor storage
- Payable functions and fund accounting
- Secure withdrawal and refund flows

## Why It Matters

Crowdfunding contracts must ensure:

- Correct state transitions
- Accurate accounting of contributions
- Protection against reentrancy
- Safe and deterministic fund flow

Even minimal funding protocols require disciplined logic and security awareness in Web3.
