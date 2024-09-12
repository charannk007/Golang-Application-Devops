pipeline {
    agent any

    environment {
        USER_NAME = 'nkcharan'
        IMAGE_NAME = 'golang'
        DOCKERHUB_CREDENTIALS = credentials('dockers')
        IMAGE_VERSION = 'v1'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the repository
                git url: 'https://github.com/charannk007/Golang-Application-Devops.git', branch: 'main'
            }
        }

    stage('Removing existing Images and Containers') {
      steps {
        script {
           
            sh 'docker stop $(docker ps -aq) || true'
            sh 'docker rm $(docker ps -aq) || true'
            sh 'docker rmi -f $(docker images -q) || true'
        }
      }
    }

        stage('Build Docker Image') {
            steps {
                script {
                    // Building Docker image using Dockerfile from the cloned repository
                    sh 'docker build -t golang:v1 .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Running Docker container
                    sh 'docker run -d -p 8082:9090 --name golangc golang:v1'
                }
            }
        }
    }

     stage('Docker Login') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockers', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
          }
        }
      }
    }

     stage('Creating the Image Tag') {
      steps {
        sh 'docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ${USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}'
      }
    }


     stage('Docker Push Image') {
      steps {
        sh 'docker push ${USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}'
      }
    }

}
