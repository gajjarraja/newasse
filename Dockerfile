FROM tomcat
COPY /var/lib/jenkins/workspace/assesment2/*.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
