// -*- mode: groovy -*-
pipeline {
  agent {
    label 'faqnlu'
  }
  stages {
    stage ('Prepare') {
      echo "Let's to build"
    }
    stage ('Build')
      steps {
            sh """
                docker build -f Dockerfile . -t flask/test:1-devel
            """
        }
      post {
        success {
          sh """
            docker tag flask/test:1-devel flask/test:latest
          """
        }
      }
    }
   
  }
 

