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
                    node --version
                    npm --version

                    npm install --legacy-peer-deps
                    npm run build

                    echo "Checking dist folder..."
                    ls -la dist
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
                    echo "Deploying..."
                    export NETLIFY_AUTH_TOKEN=$NETLIFY_AUTH_TOKEN

                    netlify deploy \
                      --prod \
                      --dir=dist \
                      --site=$NETLIFY_SITE_ID
                '''
            }
        }
    }
}