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
            steps {
                sh 'terraform init'
                sh 'terraform apply'
            }
        }
    }
}
