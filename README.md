# Welcome to yii-dev - a Docker based development environment for Yii(2)

yii-dev allows you to easily setup a development environment for the Yii PHP framework. It provides you with a fully equipped Docker container with an Apache webserver and PHP installation 
to run and test your Yii based application. You can either start with a blank, new Yii installation or integrate an already existing Yii project.


## Quickstart

Start a Docker container:

```
docker run -d -p 9090:80 -v /data/yii/webdata/:/var/www/html thomaszastrow/yii-dev:latest
```

This command will pull the container from Docker Hub and start it. 

* The _internal_ port 80 of the Apache webserver is mapped to port 9090 on the host system. Your Yii instance will be available via http://localhost:9090 on the host system. 
You can also choose another host port instead of 9090.

* An external folder is via the "-v" parameter mounted into the Docker container as root folder of the webserver (/var/www/html). Instead of the example path "/data/yii/webdata/", 
please choose a path to an existing Yii installation on your harddrive. If you don't have a Yii based project so far, you can just use an empty folder and then install 
Yii from _inside_ the container (see below). 

* thomaszastrow/yii-dev:latest is the name of the Docker image on Docker Hub.

If everything worked fine, point your browser to

http://localhost:9090 

(Or which ever port you have used) - and you should see your Yii project.


## Creating a new Yii project from inside the container

If you don't have a Yii project so far, don't worry, you can easily create one from inside the Docker container. In this case, you should point the host path in the "-v" parameter 
to an empty folder on your harddrive where you can start a new Yii project. This makes sure that the project and all its data will survive a restart of the container. If you don't need 
persistency, you can also start the Docker container without the "-v" parameter and work completly inside the container. But in case of a container crahs or restart, everything 
will be gone!

Once you have the Docker container running, get its ID (first column) via the command "docker ps". This is an arbitrary number. Now, execute the following command to get a Bash shell 
inside the container:

```   
docker exec -ti ID_OF_THE_CONTAINER /bin/bash

```
Now, you are insde the container. Change your path:

```
cd /var/www/html
```

Here, execute the command to create a new Yii project:

```
composer create-project --prefer-dist yiisoft/yii2-app-basic basic
```

## Using a Database

If you need a database in your Yii project, the procedure is slightly different than written above. There is a "docker-compose.yml" file which can be used by the "docker-compose" command:

```
docker-compose up
```
This will fire up two Docker containers: the runtime environment for the Yii environment, see documentation above. And as a second container, a MariaDB instance which is accessible via 
the first container.

_Please don't forget to adjust parameters etc. in the docker-compose.yml file BEFORE you start the command!_

... _More documentation to come ... _ 



