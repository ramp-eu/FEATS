#/bin/bash

# Install Bright dependencies from JAR files
mvn install:install-file -Dfile=lib/bright-commons-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-commons -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
mvn install:install-file -Dfile=lib/bright-email-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-email -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
mvn install:install-file -Dfile=lib/bright-logging-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-logging -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
mvn install:install-file -Dfile=lib/bright-oauth-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-oauth -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar
mvn install:install-file -Dfile=lib/bright-orm-0.0.1-SNAPSHOT.jar -DgroupId=com.bybright -DartifactId=bright-orm -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar