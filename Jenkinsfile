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

        // stage('UNIT Testing: MVN'){
        //     steps{  
        //         script{
        //             sh 'mvn test'
        //         }
        //     }
        // }

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
				
					def READ_POM_VERSION = readMavenPom file : 'pom.xml'   // variablizing version
					def NEXUS_REPO = READ_POM_VERSION.version.endsWith("SNAPSHOT") ? "javaApp-snapshot" : "javaApp-release"
					
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
					repository: NEXUS_REPO, 
					version: "${READ_POM_VERSION.version}"
                }
            }
        }

	    stage ("Docker Image Build & Tag") {
            steps {
                script {
                    sh "docker image build -t ${JOB_NAME}:v1.${BUILD_ID} ."
					sh "docker image tag ${JOB_NAME}:v1.${BUILD_ID} asa96/${JOB_NAME}:v1.${BUILD_ID}"
					sh "docker image tag ${JOB_NAME}:v1.${BUILD_ID} asa96/${JOB_NAME}:latest"
                }
            }
        }
    }
}
