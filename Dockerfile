FROM gradle:5.4-jdk8-alpine as app-builder
USER root
RUN mkdir -p /usr/service-discovery
WORKDIR /usr/service-discovery

COPY src ./src
COPY build.gradle .
RUN gradle clean build bootJar
RUN ls -ltr
RUN ls -ltr build
ARG JAR_FILE=build/libs/*.jar
FROM openjdk:14-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

COPY --from=app-builder /usr/service-discovery/build/libs/service-discovery-1.jar .

ENV JAVA_OPTS=""
EXPOSE 8083

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar ./service-discovery-1.jar"]