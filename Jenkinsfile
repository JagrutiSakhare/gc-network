pipeline {
  agent none
  environment {
    _POLICY_REPO=""
  }

  stages {
 
 
	stage('test') {
	   agent {
        docker {
            image 'gcr.io/acn-hybridcloudapplications/checkov:1.0'
            args '-u root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
            label 'master'
        }
    }
            steps {
                script {
                    try {
                    sh "pipenv run pip install checkov"
                   
	            sh "pipenv run checkov --directory envs/shared -o junitxml > result-shared.xml || true"
                  
	            junit "result-shared.xml"
        } catch (err) {
            if (currentBuild.result == 'UNSTABLE')
                currentBuild.result = 'SUCCESS'
            throw err
        }   }
            }
        }
}
}
