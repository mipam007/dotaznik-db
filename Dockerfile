FROM docker-registry-default.rocp.vs.csint.cz/rhscl/centos
#FROM centos:7

MAINTAINER Jindřich Káňa <jindrich.kana@gmail.com>
LABEL Vendor="ELOS Technologies s.r.o."

RUN yum install -y --setopt=tsflags=nodocs mariadb-server \
    && yum clean all

ADD https://raw.githubusercontent.com/mipam007/dotaznik-db/master/setupdb.sh /opt
ADD https://raw.githubusercontent.com/mipam007/dotaznik-db/master/my.cnf /etc
ADD https://raw.githubusercontent.com/mipam007/dotaznik-db/master/setupdb.sql /opt

RUN mysql_install_db --user=mysql

RUN bash /opt/setupdb.sh
RUN chown -R mysql: /var/lib/mysql \
    && chmod -R 0777 /var/lib/mysql

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql", "--user=mysql"]
