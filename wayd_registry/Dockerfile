FROM adoptopenjdk/openjdk11:alpine-jre
ARG JAR_FILE=target/wayd_registry-0.0.1-SNAPSHOT.jar
WORKDIR /opt/app
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","app.jar"]
EXPOSE 9999