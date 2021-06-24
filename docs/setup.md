# Setup

Before being able to simulate the system operation, we need to provide some information to the system, namely:
<ul>
    <li>ORION entities:
        <ul>
            <li>AMR</li>
            <li>Warehouse</li>
            <li>Idle Station</li>
            <li>Work Stations</li>
        </ul>
    </li>
    <li>MySQL DBs</li>
</ul>


## Creating MySQL databases

FEATS requires two databases for its operation, `dalma_jobs` and `dalmadb`. To create these, we need to go inside the mysql-db container:
```shell
$ docker exec -it mysql-db bash
```
Next, we are going to access MySQL directly using the CLI:
```shell
$ root@mysql-db:/# mysql
$ mysql> CREATE DATABASE dalmadb;
Query OK, 1 row affected (0.01 sec)
$ mysql> CREATE DATABASE dalma_jobs;
Query OK, 1 row affected (0.01 sec)
```

## Creating ORION entities

For the creation of the various entities on ORION, we will be using [Postman](https://www.postman.com/). The collection of requests to be used can be found in the repository (`dalma_feats.postman_collection.json`) and should be imported into Postman.

Before proceeding, make sure the Postman enviroment is correctly set up. For this, select "dalma demo" in the Environment drop-down and then click the 'eye' icon next to it. This shows the required enviroment variables and their values. For a local enviroment, these should be the set values:

| Variable   | Value                  |
| ---        | ---                    |
| orion_url  | http://localhost:21026 |
| url_latte  | http://localhost:8091  |
| url_coffee | http://localhost:8092  |
| url        | http://localhost:8080  |

After importing, let us create the different entities:

### Adding an AMR

1. Go into `latte > robot` and select the POST request titled "add robot".
2. In the "Body" section of the request, change the `macAddress` value to any one you want (we recommend `aa:bb:cc:dd:ee:ff`). If you choose a different one from the recommendation, please be aware that you will also need to change the `ROBOT_ID` environment variable in the `firos` container of the `docker-compose.yml` file.
3. Send the request -- the response should be 201, meaning the entity was successfully created.

### Adding a warehouse

1. Go into `broker > warehouse` and select the POST request titled "add warehouse".
2. The "Body" section of the request should be pre-filled; however, if for some reason it is empty or incorrect, it should contain a JSON object with the following data:
```json
{
    "latitude": 20.95,
    "longitude": 22.4,
    "angle": -1.5198,
    "name": "Armazém de Graus",
    "status": "ready",
    "erpId": "0075"
}
```
3. Send the request -- the response should be 201, meaning the entity was successfully created.

### Adding an idle station

1. Go into `broker > idle station` and select the POST request titled "add idle station".
2. The "Body" section of the request should be pre-filled; however, if for some reason it is empty or incorrect, it should contain a JSON object with the following data:
```json
{
    "latitude": 24.3,
    "longitude": 20,
    "angle": 0.071,
    "name": "zona de descanso",
    "status": "idle"
}
```
3. Send the request -- the response should be 201, meaning the entity was successfully created.

### Adding two work stations

1. Go into `broker > work station` and select the POST request titled "add work station".
2. The "Body" section of the request should be pre-filled; however, if for some reason it is empty or incorrect, it should contain a JSON object with the following data:
```json
{
    "latitude": 12.4,
    "longitude": 36.9,
    "angle": 0.0511,
    "name": "K50_1",
    "status": "ready",
    "erpId": "0161"
}
```
3. Send the request -- the response should be 201, meaning the entity was successfully created.
4. Repeat for the second work station, with different data (at least the `name` and `erpId` keys should be different):
```json
{
    "latitude": 12.4,
    "longitude": 37.4,
    "angle": -3.1378,
    "name": "ISO_1",
    "status": "ready",
    "erpId": "0151"
}
```