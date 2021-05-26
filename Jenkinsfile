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
                "checkov -d envs/dev -o junitxml > test-result.xml || true"
	            junit "test-result.xml"
                 }
            }
        }
}
}
