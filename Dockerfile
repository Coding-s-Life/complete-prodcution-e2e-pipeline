CMD["dir"]
FROM maven:3.9.6-eclipse-temurin-17 as build
COPY --from=build target/petclinic.war   petclinic.war
EXPOSE  8080
CMD["java", "-jar", "petclinic.war"]


#FROM maven:3.9.6-eclipse-temurin-17 as build
#WORKDIR /app
#COPY . .
#RUN mvn clean install
#
#FROM eclipse-temurin:17.0.6_10-jdk
#WORKDIR /app
#COPY --from=build /app/target/demoapp.jar /app/
#EXPOSE 8080
#CMD ["java", "-jar","demoapp.jar"]
