    pipeline{
        agent any
        environment{
            DOCKER_USER="rutvikg"
        }
        stages{
            stage("cleaning workspace"){
                steps{
                    cleanWs();
                }
            }
            stage("code checkout"){
                steps{
                    git branch: "main", url: "https://github.com/Rutvikgalale/registration-app.git"
                }
            }
            stage("build code using maven"){
                steps{
                    sh "mvn clean package"
                }
            }
            stage("deploy application on tomcat"){
                steps{
                    sh """
                    id
                    cp "/var/lib/jenkins/workspace/registration app@2/webapp/target/webapp.war" /opt/apache-tomcat/webapps
                    """
                }
            }
            stage("build image using docker"){
                steps{
                    sh "docker build -t registration-app ."
                }
            }
            stage("push image to dockurhub"){
                steps{
                    withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker tag registration-app ${DOCKER_USER}/registration-app:latest
                    docker push ${DOCKER_USER}/registration-app:latest
                    docker run -dit -p 8082:8082 --name registration-app rutvikg/registration-app:latest
                    """
                    }
                }
            }
        }
    }
