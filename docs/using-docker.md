# Using Docker

[Docker](https://www.docker.com/) is the preferred way of running the step-by-step tutorial. Containers may be run individually using the standard `docker exec` command, but a `docker-compose.yml` is provided for convenience. Should you decide to use the Docker CLI, please rememeber to create a Docker network and have all the containers on that network, as well as making sure the required ports are exposed / mapped to the host system. For more information, please check the `docker-compose.yml` file, which shows all the required information regarding ports and network configuration, as well as the environment variables for the containers that require them.

## Launching the system

In order to launch all the containers, `cd` into the root folder of the repository and run `docker-compose up`:

```shell
$ cd FEATS/
$ docker-compose up
```

If you are running the system for the first time, you may have to wait while the different images are downloaded. After starting the containers, it should take around 30 to 60 seconds to be fully ready.

**Note:** *since we are not using the `-d` flag, the logs for all containers shall be presented in the terminal window where the `docker-compose` command is run.*

