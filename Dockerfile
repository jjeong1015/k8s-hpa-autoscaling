# 1. Java 17 JDK 이미지를 기반으로 사용
FROM openjdk:17-jdk-alpine

# 2. 애플리케이션 JAR 파일을 /app 경로에 복사
COPY demo-0.0.1-SNAPSHOT.jar app.jar

# 3. 컨테이너가 시작될 때 JAR 파일 실행
ENTRYPOINT ["java", "-jar", "/app.jar"]
