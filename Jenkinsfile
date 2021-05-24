pipeline {
  agent any
  stages {
	stage('test') {
            steps {
              script {	
	        sh "checkov --directory envs/dev -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
                 }
            }
        }
}
}
