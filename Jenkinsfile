pipeline{
	agent{
        label "jenkins-agent"
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
        dockerTool 'DOCKER25'
    }
    environment {
        APP_NAME = "complete-prodcution-e2e-pipeline"
        RELEASE = "1.0.0"
        PATH = "C:\\WINDOWS\\SYSTEM32"
        DOCKER_USER = "docker_username"
        DOCKER_PASS = 'docker_token'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
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
        stage('Build Docker Image') {
            steps {
                script {
                    // Define Dockerfile location
                    def dockerfile = './Dockerfile'

                    // Build Docker image
                    //def customImage = docker.build('docker buildx build .')
                    def customImage = docker.build('complete-prodcution-e2e-pipeline', '-f ${dockerfile} .')

                    // Push Docker image to a registry (optional)
                    customImage.push('latest')
                }
            }
        }
    }
}