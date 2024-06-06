pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    def imageName = 'node-hello-world'
                    def containerName = 'node-hello-world-container'
                    
                    // Construir la imagen Docker
                    docker.build(imageName)

                    // Detener y eliminar el contenedor si está corriendo en el mismo puerto
                    try {
                        sh "docker stop ${containerName}"
                    } catch (Exception e) {
                        echo "No se encontró el contenedor ${containerName} corriendo."
                    }

                    try {
                        sh "docker rm ${containerName}"
                    } catch (Exception e) {
                        echo "No se encontró el contenedor ${containerName}."
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Instalar dependencias y ejecutar pruebas
                    docker.image('node-hello-world').inside {
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Ejecutar el contenedor Docker exponiendo el puerto 3000
                    docker.image('node-hello-world').run('-p 3000:3000', 'node index.js')
                }
            }
        }
    }

    post {
        always {
            // Limpiar el contenedor después de ejecutar
            cleanWs()
        }
    }
}
