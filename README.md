<div align="center">

![Ping Wallet](https://github.com/ping-pub/explorer/raw/master/public/logo.svg)

<h1>Ping Dashboard</h1>

**Ping Dashboard is not only an explorer but also a wallet and more ... 🛠**

[![version](https://img.shields.io/github/tag/ping-pub/ping.pub.svg)](https://github.com/ping-pub/explorer/releases/latest)
[![GitHub](https://img.shields.io/github/license/ping-pub/ping.pub.svg)](https://github.com/ping-pub/explorer/blob/master/LICENSE)
[![Ping Deploy](https://github.com/ping-pub/ping.pub/actions/workflows/deploy.yaml/badge.svg)](https://github.com/ping-pub/ping.pub/actions/workflows/deploy.yaml)
[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/bukotsunikki.svg?style=social&label=Follow%20%40ping_pub)](https://twitter.com/ping_pub)
[![https://discord.gg/CmjYVSr6GW](https://img.shields.io/badge/discord-join-7289DA.svg?logo=discord&longCache=true&style=flat)](https://discord.gg/CmjYVSr6GW)


</div>

This is a repository of deployment of  https://ping.pub .

## Are you interested in listing your blockchain on Ping Dashboard?
Initially, **Ping Dashboard** offers free listing for the first 100 blockchains. However, starting from the 101st blockchain, there will be associated fees.

## Why does Ping Dashboard rely on official/trusted third-party public LCD/RPC servers?
There are two primary reasons for this choice:

 - Trust: In a decentralized system, it is crucial to avoid relying solely on a single entity. By utilizing official/trusted third-party public LCD/RPC servers, Ping Dashboard ensures that the data is sourced from a network of trusted participants.
 - Limited Resources: As Ping Dashboard plans to list hundreds of Cosmos-based blockchains in the future, it is impractical for the Ping team to operate validators or full nodes for all of them. Leveraging trusted third-party servers allows for more efficient resource allocation.

## Donation

Your donation will help us make better products. Thanks in advance.

 - Address for ERC20: USDC, USDT, ETH
```
0x88BFec573Dd3E4b7d2E6BfD4D0D6B11F843F8aa1
```

# Directory Layout

**We accept all blockchains which have 10+ independent validators.**

- Submit configs for mainnet, go to https://github.com/ping-pub/ping.pub/tree/main/chains/mainnet

- Submit configs for testnet, go to https://github.com/ping-pub/ping.pub/tree/main/chains/testnet

# Sample of Config

```json
{
    "chain_name": "cosmos",
    "api": [
        {
            "address": "https://cosmos.api.ping.pub", 
            "provider": "Ping"
        }
    ], 
    "rpc": [
        {
            "address": "https://cosmos.api.ping.pub", 
            "provider": "Ping"
        }
    ],
    "sdk_version": "0.42.6",
    "coin_type": "118",
    "min_tx_fee": "800",
    "assets": [{
        "base": "uatom",
        "symbol": "ATOM",
        "exponent": "6",
        "coingecko_id": "cosmos", 
        "logo": "https://dl.airtable.com/.attachments/e54f814bba8c0f9af8a3056020210de0/2d1155fb/cosmos-hub.svg"
    }],
    "addr_prefix": "cosmos",
    "theme_color": "#ce4747",
    "logo": "https://dl.airtable.com/.attachments/e54f814bba8c0f9af8a3056020210de0/2d1155fb/cosmos-hub.svg"
}
```
- **chain_name** the name to identify the chain on ping.pub, would be better to use the same one as registry
- **api** the rest api endpoint.(make sure that CORS is enabled: `Allow-Control-Allow-Origin: *`)
- **rpc** the rpc endpoint, make sure that the port is added. rpc endpoint is only used for state sync. it's optional.
- **assets** Native Assets on blockchain. 

Endpoint providers will be listed in the "Popular" tab of the staking.

# Token Unit conversion

We have two methods to load token metadata for token unit conversion:

## Loading from a REST endpoint (recommended).
   
you can define the metadata in the `bank` -> `metadata` section of the blockchain's genesis file. if you don't define, the `[]` will return.

```json
{
  "name": "atom",
  "description": "The native staking token of the Cosmos Hub.",
  "denom_units": [
    {
      "denom": "uatom",
      "exponent": 0,
      "aliases": [
        "microatom"
      ],
    },
    {
      "denom": "matom",
      "exponent": 3,
      "aliases": [
        "milliatom"
      ]
    },
    {
      "denom": "atom",
      "exponent": 6,
    }
  ],
  "base": "uatom",
  "display": "atom",
}
```
you can see more details here:
https://github.com/cosmos/cosmos-sdk/blob/main/docs/architecture/adr-024-coin-metadata.md

## Loading from Cosmos Registry:

https://github.com/cosmos/chain-registry

# Test 

please add these check points in comments with your PR, and adding your test result by clicking the checkbox of each line
```
Test Result:
- [ ] Connect wallet, check if address is correct? 
- [ ] Transfer
- [ ] Delegate
- [ ] Redelegate
- [ ] Unbond
- [ ] withdraw Validator's Commission
- [ ] withdraw Rewards
```
Test is very important for us and our users. 




