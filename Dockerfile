FROM openjdk:17-jdk
ADD target/spring-project.jar  spring-project.jar
EXPOSE 8080
ENTRYPPOINT ["java","-jar","spring-project.jar"]
