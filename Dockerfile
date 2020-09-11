# Get the openjdk:1.8 image from JFrog
FROM dkc.jfrog.io/docker-quickstart-local/openjdk:1.8

MAINTAINER deepak101deepak@gmail.com
# Create a directory
RUN mkdir -p  /home/petclinc/app

COPY spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar /home/petclinc/app/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar

WORKDIR /home/petclinc/app

CMD ["/usr/bin/java" , "-Xms256m" , "-Xmx512m" ,"-jar" , "spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar" ]