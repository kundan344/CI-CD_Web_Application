FROM ubuntu:latest
MAINTAINER kundan.k845438@gmail.com
RUN apt-get update && apt-get install -y apache2 && apt-get install -y unzip
COPY . /var/www/html/
WORKDIR /var/www/html/
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]