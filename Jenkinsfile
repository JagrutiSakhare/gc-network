pipeline {
  agent none
  environment {
    _POLICY_REPO=""
  }

  stages {
 
 
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checkov:4.0'
        }
    }
            steps {
                script {
                    sh "pipenv install"
                    sh "pipenv run pip install checkov"  	    
	            sh "pipenv run checkov --directory envs/dev -o junitxml > test-result.xml || true"
	            junit "test-result.xml"
          }
            }
        }
}
}
