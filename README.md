# BlockChain

Which is not a blockchain at all (Pardon my repo naming skills :blush: ).

## Introduction

This is a standard ETH-AVAX Asset Bridge that transfers ERC721 Assets from one blockchain to another.

As cross-chain asset bridge works, we will have 2 tokens

- **main token** that pre-exists in our main chain
- **child token** that we need to create in our side chain

We will also have 2 **bridge contracts** that exists one in our main chain and one in our side chain

### How does it work

1. People move the amount of token they want to the bridge contract. The bridge contract either.
    - If it is main chain, it locks the tokens there, making it inaccessible.
    - If it is side chain, it burns the token, it simply destroys that token.

2. The Bridge contract then signals the bridge api to communicate with the other chain where.
    - If it is main chain, it releases the token there, making it available to the user
    - If it is side chain, it mints a new token, creates it from scratch.

## Components

- TokenBase: Creates a Base for the Token definition.

- ### LancheToken(LNK): The ETH-AVAX Token conforming to ERC721 Standards

- ### SolaToken(SLT): The ETH-SOL Token conforming to ERC721 Standards


## How To Use?