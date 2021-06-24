# Getting started

Once you have built all required packages and respective Docker images, you can run some quick tests to ensure everything is working correctly.

## Create Docker network

```shell
$ docker network create feats
```

## Run ORION context broker

ORION is a central part of the system and can be run using the official Docker image:

```shell
$ docker run -d --network feats --name mongodb mongo:3.4
$ docker run -d --network feats --name orion --link mongodb:mongodb -p 21026:1026 fiware/orion -dbhost mongo
```

You can test that it is up and running by CURLing the version:

```shell
$ curl localhost:21026/version
```

which should output something similar to this:
```json
{
    "orion" : {
        "version" : "2.4.0-next",
        "uptime" : "0 d, 23 h, 42 m, 7 s",
        "git_hash" : "4bf835364feec277dbcd5e146f4077494151e3c9",
        "compile_time" : "Tue Jul 28 11:30:53 UTC 2020",
        "compiled_by" : "root",
        "compiled_in" : "deaf7dfffff1",
        "release_date" : "Tue Jul 28 11:30:53 UTC 2020",
        "doc" : "https://fiware-orion.rtfd.io/"
    }
}
```
## Run CoFFEE

We can also run a stand-alone instance of CoFFEE since it has no other dependencies:

```shell
$ docker run -d --network feats --name broker-api -p 8080:8090 broker-api
$ docker run -d --network feats --name coffee-api -p 8092:8092 coffee-api
```

Wait a few seconds and check that broker-api is up and working:

```shell
$ curl http://localhost:8080/info | python -mjson.tool
```

The response should be simiilar to:

```json
{
    "build": {
        "artifact": "dalma-broker-web",
        "group": "com.dalma.broker",
        "name": "dalma-broker-web",
        "time": "2020-10-15T09:46:21.385Z",
        "version": "1.0-SNAPSHOT"
    }
}
```

Confirm also that coffee-api is up and working:

```shell
$ curl http://localhost:8092/info | python -mjson.tool
```

The response should be simiilar to:

```json
{
    "build": {
        "artifact": "dalma-coffee-web",
        "group": "com.dalma.coffee",
        "name": "dalma-coffee-web",
        "time": "2020-10-15T09:46:41.482Z",
        "version": "1.0-SNAPSHOT"
    }
}
```

Finally, you can confirm communication between the docker images broker-api, ORION and mongo-db:

```shell
$ curl http://localhost:8080/api/broker/workorder | python -mjson.tool
```

The response will be an empty array:

```shell
[]
```