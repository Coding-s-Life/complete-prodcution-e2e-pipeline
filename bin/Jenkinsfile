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
        PATH = "C:\\WINDOWS\\SYSTEM32;C:\\WINDOWS\\SYSTEM32;C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"
        DOCKER_REGISTRY = 'https://hub.docker.com/repository/docker'
        DOCKER_USER = "eagertolearn001"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        BUILD_NUMBER = "700"
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
                bat 'mvn install -Dmaven.install.directory=target'
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
        stage("Build Docker Image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_token', toolName: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        withDockerRegistry(credentialsId: 'docker_token', toolName: 'docker') {
                        // Docker login
                       // bat "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS} ${DOCKER_REGISTRY}"
                        //bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin ${DOCKER_REGISTRY}"

                        
                        // Build Docker image  APP_NAME
                        // bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."

                        // Worked  bat "docker build -t completeproduction -f Dockerfile ."
                        bat "docker build -t ${APP_NAME} -f Dockerfile ."

                          //bat "docker push eagertolearn001/completeprodcutione2epipeline:1.0.0-137"

                        //bat "docker build -t ${IMAGE_NAME} ."
                        
                        // Tag Docker image
                        //bat "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                        
                        // Push Docker image to registry
                        //bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                        // docker push eagertolearn001/completeprodcutione2epipeline:1.0.0-137
                        //bat "echo ${DOCKER_REGISTRY}/${IMAGE_NAME}"
                        //bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}"
                        
                        // Tag and push latest image
                        //bat "docker tag docker_username/complete-prodcution-e2e-pipeline:1.0.0-137 eagertolearn001/completeprodcutione2epipeline:1.0.0-137"
                        //bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                        //bat "docker push eagertolearn001/complete-prodcution-e2e-pipeline:1.0.0-137"
                        //bat "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                        }
                    }
                }
            }
        }
        stage("TAG Docker Image"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker_token', toolName: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        withDockerRegistry(credentialsId: 'docker_token', toolName: 'docker') {
                            bat "docker tag ${APP_NAME} ${IMAGE_NAME}:${IMAGE_TAG}"
                        }
                    }
                }
            }
        }
        stage("PUSH Docker Image") {
            steps {
                   withCredentials([usernamePassword(credentialsId: 'docker_token', toolName: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        script {
                            withDockerRegistry(credentialsId: 'docker_token', toolName: 'docker') {
                                bat "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                            }
                        }
                   }
            }
        }

        stage("DEPLOY to Docker Container To Run Application"){
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_token', toolName: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                    script {
                        withDockerRegistry(credentialsId: 'docker_token', toolName: 'docker') {
                                bat "docker rm demoapp1"
                                bat "docker run -d --name demoapp1 -p 8098:8098 ${IMAGE_NAME}:${IMAGE_TAG}"
                        }
                    }
                }
            }
        }
    }
}
