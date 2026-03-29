# Stage 1: Build WAR using Maven + JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Tomcat runtime with JDK 21
FROM tomcat:10.1-jdk21-openjdk-slim

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR from build stage into Tomcat
COPY --from=build /app/target/webapp.war /usr/local/tomcat/webapps/webapp.war

# Expose Tomcat port (default 8080)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
