FROM rhscl/centos:latest

MAINTAINER Jindřich Káňa <jindrich.kana@gmail.com>
LABEL Vendor="ELOS Technologies s.r.o."

RUN yum install -y --setopt=tsflags=nodocs mariadb-server \
    && yum clean all

ADD https://raw.githubusercontent.com/tmobil-demo/dotaznik-db/master/setupdb.sh /opt
ADD https://raw.githubusercontent.com/tmobil-demo/dotaznik-db/master/my.cnf /etc
ADD https://raw.githubusercontent.com/tmobil-demo/dotaznik-db/master/setupdb.sql /opt

RUN mysql_install_db --user=mysql

RUN bash /opt/setupdb.sh

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]
