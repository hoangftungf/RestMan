# Dockerfile for RestMan - Tomcat 10.1 + JDK 17

FROM tomcat:10.1-jdk17-temurin-jammy

# Maintainer
LABEL maintainer="RestMan Team"
LABEL description="RestMan Restaurant Management System"
LABEL version="1.0"

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file and deploy as ROOT application
# This makes the app accessible at http://localhost:8080/ instead of /restman
COPY target/restman.war /usr/local/tomcat/webapps/ROOT.war

# Environment variables for database connection (can be overridden)
ENV JDBC_URL="jdbc:mysql://mysql:3306/restman_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"
ENV JDBC_USER="restman"
ENV JDBC_PASS="restman123"

# Java options
ENV JAVA_OPTS="-Xms256m -Xmx512m -Djava.security.egd=file:/dev/./urandom"

# Expose Tomcat port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
