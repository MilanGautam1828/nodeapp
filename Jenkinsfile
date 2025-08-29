pipeline {
  agent any

  environment {
    AWS_REGION       = "us-east-1"
    S3_BUCKET        = "nodeapp-deployments-pro"
    APP_NAME         = "nodeapp-codedeploy"
    DEPLOYMENT_GROUP = "nodeapp-dg"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/MilanGautam1828/nodeapp', credentialsId: 'git-cred'
      }
    }

    stage('Install (CI)') {
      steps {
        sh '''
          echo "Node $(node -v) NPM $(npm -v)"
          npm ci || npm install
        '''
      }
    }

    stage('Package') {
      steps {
        sh '''
          ART=nodeapp-${BUILD_ID}.zip
          zip -r "$ART" appspec.yml scripts package.json server.js public || true
          ls -lh "$ART"
        '''
      }
      post { 
        always { 
          archiveArtifacts artifacts: "nodeapp-${BUILD_ID}.zip", fingerprint: true 
        } 
      }
    }

    stage('Upload to S3') {
      steps {
        sh '''
          export AWS_DEFAULT_REGION=${AWS_REGION}
          ART=nodeapp-${BUILD_ID}.zip
          aws s3 cp "$ART" "s3://${S3_BUCKET}/$ART"
          echo "Uploaded s3://${S3_BUCKET}/$ART"
        '''
      }
    }

    stage('Trigger CodeDeploy') {
      steps {
        sh '''
          export AWS_DEFAULT_REGION=${AWS_REGION}
          ART=nodeapp-${BUILD_ID}.zip
          DEPLOY_ID=$(aws deploy create-deployment \
            --application-name "${APP_NAME}" \
            --deployment-group-name "${DEPLOYMENT_GROUP}" \
            --s3-location bucket=${S3_BUCKET},key=${ART},bundleType=zip \
            --query "deploymentId" --output text)
          echo "CodeDeploy started: ${DEPLOY_ID}"
        '''
      }
    }
  }

  post {
    success { echo "

