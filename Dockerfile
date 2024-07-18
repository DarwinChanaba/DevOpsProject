FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app  
COPY pom.xml /app/
COPY . /app/
RUN mvn clean package
FROM tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/xyz.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
