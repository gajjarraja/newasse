FROM tomcat
COPY /home/ubuntu/newasse/SampleWebApp.war  /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
