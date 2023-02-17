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
        stage ("push to s3"){
            steps{
                sh "cat ${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/log >>  ${JOB_NAME}-${BUILD_NUMBER}.log"

                sh  "aws s3 cp  ${JOB_NAME}-${BUILD_NUMBER}.log s3://jenkins-logfile/${JOB_NAME}-${BUILD_NUMBER}.log.log"
            }
        }
    }    
post{
        always{
            emailext to: "nagarjun.j@optisolbusiness.com",
            subject: "jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
            body: "status:${currentBuild.currentResult}: Job-name: ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}",
            attachLog: true
        }
    }
}
