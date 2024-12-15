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
        CLONE_PATH = '/devops/projects/'
        // Docker image tag
        IMAGE_TAG = '2.0'
    }
    stages {
        stage('Clone GitHub Repository') {
            steps {
                script {
                    // Clean up the target directory if it exists
                    sh "rm -rf ${CLONE_PATH}chat-app"
                }
                // Clone the GitHub repository
                git branch: 'main',
                    credentialsId: "${GITHUB_CREDENTIALS_ID}", 
                    url: 'https://github.com/alzoghby/chat-app.git'
                // Move the cloned repository to the desired path
                sh "mkdir -p ${CLONE_PATH} && mv ${WORKSPACE} ${CLONE_PATH}chat-app"
            }
        }
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
                        sh "docker push
