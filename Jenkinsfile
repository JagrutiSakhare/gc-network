pipeline {
  agent any

  environment {
    _POLICY_REPO=""
  }

  stages {
 
 
	stage('test') {
	  when {
             branch 'main'
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
