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
    }
}
