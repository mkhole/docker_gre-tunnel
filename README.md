# How to run
Set up the environment configuration `env.file`

- ENV_DOCKER_IP: The container's IP.
- ENV_REMOTE_IP: The remote node's IP used to transmit the GRE packets.
- ENV_GRE_TYPE: The GRE protocol type (L2/L3).
- ENV_GRE_TUNNEL_IP: The GRE interface's IP.

```
$ cat env.file
ENV_DOCKER_IP=172.17.0.2        
ENV_REMOTE_IP=10.10.10.2
ENV_GRE_TYPE=L2
ENV_GRE_TUNNEL_IP=1.1.1.123/24
```

Run the `host.sh` on your linux PC, then it will set up the firewall rules and probe the modules.

```
$ ./host.sh
```

# Further Explanation

## Retrieve contianer's log

```
docker logs grel3-tunnel 
```


## How to attach a living container

```
docker exec -it gre-tunnel ash
```

## How to add a new application in container

```
apk add iperf3
```
