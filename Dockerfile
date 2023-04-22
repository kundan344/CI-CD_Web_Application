FROM centos:latest
MAINTAINER kundan.k845438@gmail.com
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y httpd \
 zip\
 unzip
WORKDIR /var/www/html/
COPY . .
CMD ["/usr/sbin/httpd", "D", "FOREGROUND"]
EXPOSE 80