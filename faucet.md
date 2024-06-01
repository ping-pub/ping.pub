# Guild for faucet service

## Submit You Config 

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
            "address": "https://cosmos.api.ping.pub:443", 
            "provider": "Ping"
        }
    ],
    "grpc": [
        {
            "address": "grpc.api.ping.pub:443", 
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
    "logo": "https://dl.airtable.com/.attachments/e54f814bba8c0f9af8a3056020210de0/2d1155fb/cosmos-hub.svg",
    "faucet": {
        "amount": "5000000uatom,50000000uside",
        "ip_limit": "1",
        "address_limit": "10",
        "fees": "1000uatom"
    }
}
```

## Fund the faucet account

Visit your faucet page on [testnet.ping.pub](https://testnet.ping.pub)

find the address and send some tokens to the address. 


# Reference

## Proxy GRPC with Caddy

the default grpc (9090) is insecure, we need to enable https

1. install caddy
```sh
sudo apt install caddy -y
```

2. add proxy:
```sh
vi /etc/caddy/Caddyfile
```
```caddy 
testnet-grpc.side.one { # replace with your domain.
	reverse_proxy localhost:9090 {
                transport http {
                                versions h2c 2
                        }
                }
}
```

3. reload
```sh
sudo systemctl reload caddy
```
