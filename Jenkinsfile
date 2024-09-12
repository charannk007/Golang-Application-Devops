pipeline {
    agent any

    environment {
        USER_NAME = 'nkcharan'
        IMAGE_NAME = 'golang'
        DOCKERHUB_CREDENTIALS = credentials('dockers')
        IMAGE_VERSION = 'v2'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the repository
                git url: 'https://github.com/charannk007/Golang-Application-Devops.git', branch: 'main'
            }
        }

        stage('Remove Existing Images and Containers') {
            steps {
                script {
                    // Stop and remove any running containers and remove images
                    sh 'docker stop $(docker ps -aq) || true'
                    sh 'docker rm $(docker ps -aq) || true'
                    sh 'docker rmi -f $(docker images -q) || true'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Building Docker image using Dockerfile
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Running Docker container
                    sh 'docker run -d -p 8082:9090 --name golangc ${IMAGE_NAME}:${IMAGE_VERSION}'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    // Docker login using credentials
                    withCredentials([usernamePassword(credentialsId: 'dockers', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    }
                }
            }
        }

        stage('Create Image Tag') {
            steps {
                // Tagging the Docker image
                sh 'docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ${USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Pushing the Docker image to DockerHub
                sh 'docker push ${USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}'
            }
        }
    }
}
