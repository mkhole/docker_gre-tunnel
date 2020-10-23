# How to run
Environment configuration `env.file`
```
$ cat env.file
ENV_DOCKER_IP=172.17.0.2                                                                                                                                                                      
ENV_REMOTE_IP=10.10.10.2
ENV_GRE_TYPE=L2
ENV_GRE_TUNNEL_IP=1.1.1.123/24
```

Run the `host.sh` on your linux PC.
```
$ ./host.sh
```

# Further Explanation

## Launch a new Docker container with the following command
```
docker run \
    --name gre-tunnel \
    --env-file ./env.file \
    -v /lib/modules:/lib/modules:ro \
    -d --privileged \
    mkhole/gre-tunnel
```

## How to attach a living container
```
docker exec -it gre-tunnel ash
```

## Retrieve contianer details
```
docker logs grel3-tunnel 
```
