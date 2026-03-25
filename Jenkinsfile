pipeline {
    agent any
    environment {
        NETLIFY_SITE_ID = 'fec4d5ad-cc8e-4d5c-bb7a-9dbb6915ba04'
        NETLIFY_AUTH_TOKEN = credentials('my-react-app')
    }
    stages {
        stage('Docker Build Image') {
            steps {
                sh 'docker build -t my-docker-image .'
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'my-docker-image'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm install --legacy-peer-deps
                    npm run build
                    ls -la
                '''
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'my-docker-image'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    test -f build/index.html
                    # Run tests but don’t fail if none exist
                    npm test -- --passWithNoTests
                '''
            }
        }
        stage('Deploy') {
            agent {
                docker {
                    image 'my-docker-image'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    netlify --version
                    echo "Site ID: $NETLIFY_SITE_ID"
                    netlify status
                    netlify deploy --prod --dir=build
                '''
            }
        }
    }
}