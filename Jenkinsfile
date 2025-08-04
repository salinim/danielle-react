pipeline {
    agent any

    environment {
        IMAGE_NAME = 'salini10/danielle-react-app'
        REPO_DIR = 'C:/IPBSampleReactCode/product-builder-ae-frontend'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                dir("${env.REPO_DIR}") {
                    bat 'npm install'
                }
            }
        }

        stage('Build React App') {
            steps {
                dir("${env.REPO_DIR}") {
                    bat 'npm run build'
                }
            }
        }
		
		stage('Generate Tags') {
            steps {
                script {
                    def version = powershell(script: "(Get-Content package.json | Out-String | ConvertFrom-Json).version", returnStdout: true).trim()
                    def ts = new Date().format("yyyyMMddHHmm")
                    
                    env.IMAGE_COMBINED = "${env.IMAGE_NAME}:${version}-build-${env.BUILD_NUMBER}-${ts}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${env.REPO_DIR}") {
                    bat "nerdctl build -t %IMAGE_COMBINED% ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat '''
                        docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                        nerdctl push %IMAGE_COMBINED%
                    '''
                }
            }
        }
    }
}
