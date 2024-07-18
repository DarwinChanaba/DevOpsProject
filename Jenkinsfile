pipeline {  
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout k8s
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 app = docker.build("underwater")
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }
        stage('Deploy') {
            steps {
                script{
                        docker.withRegistry('https://031995739067.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:registry') {
                    app.push("1")
                    app.push("latest")
                    }
                }
            }
        }
    }
}
