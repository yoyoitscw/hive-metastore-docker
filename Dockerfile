FROM openjdk:8u242-jre

# Avoid CVEs
RUN apt update; apt --only-upgrade install dpkg liblz4-1 libgnutls30 libldap-2.4-2 libldap-common libssl1.1 openssl libexpat1

WORKDIR /opt

ENV HADOOP_VERSION=3.3.3
ENV METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

COPY hadoop-3.4.0-SNAPSHOT ./hadoop-${HADOOP_VERSION}

COPY apache-hive-metastore-3.0.0-bin ./apache-hive-metastore-${METASTORE_VERSION}-bin

RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf - && \
    cp mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar ${HIVE_HOME}/lib/ && \
    rm -rf  mysql-connector-java-8.0.19

COPY conf/metastore-site.xml ${HIVE_HOME}/conf
COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

USER hive
EXPOSE 9083
# ENTRYPOINT ["sleep","infinity"]
ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]