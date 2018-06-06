FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/LuisIntellectEU/CatalystTest.git

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/CatalystTest /app
RUN mvn install

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=1 /app/target/*.jar /app
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","*.jar"]
