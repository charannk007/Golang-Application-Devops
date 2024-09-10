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
                    sh 'docker build -t your-docker-image-name:latest .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Running Docker container
                    sh 'docker run -d -p 8083:8081 --name your-container-name your-docker-image-name:latest'
                }
            }
        }
    }

    post {
        always {
            // Clean up: stopping and removing the container after the pipeline execution
            sh 'docker stop your-container-name || true'
            sh 'docker rm your-container-name || true'
        }
    }
}
