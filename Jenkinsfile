pipeline {
    agent any
    environment {
        NETLIFY_SITE_ID = 'fec4d5ad-cc8e-4d5c-bb7a-9dbb6915ba04'
        NETLIFY_AUTH_TOKEN = credentials('my-react-app')
    }
    stages {
        stage('Setup') {
            steps {
                // Just check Node & NPM
                bat 'node --version'
                bat 'npm --version'
            }
        }
        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }
        stage('Build') {
            steps {
                bat 'npm run build'
            }
        }
        stage('Test') {
            steps {
                bat '''
                if exist build\\index.html (
                    echo Build exists!
                ) else (
                    echo Build missing!
                    exit 1
                )
                npm test
                '''
            }
        }
        stage('Deploy') {
            steps {
                bat '''
                npx netlify --version
                echo Site ID: %NETLIFY_SITE_ID%
                npx netlify status
                npx netlify deploy --prod --dir=build
                '''
            }
        }
    }
}