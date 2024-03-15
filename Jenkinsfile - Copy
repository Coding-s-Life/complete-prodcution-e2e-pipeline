pipeline{
	agent{
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
        DOCKER_REGISTRY = 'https://hub.docker.com/repository/docker/eagertolearn001/completeprodcutione2epipeline/general'
        DOCKER_USER = "docker_username"
        DOCKER_PASS = 'docker_token'
        IMAGE_NAME = "${DOCKER_USER}"  + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages{
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }

        }

        stage("Checkout from SCM"){
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Coding-s-Life/complete-prodcution-e2e-pipeline'
            }

        }

        stage("Build Application"){
            steps {
                bat 'mvn clean package'
            }
        }

        stage("Test Application"){
            steps {
                bat 'mvn test'
            }
        }

        stage("SonarQube Static Code Analysis"){
            steps {
                script {
                        withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
                        bat 'mvn sonar:sonar'
                    }
                }
            }
        }

        //stage("SonarQube Quality Gate"){
          //  steps {
            //    script {
              //      waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube-token'
               //  }
            // }
        //}
       // stage('Docker login') {
         //   steps {
           //     withCredentials([usernamePassword(credentialsId: 'docker_token', DOCKER_USER: 'DOCKER_USERNAME', DOCKER_PASS: 'DOCKER_PASSWORD')]) {
             //       bat "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
               // }
            //}
        //}
        stage("Build & Push Docker Image") {
            steps {
                script {
//                         withCredentials([usernamePassword(credentialsId: 'docker_token', DOCKER_USER: 'DOCKER_USERNAME', DOCKER_PASS: 'DOCKER_PASSWORD')]) {
//                             bat "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        withCredentials([usernamePassword(credentialsId: 'docker_token', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            bat 'docker login -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY'
                            bat 'docker build -t your-image-name .'
                            bat 'docker push $DOCKER_REGISTRY/your-image-name'
                            bat "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }
    }
}