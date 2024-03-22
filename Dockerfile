#FROM maven:3.9.6-eclipse-temurin-17 as build
#WORKDIR /app
#COPY . .
#RUN mvn clean install

FROM eclipse-temurin:17.0.6_10-jdk
EXPOSE 8080
ENV APP_HOME    /usr/src/app
#COPY --from=build /app/target/demoapp.jar /app/
COPY    target/demoapp-1.0.0.jar    $APP_HOME/app.jar
WORKDIR $APP_HOME
ENTRYPOINT  exec java -jar app.jar
#CMD ["java", "-jar","demoapp.jar"]
