pipeline{
    agent any     
    stages {
        
        stage('Git Checkout'){
            steps{                
                script{
                    git branch: 'main', url: 'https://github.com/saeedalig/Deploying-Java-App-with-Jenkins.git'
                }
            }
        }

        stage('UNIT Testing: MVN'){
            steps{  
                script{
                    sh 'mvn test'
                }
            }
        }

        stage('Integration Testing: MVN'){            
            steps{                
                script{
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }

        stage('Maven Build: MVN'){
            steps{
                script{ 
                    sh 'mvn clean install'
                }
            }
        }

        // stage('Static Code Analysis: SonarQube'){ 
        //     steps{ 
        //         script{
        //             withSonarQubeEnv(credentialsId: 'sonar-creds') {  
        //                 sh 'mvn clean package sonar:sonar'
        //                 }
        //             }
                    
        //         }
        //     }

        //     stage('Quality Gate Status: SonarQube'){
        //         steps{
        //             script{ 
        //                 waitForQualityGate abortPipeline: false, credentialsId: 'sonar-creds'
        //            }
        //       }
        //  }

        stage('Upload Jar file to Nexus'){
            steps{
                script{ 
                    nexusArtifactUploader artifacts: 
					[
						[
							artifactId: 'springboot', 
							classifier: '', 
							file: 'target/Uber.jar', 
							type: 'jar'
						]
					], 
					credentialsId: 'nexus-creds', 
					groupId: 'com.example', 
					nexusUrl: '172.30.119.251:8081', 
					nexusVersion: 'nexus3', 
					protocol: 'http', 
					repository: 'demo-release', 
					version: '1.0.0'
                }
            }
        }
    }
}
