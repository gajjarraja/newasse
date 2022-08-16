pipeline {
    agent {
        docker {
            image 'maven:3.6.3' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
    }
    environment {
        registry = "rajgajjar/docker"
        registryCredential = 'docker-hub'
        dockerImage = ''
    }
    
	stages('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/RAJGAJJARSWAMI/newasse.git']]])
            }
        }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
    stage('Upload Image') {
     steps{    
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            }
        }
      }
    }
     stage('docker stop container') {
         steps {
            sh 'docker ps -f name=tomcat -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=tomcat -q | xargs -r docker container rm'
         }
       }
    
    stage('Docker Run') {
     steps{
         script {
            dockerImage.run("-p 8080:5000 --rm --name tomcat")
         }
      }
    }
	stage ('Deploying onto k8s') {
		steps{
			dir ('/var/lib/jenkins/workspace/dockerpiplinejob') {
			sh "kubectl apply -f deploy.yml"
			}
			}
		}
	}
}
