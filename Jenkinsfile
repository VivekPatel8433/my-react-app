pipeline {
    agent any
    environment {
        NETLIFY_SITE_ID = 'fec4d5ad-cc8e-4d5c-bb7a-9dbb6915ba04'
        NETLIFY_AUTH_TOKEN = credentials('my-react-app')
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:24.14.0-alpine'
                    args '-u root' // ensures permissions inside container
                }
            }
            steps {
                sh '''
                    node --version
                    npm --version
                    npm install
                    npm run build
                '''
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'node:24.14.0-alpine'
                    args '-u root'
                }
            }
            steps {
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }
        stage('Deploy') {
            agent any
            steps {
                sh '''
                    npm install -g netlify-cli
                    netlify --version
                    netlify status
                    netlify deploy --prod --dir=build
                '''
            }
        }
    }
}