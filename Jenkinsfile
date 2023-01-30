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
            steps 
			{
                sh 'docker run -d --name sample -p 8003:8080 jnagarjun/sample:latest'
 
            }
        }
    stage ('Email') {
        steps {
                emailext body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:
                Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'nagarjun.j@optisolbusiness.com'
             }
           }
        }
    } 
 
