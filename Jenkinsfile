pipeline {
    agent{
                 label 'master'
             }
    tools{
        nodejs "nodejs"
    }
    stages {
       stage('Build') {
            steps {
             bat "npm install"
            }
        }
        // stage('Install sonar scanner') {
        //     steps {
        //      bat "npm install --save-dev sonar-scanner"
        //     }
        // }
        // stage('Run sonar scanner'){
        //     steps{
        //         bat "npm run sonar"
        //     }
        // }
        // stage('Deploy to Directory dist/'){
        //     steps{
        //         bat "npm run build"
        //     }
        // }
        stage('Build Dockerimage') {
            steps {
               bat "docker build --rm -t front-end-app ."


            }
        }
        stage('Tag Dockerimage') {
            steps {

              bat "docker tag front-end-app 192.168.33.10:8123/front-end-app:${env.BUILD_ID}"

            }       


         }
         stage('Push Dockerimage') {
            steps {

              bat"docker login -u docker -p admin@123 192.168.33.10:8123"
              bat "docker push 192.168.33.10:8123/front-end-app:${env.BUILD_ID}" 
            }       


         }
         stage('Pull from docker and run'){
             agent{
                 label 'DEVELOPMENT_SERVER'
             }
             steps{
                sh """#!/bin/bash 
				
				sudo docker container rm -f front-end-app
				sudo docker pull 192.168.33.10:8123/front-end-app:${env.BUILD_ID}
				sudo docker run -d -p 4200:80 --name front-end-app 192.168.33.10:8123/front-end-app:${env.BUILD_ID}
				sudo docker run --network mysql-1 --name front-end-app --link imagetest2  -p 4200:80 -d 192.168.33.10:8123/front-end-app:${env.BUILD_ID}
				
				""" 
             }
         }
    }
  }
