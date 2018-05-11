#FROM docker-registry-default.rocp.vs.csint.cz/rhscl/centos
FROM centos

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
    && chmod -R 0777 /var/lib/mysql \
    && touch /var/log/mariadb/error.log \
    && touch /var/log/mariadb/general.log \
    && chown -R mysql: /var/log/mariadb /opt /etc/my.cnf \
    && chmod -R 0777 /var/log/mariadb \
    && chmod -R 0644 /etc/my.cnf \
    && ln -sf /dev/stdout /var/log/mariadb/general.log \
    && ln -sf /dev/stderr /var/log/mariadb/error.log 

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql", "--user=mysql"]
