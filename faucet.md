# Guild for faucet service

## Submit You Config 

```json
{
    "chain_name": "cosmos",
    // string array ["url1", "url2"] is deprecated.
    // must be [{"address": "", "provider": ""}]
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
    // ... ...
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
