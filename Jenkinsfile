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
	        sh "checkov -d envs/dev -d envs/tuc -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
                 }
            }
        }
}
}
