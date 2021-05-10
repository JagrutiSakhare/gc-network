pipeline {
  agent any

  environment {
    _POLICY_REPO=""
  }

  stages {
    stage('setup') {
      steps {
          sh '''
          echo "Setting up gcloud for impersonation"
          echo "Adding bucket information to backends"
          for i in `find -name "backend.tf"`; do sed -i "s/UPDATE_ME/${TF_VAR_state_bucket}/" $i; done
          # TODO put elsewhere, read from versions.tf?
          # TF_VERSION=0.13
          # tfenv install ${TF_VERSION}
          # tfenv use ${TF_VERSION}
          mkdir -p $(pwd)/bin
          export PATH=$(pwd)/bin:$PATH
          ln -sf $(which terraform13) $(pwd)/bin/terraform
          env
          chmod +x ./tf-wrapper.sh
          '''
        }
    }
    stage('TF plan validate all') {
      when {
        not {
            anyOf {
                branch 'dev'
                branch 'tuc'
                branch 'tud'
                branch 'prd'
                branch 'cobande'
            }
        }
      }
      steps {
          sh '''
          export PATH=$(pwd)/bin:$PATH
          ./tf-wrapper.sh plan_validate_all main ${_POLICY_REPO}
          '''
        }
    }
	stage('test') {
			when {
        anyOf {
		    branch 'main'
            branch 'dev'
            branch 'tuc'
            branch 'tud'
            branch 'prd'
            branch 'cobande'
        }
      }
            steps {
                script {
                    try {
                    sh "pipenv run pip install checkov"
                    sh "pipenv run checkov --directory envs/dev -o junitxml > result.xml || true"
                    junit "result.xml"
        } catch (err) {
            if (currentBuild.result == 'UNSTABLE')
                currentBuild.result = 'SUCCESS'
            throw err
        }   }
            }
        }
    stage('TF init') {
      when {
        anyOf {
            branch 'dev'
            branch 'tuc'
            branch 'tud'
            branch 'prd'
            branch 'cobande'
        }
      }
      steps {
          sh '''
          export PATH=$(pwd)/bin:$PATH
          if [ "cobande" = ${BRANCH_NAME} ]; then
              #for ENVIRONMENT in dev tuc tud prd
              for ENVIRONMENT in dev
              do
                ./tf-wrapper.sh init ${ENVIRONMENT}
              done
          else
              ENVIRONMENT=${BRANCH_NAME}
              ./tf-wrapper.sh init ${ENVIRONMENT}
          fi
          '''
        }
    }
    stage('TF plan') {
      when {
        anyOf {
            branch 'dev'
            branch 'tuc'
            branch 'tud'
            branch 'prd'
            branch 'cobande'
        }
      }
      steps {
          sh '''
          export PATH=$(pwd)/bin:$PATH
          if [ "cobande" = ${BRANCH_NAME} ]; then
              #for ENVIRONMENT in dev tuc tud prd
              for ENVIRONMENT in dev
              do
                ./tf-wrapper.sh plan ${ENVIRONMENT}
              done
          else
              ENVIRONMENT=${BRANCH_NAME}
              ./tf-wrapper.sh plan ${ENVIRONMENT}
          fi
          '''
        }
    }
    stage('TF validate') {
      when {
        anyOf {
            branch 'dev'
            branch 'tuc'
            branch 'tud'
            branch 'prd'
            branch 'cobande'
        }
      }
      steps {
          sh '''
          export PATH=$(pwd)/bin:$PATH
          if [ "cobande" = ${BRANCH_NAME} ]; then
              #for ENVIRONMENT in dev tuc tud prd
              for ENVIRONMENT in dev
              do
                ./tf-wrapper.sh validate ${ENVIRONMENT}
              done
          else
              ENVIRONMENT=${BRANCH_NAME}
              ./tf-wrapper.sh validate ${ENVIRONMENT} ${POLICY_REPO}
          fi
          '''
        }
    }
    stage('TF wait for approval') {
      when {
        anyOf {
            branch 'dev'
            branch 'tuc'
            branch 'tud'
            branch 'prd'
            branch 'cobande'
        }
      }
      options {
          timeout(time: 10, unit: 'MINUTES')
      }
      steps {
          script {
            def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
          }
        }
    }
    stage('TF apply') {
      when {
        anyOf {
            branch 'dev'
            branch 'tuc'
            branch 'tud'
            branch 'prd'
            branch 'cobande'
        }
      }
      steps {
          sh '''
          export PATH=$(pwd)/bin:$PATH
          if [ "cobande" = ${BRANCH_NAME} ]; then
              #for ENVIRONMENT in dev tuc tud prd
              for ENVIRONMENT in dev
              do
                ./tf-wrapper.sh apply ${ENVIRONMENT}
              done
          else
              ENVIRONMENT=${BRANCH_NAME}
              ./tf-wrapper.sh apply ${ENVIRONMENT} $POLICY_REPO
          fi
          '''
        }
    }
  }
}
