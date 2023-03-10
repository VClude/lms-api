FROM maven:3.9.0-eclipse-temurin-17-alpine AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package


FROM openjdk:17-jdk-slim
COPY --from=build /home/app/target/api-1.0-SNAPSHOT.jar /usr/local/lib/api.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","/usr/local/lib/api.jar"]