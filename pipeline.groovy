pipeline {
    agent any

    environment {
        IMAGE_NAME = 'flask-app'
        IMAGE_TAG = 'latest'
        // Optional: Set if pushing to a registry, e.g., docker.io/yourusername
        DOCKER_REGISTRY = '' 
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                echo 'Cloning code from GitHub...'
                git branch: 'main', url: 'https://github.com/karan-negx/prom-monitoring-app.git'
            }
        }

        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
        //             sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
        //         }
        //     }
        // }

        // stage('Run Docker Container Test (Optional)') {
        //     steps {
        //         script {
        //             echo 'Running a container to test the image...'
        //             sh """
        //                 docker run -d --name flask-app-container ${IMAGE_NAME}:${IMAGE_TAG}
        //                 sleep 5
        //                 docker logs flask-app-container
        //                 docker stop flask-app-container && docker rm flask-app-container
        //             """
        //         }
        //     }
        // }
    }

    // post {
    //     always {
    //         echo 'Cleaning up Docker resources...'
    //         sh 'docker system prune -f'
    //     }
    //     success {
    //         echo 'Pipeline completed successfully!'
    //     }
    //     failure {
    //         echo 'Pipeline failed.'
    //     }
    // }
}
