pipeline {
    agent {
        label "jenkins-agent"
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        APP_NAME = "complete-prodcution-e2e-pipeline"
        RELEASE = "1.0.0"
        PATH = "C:\\WINDOWS\\SYSTEM32;C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"
        DOCKER_REGISTRY = 'https://hub.docker.com/repository/docker'
        DOCKER_USER = "eagertolearn001"
        DOCKER_PASS = 'docker_token'
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }
        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Coding-s-Life/complete-prodcution-e2e-pipeline'
            }
        }
        stage("Maven Validate") {
            steps {
                bat 'mvn validate'
            }
        }
        stage("Maven Compile") {
            steps {
                bat 'mvn compile'
            }
        }
        stage("Maven Test") {
            steps {
                bat 'mvn test'
            }
        }
        stage("Maven Package") {
            steps {
                bat 'mvn package'
            }
        }
        stage("Test Install") {
            steps {
                bat 'mvn install'
            }
        }

//         stage("Build Application") {
//             steps {
//                 bat 'mvn clean package'
//             }
//         }
//         stage("Test Application") {
//             steps {
//                 bat 'mvn test'
//             }
//         }
        stage("SonarQube Static Code Analysis") {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
                        bat 'mvn sonar:sonar'
                    }
                }
            }
        }
        stage("Build & Push Docker Image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_token', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        // Docker login
                       // bat "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS} ${DOCKER_REGISTRY}"
                        //bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin ${DOCKER_REGISTRY}"

                        
                        // Build Docker image
                        //bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                        bat "docker build -t ${IMAGE_NAME} ."
                        
                        // Tag Docker image
                        //bat "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                        
                        // Push Docker image to registry
                        //bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                        // docker push eagertolearn001/completeprodcutione2epipeline:1.0.0-137
                        bat "echo ${DOCKER_REGISTRY}/${IMAGE_NAME}"
                        bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}"
                        
                        // Tag and push latest image
                        //bat "docker tag docker_username/complete-prodcution-e2e-pipeline:1.0.0-137 eagertolearn001/completeprodcutione2epipeline:1.0.0-137"
                        //bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                        bat docker push eagertolearn001/complete-prodcution-e2e-pipeline:1.0.0-137

                    }
                }
            }
        }
    }
}
