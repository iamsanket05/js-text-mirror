pipeline {
    agent any

    environment {
        // Replace with YOUR Docker Hub Username
        DOCKER_IMAGE = 'novoo/js-text-mirror' 
        registryCredential = 'docker-hub-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls code from GitHub
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Builds the image tagged with the Build Number (e.g., v1, v2)
                    sh "docker build -t $DOCKER_IMAGE:${BUILD_NUMBER} ."
                    sh "docker build -t $DOCKER_IMAGE:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Logs in and pushes
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push $DOCKER_IMAGE:${BUILD_NUMBER}"
                        sh "docker push $DOCKER_IMAGE:latest"
                    }
                }
            }
        }
        
        stage('Clean Up') {
            steps {
                // Removes image from Jenkins server to save space
                sh "docker rmi $DOCKER_IMAGE:${BUILD_NUMBER}"
                sh "docker rmi $DOCKER_IMAGE:latest"
            }
        }
    }
}
