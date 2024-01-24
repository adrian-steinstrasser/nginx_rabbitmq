pipeline {
    agent any
    
    stages {
        stage('Validando GIT') {
            steps {
                git url: 'https://github.com/adrian-steinstrasser/nginx_rabbitmq.git', branch: 'master'
                sh 'ls'
            }
        }
        stage('Criando ambiente AWS Nginx + RabbitMQ') {
            environment{
                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
            }
            steps {
                script{
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}