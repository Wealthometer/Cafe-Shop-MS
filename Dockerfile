FROM openjdk:22-jdk-slim AS builder

RUN apt-get update && apt-get install -y openjfx

ENV JAVAFX_LIB=/usr/share/openjfx/lib

WORKDIR /app
COPY cafeShopManagementSystem /app

# Compile manually
RUN mkdir -p build/classes && \
    javac --module-path $JAVAFX_LIB --add-modules javafx.controls,javafx.fxml \
    -d build/classes $(find src -name "*.java")

# Create runnable JAR
RUN jar cfe app.jar cafeshopmanagementsystem.CafeShopManagementSystem -C build/classes .
