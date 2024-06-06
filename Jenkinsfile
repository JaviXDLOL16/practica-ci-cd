pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'node-hello-world'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside('-u root') {
                        sh 'npm config set cache /tmp/.npm-cache --global'
                        sh 'npm install --unsafe-perm'
                        sh 'npm install mocha supertest --global'
                        sh 'npm test'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).run('-d -p 3000:3000')
                }
            }
        }
    }

    post {
        always {
            script {
                // Verificar si hay contenedores en ejecución antes de detenerlos
                if (docker.withServer('unix:///var/run/docker.sock') {
                    def containers = docker.containerList()
                    if (containers) {
                        sh 'docker stop ${containers.ids.join(" ")}'
                    }
                }
            }
        }
    }
}
