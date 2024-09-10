pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the repository
                git url: 'https://github.com/charannk007/Golang-Application-Devops.git', branch: 'main'
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
                    sh 'docker run -d -p 8082:8081 --name golangc golang:v1'
                }
            }
        }
    }

    post {
        always {
            // Clean up: stopping and removing the container after the pipeline execution
           sh 'Success'
        }
    }
}
