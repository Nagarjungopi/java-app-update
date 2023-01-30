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
            steps {	
                sh 'docker run -d --name sample -p 8003:8080 jnagarjun/sample:latest'
            }
        }
    }    
post{
        always{
            emailext to: "nagarjun.j@optisolbusiness.com",
            subject: "Test Email",
            body: "Test",
            attachLog: true
        }
    }
}
