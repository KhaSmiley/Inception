FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y mariadb-server && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    mkdir -p /home/inception/data/mariadb && \
    mkdir -p /home/inception/data/wordpress

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306

CMD ["mysqld"]