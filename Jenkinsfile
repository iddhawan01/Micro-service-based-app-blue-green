pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/iddhawan01/Micro-service-based-app-blue-green.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh '''#!/bin/bash
                    docker build -t myrepo/service1:${BRANCH_NAME} ./service1
                    docker build -t myrepo/service2:${BRANCH_NAME} ./service2
                    docker build -t myrepo/service3:${BRANCH_NAME} ./service3
                    '''
        }
    }
}

        stage('Provision Infra with Terraform') {
            steps {
                dir('terraform') {
                    sh "terraform init"
                    sh "terraform apply -auto-approve -var env=${env.BRANCH_NAME}"
                }
            }
        }

        stage('Deploy Containers') {
            steps {
                sh '''
                  ssh -o StrictHostKeyChecking=no ec2-user@${DOCKER_SERVER} \
                  "docker run -d -p 8080:8080 myrepo/service1:${BRANCH_NAME}"
                '''
            }
        }

        stage('Blue-Green Switch') {
            steps {
                sh "./scripts/update-alb.sh ${env.BRANCH_NAME}"
            }
        }
    }
}
