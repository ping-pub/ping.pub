# Guild for faucet service

## Submit You Config 

```json
 {
 }
```

## Fund the faucet account

Visit your faucet page on [testnet.ping.pub](https://testnet.ping.pub)

find the address and send some tokens to the address. 


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
testnet-grpc.side.one { # replace your domain.
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
