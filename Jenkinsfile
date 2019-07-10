// -*- mode: groovy -*-
pipeline {
    agent any
    stages{
        stage('Build'){
            steps {
                sh 'docker build -f Dockerfile . -t flask/test:1'
                sh 'docker-compose start'
            }
    
        }
        stage('Test'){
            steps {
                sh '.run.sh'
                sh 'docker-compose stop'
            }
        }
        stage('Remove Image'){
            steps {
                sh 'docker-compose rm -y'
                sh 'docker rmi flask/test:1 -y'
            }
        }

    }
    
      
}
   
 

