# Refund-Smart-Contract
## Introduction
A Blockchain is a publicly accessible database shared among numerous computers in a network. In a Blockchain, data and state is stored in consecutive groups known as “blocks”. Blockchain technology has led to the development of digital assets such as cryptocurrencies, smart contracts, and NFTs which are the core building blocks of decentralized applications (DApps).

A decentralized application (DApp) is an application that uses decentralized protocols for some or all aspects of its operation. Crucial parts of the program logic within the back-end must be executed on a blockchain to be considered a Dapp. This article explains the steps taken to build an end-to-end DAPP with an Ethereum-based smart contract in the backend.

## Project Overview
This project aims at developing user interfaces for an employer or an employee to interact with a refund by location smart contract on Ethereum Blockchain. The refund by location smart contract is aimed to be used when one party, for example, an employer, agrees to pay another party, for example, an employee, for being present in a certain geographic area for a certain duration. The employee’s phone sends their GPS location to a smart contract at a certain interval. Based on the pre-agreed contract codified in an Ethereum smart contract, an employee is reimbursed a certain pre-negotiated amount as long as the conditions in the smart contract are met.

## Project Structure
The project has 3 major modules:

a. The Refund smart contract

This is the backend of the project. It includes an ethereum smart contract that defines the rules that the employee should abide by in forEthereum be reimbursed.The Smart contract will be implemented using Solidity. The smart contract should at the minimum:

Store a list of employees and associated information (public key, expected location, e.t.c)
When users send their GPS location, the smart contract will verify their identity, validate their GPS info by referring to their stored requirement and record whether they fulfilled the contract’s requirements or not.
Approve fund release at the specified release time if the employee abides by the contract rules
b. Employer Web Dapp

This will be a web Dapp to allow the employer to interact with the smart contract. The web Dapp will be implemented in ReactJS.

c. Employee Mobile Dapp

This will be a mobile Dapp installed on the user’s mobile phone. The mobile app will interact with the smart contract and will send the user GPS location when needed.

## Project Implementation
We will use Brownie Framework to implement the project. Brownie is a Python-based development and testing framework for smart contracts targeting the Ethereum Virtual Machine. Brownie has a template system called Brownie Mixes, which we can use as a starting point for specific types of smart contract projects. There is a mix called react-mix, which “comes with everything you need to start using React with a Brownie project”. We will use the react-mix for this project.
