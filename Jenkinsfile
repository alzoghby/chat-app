pipeline {
    agent any
    environment {
        // Jenkins credential ID for Docker Hub
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        // Jenkins credential ID for GitHub repository
        GITHUB_CREDENTIALS_ID = 'github'
        // Docker Hub repository name
        DOCKER_REPO = 'alzoghby/chat-app'
        // Path on the server to clone the repository
        CLONE_PATH = '/test/'
        // Docker image tag
        IMAGE_TAG = '2.0'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    dir("${CLONE_PATH}chat-app") {
                        sh "docker build -t ${DOCKER_REPO}:${IMAGE_TAG} ."
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_REPO}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
