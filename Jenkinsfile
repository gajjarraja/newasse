pipeline {
    agent any
    tools {
        maven 'MAVEN'
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '9b9be042-01de-4e2b-881d-118a79fb4fb6', url: 'https://github.com/Rutu2211/DevOps-Assessment.git']]])
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
	//	sh "mvn install"    
	//	sh "mvn clean package"
		 
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t slkrt2211/testrepo .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'slkrt2211', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u slkrt2211 -p ${dockerhubpwd}'
}
                    sh 'docker push slkrt2211/testrepo'
                }
            }
        }
	stage('File transfer into minikube server') {
            steps {
	        sh 'scp -r /var/lib/jenkins/workspace/jenkins-docker/* ubuntu@172.31.17.56:/home/ubuntu/project'
			}		
	} 
	stage('Login into minikube server and run helm chart') {
            steps {
	    sh """
	    #!/bin/bash
 	    ssh ubuntu@172.31.17.56 << EOF
       	    cd project
            helm install mytasknew demochart
	    exit
	    << EOF
	    """
			}
		}
    }

}
