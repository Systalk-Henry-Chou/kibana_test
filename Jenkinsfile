// -*- mode: groovy -*-
pipeline {
    agent any
    stages{
        stage ('Prepare') {
            echo "Let's to build"
        }
        stage ('Build'){
            steps {
                sh 'docker build -f Dockerfile . -t flask/test:1-devel'
            }
    
        }
    }
    
      
}
   
 

