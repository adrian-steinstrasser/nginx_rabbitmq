pipeline {
    agent any
    
    stages {
        stage('Criando ambiente AWS Nginx + RabbitMQ') {
            steps {
                git url: 'https://github.com/adrian-steinstrasser/nginx_rabbitmq.git', branch: 'master'
                sh 'ls'
            }
        }
    }
}