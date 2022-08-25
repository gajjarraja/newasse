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
		   sh 'docker build -t rajgajjar/tomcat:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerid1', url: ''){
			   sh 'docker push rajgajjar/tomcat:latest'
		    }
                    
                }
            }
        }
	stage('File transfer into minikube server') {
            steps {
		    dir ('/var/lib/jenkins/workspace/assesment2@tmp')
		    sshagent(['kubernetes_server1']){ 	    
	            sh 'scp -r tomcat ubuntu@172.31.17.153:/home/ubuntu'
		    sh """
	    		#!/bin/bash
 	    		ssh -t ubuntu@172.31.17.153<< EOF
       	    		cd /home/ubuntu/newasse
            		helm install tomcat-chart tomcat/ --values tomcat/values.yaml
	    		exit
	    		<< EOF
	    		"""
		    }
		 }		
	} 
		    
}

    

}
