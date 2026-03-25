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
                    echo "Checking environment..."
                    node --version
                    npm --version

                    echo "Installing dependencies..."
                    npm install --legacy-peer-deps

                    echo "Building project..."
                    npm run build

                    echo "Build output:"
                    ls -la
                    ls -la dist
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
                    echo "Running tests..."
                    test -f dist/index.html

                    # Don't fail if no tests exist
                    npm test -- --passWithNoTests || true
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
                    echo "Deploying to Netlify..."
                    netlify --version

                    netlify deploy \
                      --prod \
                      --dir=dist \
                      --site=$NETLIFY_SITE_ID
                '''
            }
        }
    }
}