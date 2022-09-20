pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
               awsCodeBuild credentialsType: 'keys', projectName: 'DDs-CodeBuild-Project', region: 'us-east-1', sourceControlType: 'project'
               echo 'This is the build stage.'
            }
        }

        stage('Testing') {
            steps {
               echo 'This is the test stage.'
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
               sh 'aws deploy create-deployment --application-name test_app --s3-location bucket=dd-bucket-testbuild-091622-2,bundleType=zip,key=output-here --deployment-group-name test-deployment_group --region us-east-1'
               echo 'This is the deploy stage.'
            }
        }
    }
}

//aws deploy create-deployment --application-name test_app --s3-location bucket=dd-bucket-testbuild-091622-2,bundleType=zip,key=output-here --deployment-group-name test-deployment_group --region us-east-1

//aws configure set region us-east-1