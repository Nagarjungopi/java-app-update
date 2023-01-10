FROM tomcat:9

LABEL maintainer="nagarjun@optisolbusiness.com"

WORKDIR /usr/local/tomcat/webapps

COPY . . 

CMD ["catalina.sh", "run"]
