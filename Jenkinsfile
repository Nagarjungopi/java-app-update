pipeline {
    agent any
	environment {
	DOCKERHUB_CREDENTIALS=credentials('Dockerhub')
}
	  tools
    {
       maven 'Maven'
    }
	
 stages {
           stage ('sonarqube analysis') {
             steps {
                script {
            withSonarQubeEnv('sonarqube') {
            sh "mvn sonar:sonar"

        }
       } 
    }
}
	 stage('Execute Maven') {
           steps {
             
                sh 'mvn package'             
          }
        }

         stage('Login') {

			steps {
				sh 'echo Dockerhub | docker login -u jnagarjun -p p@ssW0rds '
			}
		}
	 
       stage('Docker image') {
           steps {
              
                sh 'docker build -t jnagarjun/sample:latest .' 
          }
        } 
	
       stage('Delete Previous Container ') {
           steps {
              
                sh 'docker rm -f sample ' 
          }
        } 
 
       stage('Push image') {
	       steps {
  			       sh  'docker push jnagarjun/sample:latest'
         		         		       			
       }
      }  
     
	 stage('Docker Container') {  
            steps 
			{
                sh 'docker run -d --name sample -p 8003:8080 jnagarjun/sample:latest'
 
            }
        }
	 
 
    }
}
    
