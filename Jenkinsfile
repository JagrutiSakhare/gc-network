pipeline {
  agent none
  stages {
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checkov:2.0'
        }
    }
            steps {
              script {	
	        sh "checkov --directory envs/dev -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
          }
            }
        }
}
}
