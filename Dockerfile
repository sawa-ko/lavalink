# CONFIGURE ARGS
###########################
#ARG PORT=1234
#ARG PASSWORD=youshallnotpass
###########################

FROM eclipse-temurin:latest

# Install necessary tools
RUN apt update -y
RUN apt upgrade -y
RUN apt install wget
RUN apt install openjdk-17-jre openjdk-17-jdk -y

WORKDIR /app

# Download latest official version of Lavalink
RUN wget https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar

# Download default config
RUN wget -O application.yml https://raw.githubusercontent.com/freyacodes/Lavalink/master/LavalinkServer/application.yml.example

# Set custom port and password
RUN sed -i "2s/.*/  port: $PORT/" application.yml
RUN sed -i "6s/.*/    password: $PASSWORD/" application.yml

# RUN Lavalink
ENTRYPOINT ["java", "-Djdk.tls.client.protocols=TLSv1.1,TLSv1.2", "-Xmx4G", "-jar", "Lavalink.jar"]