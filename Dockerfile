FROM FROM bitnami/tomcat:latest

LABEL maintainer=”gajjarraj.se@gmail.com”

ADD SampleWebApp.war /opt/bitnami/tomcat/webapps

EXPOSE 8080

CMD [“catalina.sh”, “run”]
