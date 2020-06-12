# ngrok-ssh

##Open reverse proxy
<pre>
    args:
    $IP -> Scan ip using url of ngrok via traceroute (Unix) or tracert (Windows)
    $PORT -> Port exposed by ngrok
</pre> 
        
```shell script
ssh -N -R 2323:0.0.0.0:22 -o ServerAliveInterval=60 -o GatewayPorts=yes -f root@$IP -p $PORT
```

An example of a script:

<pre>
    args:
    $PORT -> port of service
    $IP -> ip of service
    $USER -> User of remote server
</pre>

```shell script
ssh -N -L 0.0.0.0:$PORT:$IP:$PORT -o ServerAliveInterval=60 -f $USER@localhost -p 2323
```

## Run scripts

<pre>
    args:
    $SCRIPTNAME -> Name of script allocated in <b>dbin</b> folder
</pre>

```shell script
docker exec -it ngrok sh /dbin/$SCRIPTNAME.sh
```

## Open ports  to services
Need to add port binding in docker-compose.yml in section 
```shell script
services > ngrok > ports
```