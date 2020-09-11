# JFrog-assignment

Prerequiste:

Jdk1.8,RAM 512MB

There are two ways by which petclinic can be run.

#1. 

Configure the below repo in Jenkins to build the "Jenkinsfile"
https://github.com/Deepak33/JFrog-assignment.git
Branch = main

Once this is build successfully, Docker file will be build to create docker image.


I have already pushed openjdk image to JFrog-assignment, during docker image build for petclinic belwo line will get the jdk docker images from JFrog
FROM dkc.jfrog.io/docker-quickstart-local/openjdk:1.8

once the build is completed docker container for petclinic will be up which can be access  by http://IPAddress:8080/

###############################################################################

#2.

Another way to run petclinic container is also mentioned below

docker login dkc.jfrog.io

docker pull dkc.jfrog.io/docker-quickstart-local/petclinic:1.1

docker run -itd -p 8080:8080  dkc.jfrog.io/docker-quickstart-local/petclinic:1.1