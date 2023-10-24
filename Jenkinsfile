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
    }
}
