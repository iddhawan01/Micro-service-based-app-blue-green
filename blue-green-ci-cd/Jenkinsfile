pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/your-org/blue-green-ci-cd.git'
            }
        }

        stage('Build & Push Docker Images') {
            steps {
                script {
                    sh 'docker build -t myrepo/service1:${env.BRANCH_NAME} ./service1'
                    sh 'docker build -t myrepo/service2:${env.BRANCH_NAME} ./service2'
                    sh 'docker build -t myrepo/service3:${env.BRANCH_NAME} ./service3'
                    sh 'docker push myrepo/service1:${env.BRANCH_NAME}'
                    sh 'docker push myrepo/service2:${env.BRANCH_NAME}'
                    sh 'docker push myrepo/service3:${env.BRANCH_NAME}'
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