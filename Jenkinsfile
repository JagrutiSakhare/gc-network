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
	    args '-u root --privileged'
	    
        }
    }
            steps {
                script {	    
	            sh "pipenv run checkov --directory envs/dev -o junitxml > test-result.xml || true"
	            junit "test-result.xml"
          }
            }
        }
}
}
