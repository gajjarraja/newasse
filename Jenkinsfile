pipeline {
    agent any
	 tools { 
            maven '3.6.3'
    }
stages {
	stage('Build Maven') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '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', url: 'https://github.com/RAJGAJJARSWAMI/newasse.git']]])
                sh "mvn install" 
		sh "mvn -Dmaven.test.failure.ignore=true clean package"
	    } 
            }
        
        stage ('Build Docker Image') {
            steps {
                script {
		   sh 'docker build -t rajgajjar/new1234:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerid', url: '') {
			   sh 'docker push rajgajjar/new1234:latest'
		    }
                    
                }
            }
        }
	stage('File transfer into minikube server') {
            steps {
		    sshagent(['kubernetes_server']){
		    sh 'ssh -o StrictHostKeyChecking=no root@172.31.1.90' 	    
	            sh 'scp -r /var/lib/jenkins/workspace/assesment2/* root@172.31.1.90:/home/ubuntu/'
		    sh """
	    		#!/bin/bash
 	    		ssh root@172.31.1.90 << EOF
       	    		cd project
            		helm install mytasknew demochart
	    		exit
	    		<< EOF
	    		"""
		    }
		 }		
	} 
		    
}

    

}
