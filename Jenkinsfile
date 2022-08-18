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
                    withDockerRegistry(credentialsId: 'dockerid', url: ''){
			   sh 'docker push rajgajjar/new1234:latest'
		    }
                    
                }
            }
        }
	stage('File transfer into minikube server') {
            steps {
		    sshagent(['kubernetes_server']){ 	    
	        //    sh 'scp -r /var/lib/jenkins/workspace/newasses2 gajjarraj_se@34.125.147.240:/home/gajjarraj_se'
		    sh """
	    		#!/bin/bash
 	    		ssh gajjarraj_se@34.125.147.240<< EOF
       	    		cd home/gajjarraj_se
            		helm install mytasknew demochart
	    		exit
	    		<< EOF
	    		"""
		    }
		 }		
	} 
		    
}

    

}
