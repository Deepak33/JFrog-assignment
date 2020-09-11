#!groovy?
pipeline {
    agent any
     tools {
         // ** NOTE: This 'Mvn354' Maven tool must be configured in the global configuration.
         maven 'Mvn354'         
     }
     options {
         buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5', daysToKeepStr: '10'))
        disableConcurrentBuilds()
     }
     environment {
         Branch="main"
         TargetDir="docker"
         image_name="petclinic"
         port="8080"         
     }
     //start of stages
     stages {
         //start of stage
         stage('Clone Code') {
              steps {
                  checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: "${Branch}"]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: "$TargetDir"]], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/Deepak33/JFrog-assignment.git']]]
                  checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: "${Branch}"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/spring-projects/spring-petclinic.git']]]
              }
         } //end of stage 
     stage('Build and Test') {
         steps {
             echo 'Running build and test'
             sh "cd $WORKSPACE"
             sh "./mvnw package"
         }
     } //end of stage
     stage('Build Docker image') {
         steps {
             sh '''
             # Copy jar file from target folder to $WORKSPACE/$TargetDir folder
             cp $WORKSPACE/target/*.jar $WORKSPACE/$TargetDir/
             # Remove old container
             [[ $(docker ps | grep integral-admin | wc -l) -gt 0 ]] && docker stop $(docker ps | grep $image_name | awk '{print $1}') && docker rm -f $(docker ps -a | grep $image_name | awk '{print $1}')
             
             # Remove old image
             docker rmi $image_name:1.1 || true
             # Build Docker image
             cd $WORKSPACE/$TargetDir/ && docker image build -t $image_name:1.1 .
             # Start new container
             docker run -itd -p $port:8080  $image_name:1.1
             '''
         }
     } //end of stage
     stage('Upload docker container to JFrog') {
         steps {
             sh '''
             # Login to docker registry 
             docker login dkc.jfrog.io
             # Tag image
             docker tag $image_name:1.1 dkc.jfrog.io/docker-quickstart-local/$image_name:1.1
             # Push to JFrog
             docker push dkc.jfrog.io/docker-quickstart-local/$image_name:1.1

             '''
         }
     } //end of stages 
   } //end of stages
   post {
       always {
           cleanWs()
       }
   } //end of post
} //end of pipeline