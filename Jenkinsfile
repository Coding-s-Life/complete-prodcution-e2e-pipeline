pipeline{
	agent{
        label "jenkins-agent"
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        PATH = "C:\\WINDOWS\\SYSTEM32"
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
                    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
                    bat 'mvn sonar:sonar'
                }
            }
        }
	}
}