FROM openjdk:14-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} service-discovery.jar
ENTRYPOINT ["java","-jar","/service-discovery.jar"]