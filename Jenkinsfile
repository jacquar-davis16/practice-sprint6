pipeline {
    agent none
    stages {
        stage('Build') {
            steps {
                awsCodeBuild credentialsType: 'keys', projectName: 'DDs-CodeBuild-Project', region: 'eu-east-1', sourceControlType: 'project'
               echo 'This is the build stage.'
            }
        }

        stage('Testing') {
            steps {

               echo 'This is the test stage.'
            }
        }

        stage('E2E Testing') {
            steps {

               echo 'This is the E2E Testing stage.'
            }
        }

        stage('Deploy') {
            steps {

               echo 'This is the deploy stage.'
            }
        }
    }
}