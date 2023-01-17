pipeline {
    agent any
      	  tools
    {
       maven 'Maven'
    }

    stages {
         stage('Execute Maven') {
           steps {
             
                sh 'mvn package'             
          }
        }

        stage('SonarQube analysis 1') {
            steps {
                sh 'mvn clean package sonar:sonar'
            }
        }
        stage("Quality Gate 1") {
            steps {
                waitForQualityGate abortPipeline: true
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
