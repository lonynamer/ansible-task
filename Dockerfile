FROM tomcat:8.0.20-jre8
ADD web/target/*.war /usr/local/tomcat/webapps/
