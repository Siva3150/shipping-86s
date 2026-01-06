FROM maven:3.9.11 AS build
WORKDIR /opt/server 
COPY pom.xml .
COPY src ./src
RUN mvn clean package && \
    mv target/shipping-*.jar shipping.jar  

FROM eclipse-temurin:17-jre-alpine 
EXPOSE 8080
WORKDIR /opt/server 
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
    chown -R roboshop:roboshop /opt/server  
ENV CART_ENDPOINT="cart:8080" \
    DB_HOST="mysql"
COPY --from=build --chown=roboshop:roboshop  /opt/server/shipping.jar .
USER roboshop 
ENTRYPOINT ["sh", "-c", "sleep 30 && java -jar shipping.jar"]
#CMD ["java", "-jar", "shipping.jar"]
# CMD ["sleep","1000"]
 
# FROM maven:3.9.11
# WORKDIR /opt/server 
# EXPOSE 8080 
# COPY pom.xml .
# COPY src ./src
# RUN mvn clean package
# RUN mv target/shipping-1.0.jar shipping.jar  
# ENV CART_ENDPOINT="cart:8080" \
#     DB_HOST="mysql"
# CMD ["java", "-jar", "shipping.jar"]
# # CMD ["sleep","1000"]
 