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
	        junit "new-result.xml"
                 }
            }
        }
}
}
