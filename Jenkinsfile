pipeline {
    agent any
     environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '031995739067'
        ECR_REPO_NAME = 'registry' 
        IMAGE_TAG = 'latest' 
        REPO_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}"
        DOCKER_IMAGE_NAME = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}"
    }
 
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}", "-f Dockerfile .")
                }
            }
        }
    
        stage('Logging into AWS ECR') {
                steps {
                    script {
                    sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/registry"""
                    }
                     
                }
            }

        stage('Push to ECR') {
            steps {
                script {
                    sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}"""
                        }
                    }
                }
       
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """kubectl apply -f deploy.yaml && kubectl apply -f svc.yaml && kubectl apply -f ing.yaml"""
                        }

                   }
                }

            }
}
