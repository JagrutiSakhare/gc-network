pipeline {
  agent none
  stages {
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checkov:6.0'
           }
       }
            steps {
              script {	
	        sh "checkov --directory envs/dev -o junitxml > new-result.xml || true"
		sh "checkov --directory envs/tuc -o junitxml > tuc-result.xml || true"
	        junit "*-results.xml"
                 }
            }
        }
}
}
