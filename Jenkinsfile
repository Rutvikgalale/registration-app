pipeline{
    agent any
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
                cp "/var/lib/jenkins/workspace/registration app/webapp/target/webapp.war" /opt/apache-tomcat/webapps
                """
            }
        }
    }
}
