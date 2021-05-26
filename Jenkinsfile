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
		      sh '''
          if [ "main" = ${BRANCH_NAME} ]; then
              do
                "checkov -d envs/dev -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
              done
          else
              echo "I else, branch not main"
          fi
          '''
                 }
            }
        }
}
}
