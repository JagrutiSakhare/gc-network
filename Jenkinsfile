pipeline {
  agent none
  environment {
    _POLICY_REPO=""
  }

  stages {
 
 
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checov:3.0'
	    args '-u root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
            label 'master'
        }
    }
            steps {
                script {
                    try {
                    sh "pipenv run pip install checkov"
	            sh "pipenv run checkov --directory envs/dev -o junitxml > result.xml || true"
	            junit "result.xml"
        } catch (err) {
            if (currentBuild.result == 'UNSTABLE')
                currentBuild.result = 'SUCCESS'
            throw err
        }   }
            }
        }
}
}
