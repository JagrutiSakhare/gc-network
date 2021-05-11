pipeline {
  agent none
  environment {
    _POLICY_REPO=""
  }

  stages {
 
 
	stage('test') {
	   agent {
        docker {
            image 'harshasakhare/checkov:1.0'
            label 'master'
        }
    }
            steps {
                script {
                    try {
                    sh "export LC_ALL=C.UTF-8"
                    sh "export LANG=C.UTF-8"
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
