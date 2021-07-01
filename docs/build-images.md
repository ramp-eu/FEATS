# Build images

FEATS is organized into 7 different components:
<ul>
    <li>CoFFEE</li>
    <li>FI-BREW</li>
    <li>LATTE</li>
    <li>FIROS</li>
    <li>Broker</li>
    <li>Commons</li>
    <li>Contracts</li>
</ul>
  
The first three are the main components, with CoFFEE, FI-BREW and FIROS serving as interfaces between the system and the external parts, while LATTE acts as a manager / orchestrator. The `broker` is a middleware common to all main components, allowing them to communicate with an instance of the ORION context broker. `commons` and `contracts` define the Data Transfer Objects and other common code shared by all the components.

In order to run the whole system, we must first build the individual images. It is important to follow the steps below in the order they appear, as some components are dependent on others.

## Build `commons` and `contracts`

These packages are used by all the others, so they must be built first.

1. After cloning the whole [repository](https://github.com/Dalma-Systems/FEATS), `cd` into the `commons` folder and run `mvn clean install`:
```shell
$ cd FEATS/commons
$ mvn clean install
```
2. Do the same thing for the `contracts` folder:
```shell
$ cd FEATS/commons
$ mvn clean install
```

## Add pre-built dependencies to your Maven repository

These artifacts must be added using the [Apache Maven Install Plugin](https://maven.apache.org/plugins/maven-install-plugin/usage.html).

1. `cd` into the root of the repository.
2. Run the Maven install command for each of the artifacts, as such:
```shell
$ mvn install:install-file -Dfile=lib/bright-commons-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-commons -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
$ mvn install:install-file -Dfile=lib/bright-email-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-email -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
$ mvn install:install-file -Dfile=lib/bright-logging-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-logging -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
$ mvn install:install-file -Dfile=lib/bright-orm-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-orm -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
$ mvn install:install-file -Dfile=lib/bright-oauth-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-oauth -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
```

## Build the `broker`

1. `cd` into the `broker` folder.
2. Run `mvn clean install`.
```shell
$ cd FEATS/broker
$ mvn clean install -DskipTests
```
**Note:** the -DskipTests flag is required for now due to an issue with the tests for this package.

## Build CoFFEE and FI-BREW

1. `cd` into the `coffee` folder.
2. Run `mvn clean install`.
```shell
$ cd FEATS/coffee
$ mvn clean install
```
3. `cd` into the `fi-brew` folder.
4. Run `mvn clean install`.
```shell
$ cd FEATS/fi-brew
$ mvn clean install
```

## (optional) Build Docker images

The components may be run directly using `java -jar <package_name>-api-web/target/dalma-<package_name>-api.jar`. However, the preferred method is using Docker, therefore we will see how to build the different Docker images for each component:

1. `cd` into the `broker` folder.
2. Run the docker build command and tag the image as `broker-api`.
```shell
$ cd FEATS/broker
$ docker build -f Dockerfile -t broker-api .
```
3. Repeat the same steps for CoFFEE and FI-BREW:
```shell
$ cd FEATS/coffee
$ docker build -f Dockerfile -t coffee-api .
```
```shell
$ cd FEATS/fi-brew
$ docker build -f Dockerfile -t fibrew-api .
```