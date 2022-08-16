pipeline {
    agent any
    tools {
        maven 'Maven-3.6.3' 
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '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', url: 'https://github.com/RAJGAJJARSWAMI/newasse.git']]])
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
	//	sh "mvn install"    
	//	sh "mvn clean package"
		 
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t rajgajjar/docker .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'rajgajjar', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u rajgjjar -p ${dockerhubpwd}'
}
                    sh 'docker push rajgajjar/docker'
                }
            }
        }
	stage('File transfer into minikube server') {
            steps {
	        sh 'scp -r /var/lib/jenkins/workspace/jenkins-docker/* ubuntu@172.31.1.90:/home/ubuntu/project'
			}		
	} 
	stage('Login into minikube server and run helm chart') {
            steps {
	    sh """
	    #!/bin/bash
 	    ssh ubuntu@172.31.1.90 << EOF
       	    cd project
            helm install mytasknew demochart
	    exit
	    << EOF
	    """
			}
		}
    }

}
