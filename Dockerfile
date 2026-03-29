# Build stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Runtime stage with Tomcat
FROM tomcat:9-jdk11
WORKDIR /usr/local/tomcat/webapps/
COPY --from=build /app/webapp/target/webapp.war webapp.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
