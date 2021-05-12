pipeline {
  agent none
  stages {
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checkov:4.0'
	    //args '-u root --privileged'  
        }
    }
            steps {
                script {	
		    sh "PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin""
                    sh "PATH="$PATH:$PYTHON_BIN_PATH""	
	            sh "pipenv run checkov --directory envs/dev -o junitxml > test-result.xml || true"
	            junit "test-result.xml"
          }
            }
        }
}
}
