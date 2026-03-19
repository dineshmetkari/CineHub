# FROM eclipse-temurin:17-jdk-jammy
# FROM maven:3.9.9-eclipse-temurin-17 AS builder
# WORKDIR /app
# COPY pom.xml .
# COPY src ./src
# RUN mvn clean package -DskipTests
# COPY target/cinehub-*.jar app.jar
# ENTRYPOINT ["java","-jar","/app/app.jar"]

# Stage 1: Build
FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app
COPY --from=builder /app/target/cinehub-*.jar app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]