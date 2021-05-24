pipeline {
  agent any
  stages {
	stage('test') {
            steps {
              script {	
		sh "sudo apt-get update -y  && apt-get install -y  apt-transport-https ca-certificates"
		sh "sudo apt install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y && apt update -y && apt install python3.7 -y"
		sh "sudo apt install python3-pip -y &&  pip3 install pipenv && python3.7 -m pip install -U checkov"
	        sh "checkov --directory envs/dev -o junitxml > test-result.xml || true"
	        junit "test-result.xml"
                 }
            }
        }
}
}
