FROM tomcat:8.0-alpine

LABEL maintainer=”gajjarraj.se@gmail.com”

ADD SampleWebApp.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [“catalina.sh”, “run”]
