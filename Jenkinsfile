pipeline {
    agent any
    environment {
        NETLIFY_SITE_ID = 'fec4d5ad-cc8e-4d5c-bb7a-9dbb6915ba04'
        NETLIFY_AUTH_TOKEN = credentials('my-react-app')
    }
    stages {
        stage('Setup') {
            steps {
                sh 'node --version'
                sh 'npm --version'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Test') {
            steps {
                sh '''
                if [ -f build/index.html ]; then
                    echo "Build exists!"
                else
                    echo "Build missing!"
                    exit 1
                fi
                npm test
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                npx netlify --version
                echo "Site ID: $NETLIFY_SITE_ID"
                npx netlify status
                npx netlify deploy --prod --dir=build
                '''
            }
        }
    }
}