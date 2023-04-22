pipeline {
    agent any

    stages {
        stage('Pull Source Code from SCM') {
            steps {
                git 'https://github.com/kundan344/CI-CD_Web_Application.git'
            }
        }
        stage('Copy code on Docker-server') {
            steps {
                sshagent(['jenkins-123']) {
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170'
                sh 'rsync -ivhr /var/lib/jenkins/workspace/Newlife_cicd_project/* root@172.31.37.170:'
}
            }
        }
        stage('Build Docker Image') {
            steps {
                sshagent(['jenkins-123']) {
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker build -t $JOB_NAME:v1.$BUILD_ID .'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker image tag $JOB_NAME:v1.$BUILD_ID kundankumar344/$JOB_NAME:v1.$BUILD_ID'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker image tag $JOB_NAME:v1.$BUILD_ID kundankumar344/$JOB_NAME:latest'
}
            }
        }
        stage('Push Docker Image on Docker Hub') {
            steps {
                sshagent(['jenkins-123']) {
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170'
                withCredentials([string(credentialsId: 'docpass', variable: 'dockerpassword')]) {
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker login -u kundankumar344 -p ${dockerpassword}'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker push kundankumar344/$JOB_NAME:v1.$BUILD_ID'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker push kundankumar344/$JOB_NAME:latest'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.37.170 docker rmi -f $JOB_NAME:v1.$BUILD_ID $JOB_NAME:v1.$BUILD_ID kundankumar344/$JOB_NAME:v1.$BUILD_ID $JOB_NAME:v1.$BUILD_ID kundankumar344/$JOB_NAME:latest  '
                
}
                
                
}
            }
        }
        stage('Deploye Code on Prod Server') {
            steps {
                sshagent(['web123']) {
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.41.95'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.41.95 docker service rm prodapp'
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.41.95 docker rmi -f kundankumar344/newlifecicd_project:latest'
                
                sh 'ssh -o StrictHostKeyChecking=no root@172.31.41.95 docker service create --name prodapp --replicas 4 -p 80:80 kundankumar344/newlifecicd_project:latest'
                
}
            }
        }
             
    }
}