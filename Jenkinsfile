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
                sh "mkdir /home/$USER/.local"	
		sh "export PYTHONUSERBASE=/home/$USER/.local"
		sh "echo $PYTHONUSERBASE"
		sh "pip install --user pipenv"
	        sh "pipenv run checkov --directory envs/dev -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
          }
            }
        }
}
}
