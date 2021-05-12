pipeline {
  agent none
  stages {
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checkov:5.0'
	    //args '-u root --privileged'  
        }
    }
            steps {
              script {	
		sh "echo $HOME"      
	        sh "checkov --directory envs/dev -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
          }
            }
        }
}
}
