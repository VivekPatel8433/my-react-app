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
            echo "Deploying to Netlify site $NETLIFY_SITE_ID"
            netlify deploy --prod --dir=build --site=$NETLIFY_SITE_ID
        '''
    }
}