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
                sh "checkov -d envs/dev -o junitxml > dev-result.xml || true"
		junit dev-result.xml 
                 }
            }
        }
}
}
