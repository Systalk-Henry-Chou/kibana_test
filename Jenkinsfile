// -*- mode: groovy -*-
pipeline {
    agent any
    stages{
        stage ('Build'){
            steps {
                sh 'docker build -f Dockerfile . -t flask/test:1'
            }
    
        }
    }
    
      
}
   
 

