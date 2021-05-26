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
                "checkov -d envs/dev -o junitxml > dev-result.xml || true"
		"checkov -d envs/tuc -o junitxml > tuc-result.xml || true"
		 xunitmerge dev-result.xml tuc-result.xml
                 }
            }
        }
}
}
