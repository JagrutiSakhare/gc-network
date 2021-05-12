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
            label 'master'
        }
    }
            steps {
                script {
                    try {
	            sh "pipenv run checkov --directory envs/dev -o junitxml > test-result.xml || true"
	            junit "test-result.xml"
        } catch (err) {
            if (currentBuild.result == 'UNSTABLE')
                currentBuild.result = 'SUCCESS'
            throw err
        }   }
            }
        }
}
}
