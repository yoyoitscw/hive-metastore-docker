## Docker file for Hive Metastore 3 standalone

### About

Example of running standalone Hive Metastore. Minio is used as S3 storage for external
tables.  

It contains following containers:
- mariadb as dependency
- minio to test S3 access (make sure that you specify correct volume to be mounted)
- hive metastore  3.x

### How to run

use docker compose to build && start hive

```
$ docker-compose build
$ docker-compose up -d
```

You can now connect to it using hive or spark application.

### Hive

Download and untar hive first.  
Then copy conf/metastore-site.xml to hive $HIVE_HOME/conf/hive-site.xml

Before running hive make sure you export:
```
export JAVA_HOME=/java/home
export HADOOP_HOME=/your/local/hadoop/path
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
``` 

`HADOOP_CLASSPATH` is not mandatory if you do not want to use S3 


then run:

```
$ $HIVE_HOME/bin/hive
``` 

you shuld see some hive objects if connection works correctly

```
hive> show tables;
OK
example_table3
Time taken: 0.024 seconds, Fetched: 1 row(s)
```

### Spark

For spark use:

```
val spark = SparkSession
      .builder()
      .appName("SparkHiveTest")
      .config("hive.metastore.uris", "thrift://localhost:9083")
      .config("spark.sql.warehouse.dir", warehouseLocation)
      .enableHiveSupport()
      .getOrCreate()
```

# Build hive from source
```
mvn clean package -Pdist -DskipTests -Dmaven.javadoc.skip=true
export TRIVY_SEVERITY=CRITICAL
trivy i hpdevelop/hive-metastore:latest
```

# Start Metastore
```
./start-metastore # At metastore()

---commands /repo/hive-metastore-docker/hadoop-3.3.3/bin/hadoop jar /repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-*.jar org.apache.hadoop.hive.metastore.HiveMetaStore 
---In hadoopcmd_case jar /repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
---HADOOP_CLASSNAME is org.apache.hadoop.util.RunJar
---Run hadoop_add_client_opts
---Run hadoop_subcommand_opts hadoop and jar
---Run hadoop_generic_java_subcmd_handler
---guess we are here jar AND org.apache.hadoop.util.RunJar AND /repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
---CLASSPATH=/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/conf:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.8.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.8.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.8.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.8.2.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/repo/hive-metastore-docker/hadoop-3.3.3/etc/hadoop:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/common/lib/*:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/common/*:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/hdfs:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/hdfs/lib/*:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/hdfs/*:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/mapreduce/*:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/yarn:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/yarn/lib/*:/repo/hive-metastore-docker/hadoop-3.3.3/share/hadoop/yarn/*
---/usr/local/openjdk-8/bin/java -Dproc_jar -Dproc_metastore  -Dlog4j.configurationFile=metastore-log4j2.properties  -Dyarn.log.dir=/repo/hive-metastore-docker/hadoop-3.3.3/logs -Dyarn.log.file=hadoop.log -Dyarn.home.dir=/repo/hive-metastore-docker/hadoop-3.3.3 -Dyarn.root.logger=INFO,console -Djava.library.path=/repo/hive-metastore-docker/hadoop-3.3.3/lib/native -Xmx256m -Dhadoop.log.dir=/repo/hive-metastore-docker/hadoop-3.3.3/logs -Dhadoop.log.file=hadoop.log -Dhadoop.home.dir=/repo/hive-metastore-docker/hadoop-3.3.3 -Dhadoop.id.str=root -Dhadoop.root.logger=INFO,console -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.util.RunJar /repo/hive-metastore-docker/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
```

Here we try to run it in Docker container
```
---commands /opt/hadoop-3.3.3/bin/hadoop jar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-*.jar org.apache.hadoop.hive.metastore.HiveMetaStore 
---In hadoopcmd_case jar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
---HADOOP_CLASSNAME is org.apache.hadoop.util.RunJar
---Run hadoop_add_client_opts
---Run hadoop_subcommand_opts hadoop and jar
---Run hadoop_generic_java_subcmd_handler
---hadoop_java_exec jar org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
---CLASSPATH=/opt/apache-hive-metastore-3.0.0-bin/conf:/opt/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/mysql-connector-java-8.0.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.1026.jar:/opt/hadoop-3.3.3/share/hadoop/tools/lib/hadoop-aws-3.3.3.jar:/opt/hadoop-3.3.3/etc/hadoop:/opt/hadoop-3.3.3/share/hadoop/common/lib/*:/opt/hadoop-3.3.3/share/hadoop/common/*:/opt/hadoop-3.3.3/share/hadoop/hdfs:/opt/hadoop-3.3.3/share/hadoop/hdfs/lib/*:/opt/hadoop-3.3.3/share/hadoop/hdfs/*:/opt/hadoop-3.3.3/share/hadoop/mapreduce/*:/opt/hadoop-3.3.3/share/hadoop/yarn:/opt/hadoop-3.3.3/share/hadoop/yarn/lib/*:/opt/hadoop-3.3.3/share/hadoop/yarn/*

---hadoop_java_exec /usr/local/openjdk-8/bin/java -Dproc_jar -Dproc_metastore  -Dlog4j.configurationFile=metastore-log4j2.properties  -Dyarn.log.dir=/opt/hadoop-3.3.3/logs -Dyarn.log.file=hadoop.log -Dyarn.home.dir=/opt/hadoop-3.3.3 -Dyarn.root.logger=INFO,console -Djava.library.path=/opt/hadoop-3.3.3/lib/native -Xmx256m -Dhadoop.log.dir=/opt/hadoop-3.3.3/logs -Dhadoop.log.file=hadoop.log -Dhadoop.home.dir=/opt/hadoop-3.3.3 -Dhadoop.id.str=hive -Dhadoop.root.logger=INFO,console -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
```

export CLASSPATH=/opt/apache-hive-metastore-3.0.0-bin/conf:/opt/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/mysql-connector-java-8.0.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/aws-java-sdk-bundle-1.11.1026.jar:/opt/hadoop-3.3.3/share/hadoop/hadoop-aws-3.3.3.jar:/opt/hadoop-3.3.3/etc/hadoop:/opt/hadoop-3.3.3/share/hadoop/common/lib/*:/opt/hadoop-3.3.3/share/hadoop/common/*:/opt/hadoop-3.3.3/share/hadoop/hdfs:/opt/hadoop-3.3.3/share/hadoop/hdfs/lib/*:/opt/hadoop-3.3.3/share/hadoop/hdfs/*



# Hive schema init


```
--In hadoopcmd_case jar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.tools.MetastoreSchemaTool -initSchema -dbType mysql
---HADOOP_CLASSNAME is org.apache.hadoop.util.RunJar
---Run hadoop_add_client_opts
---Run hadoop_subcommand_opts hadoop and jar
---Run hadoop_generic_java_subcmd_handler
---hadoop_java_exec jar org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.tools.MetastoreSchemaTool -initSchema -dbType mysql


---CLASSPATH=/opt/apache-hive-metastore-3.0.0-bin/conf:/opt/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/mysql-connector-java-8.0.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/opt/hadoop-3.3.3/etc/hadoop:/opt/hadoop-3.3.3/share/hadoop/common/lib/*:/opt/hadoop-3.3.3/share/hadoop/common/*:/opt/hadoop-3.3.3/share/hadoop/hdfs:/opt/hadoop-3.3.3/share/hadoop/hdfs/lib/*:/opt/hadoop-3.3.3/share/hadoop/hdfs/*:/opt/hadoop-3.3.3/share/hadoop/mapreduce/*:/opt/hadoop-3.3.3/share/hadoop/yarn:/opt/hadoop-3.3.3/share/hadoop/yarn/lib/*:/opt/hadoop-3.3.3/share/hadoop/yarn/*


---hadoop_java_exec /usr/local/openjdk-8/bin/java -Dproc_jar -Djava.net.preferIPv4Stack=true  -Dlog4j.configurationFile=metastore-log4j2.properties -Dyarn.log.dir=/opt/hadoop-3.3.3/logs -Dyarn.log.file=hadoop.log -Dyarn.home.dir=/opt/hadoop-3.3.3 -Dyarn.root.logger=INFO,console -Djava.library.path=/opt/hadoop-3.3.3/lib/native -Xmx256m -Dhadoop.log.dir=/opt/hadoop-3.3.3/logs -Dhadoop.log.file=hadoop.log -Dhadoop.home.dir=/opt/hadoop-3.3.3 -Dhadoop.id.str=hive -Dhadoop.root.logger=INFO,console -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.tools.MetastoreSchemaTool -initSchema -dbType mysql



Metastore connection URL:        jdbc:mysql://mariadb:3306/metastore_db
Metastore Connection Driver :    com.mysql.cj.jdbc.Driver
Metastore connection User:       admin
Starting metastore schema initialization to 3.0.0
Initialization script hive-schema-3.0.0.mysql.sql
Initialization script completed
```


# Custom Build hive-metastore with newer jackson and hadoop-3.4.0

init DB
```
CLASSPATH=/opt/apache-hive-metastore-3.0.0-bin/conf:/opt/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.8.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/mysql-connector-java-8.0.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/tools/lib/aws-java-sdk-bundle-1.12.132.jar:/opt/hadoop-3.3.3/share/hadoop/tools/lib/hadoop-aws-3.4.0-SNAPSHOT.jar:/opt/hadoop-3.3.3/etc/hadoop:/opt/hadoop-3.3.3/share/hadoop/common/lib/*:/opt/hadoop-3.3.3/share/hadoop/common/*:/opt/hadoop-3.3.3/share/hadoop/hdfs:/opt/hadoop-3.3.3/share/hadoop/hdfs/lib/*:/opt/hadoop-3.3.3/share/hadoop/hdfs/*:/opt/hadoop-3.3.3/share/hadoop/mapreduce/*:/opt/hadoop-3.3.3/share/hadoop/yarn/lib/*:/opt/hadoop-3.3.3/share/hadoop/yarn/*

/usr/local/openjdk-8/bin/java -Dproc_jar -Djava.net.preferIPv4Stack=true  -Dlog4j.configurationFile=metastore-log4j2.properties -Dyarn.log.dir=/opt/hadoop-3.3.3/logs -Dyarn.log.file=hadoop.log -Dyarn.home.dir=/opt/hadoop-3.3.3 -Dyarn.root.logger=INFO,console -Xmx256m -Dhadoop.log.dir=/opt/hadoop-3.3.3/logs -Dhadoop.log.file=hadoop.log -Dhadoop.home.dir=/opt/hadoop-3.3.3 -Dhadoop.id.str=hive -Dhadoop.root.logger=INFO,console -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.tools.MetastoreSchemaTool -initSchema -dbType mysql
```

Run hive-metastore
```
export CLASSPATH=/opt/apache-hive-metastore-3.0.0-bin/conf:/opt/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/mysql-connector-java-8.0.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/aws-java-sdk-bundle-1.12.132.jar:/opt/hadoop-3.3.3/share/hadoop/hadoop-aws-3.4.0-SNAPSHOT.jar:/opt/hadoop-3.3.3/etc/hadoop:/opt/hadoop-3.3.3/share/hadoop/common/*:/opt/hadoop-3.3.3/share/hadoop/common/lib/*

--- reducing jars
export CLASSPATH=/opt/apache-hive-metastore-3.0.0-bin/conf:/opt/apache-hive-metastore-3.0.0-bin/lib/HikariCP-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/aircompressor-0.8.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/antlr-runtime-3.5.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/bonecp-0.8.0.RELEASE.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-dbcp-1.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang-2.6.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-lang3-3.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/commons-pool-1.5.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-api-jdo-4.2.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-core-4.1.17.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/datanucleus-rdbms-4.1.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/dropwizard-metrics-hadoop-metrics2-reporter-0.1.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/guava-19.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/hive-storage-api-2.6.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/httpcore-4.4.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-annotations-2.9.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-core-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.13.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jackson-databind-2.9.4.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javax.jdo-3.2.0-m3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/javolution-5.5.1.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/jline-2.14.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libfb303-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/libthrift-0.9.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-1.2-api-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-api-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-core-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/log4j-slf4j-impl-2.12.2.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-core-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-json-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/metrics-jvm-3.1.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/mysql-connector-java-8.0.19.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/orc-core-1.4.3.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/protobuf-java-2.5.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/sqlline-1.3.0.jar:/opt/apache-hive-metastore-3.0.0-bin/lib/transaction-api-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/aws-java-sdk-bundle-1.12.132.jar:/opt/hadoop-3.3.3/share/hadoop/hadoop-aws-3.4.0-SNAPSHOT.jar:/opt/hadoop-3.3.3/etc/hadoop:/opt/hadoop-3.3.3/share/hadoop/common/hadoop-common-3.4.0-SNAPSHOT.jar

:/opt/hadoop-3.3.3/share/hadoop/common/lib/slf4j-api-1.7.30.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/slf4j-log4j12-1.7.30.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/

:/opt/hadoop-3.3.3/share/hadoop/common/lib/guava-27.0-jre.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-beanutils-1.9.4.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-cli-1.2.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-codec-1.15.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-collections-3.2.2.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-compress-1.21.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-configuration2-2.1.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-daemon-1.0.13.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-lang3-3.12.0.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-io-2.8.0.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-lang3-3.12.0.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-logging-1.1.3.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-math3-3.1.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-net-3.6.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-text-1.4.jar

:/opt/hadoop-3.3.3/share/hadoop/common/lib/j2objc-annotations-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jackson-annotations-2.12.7.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jackson-core-2.12.7.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jackson-databind-2.12.7.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jakarta.activation-api-1.2.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/javax.servlet-api-3.1.0.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jaxb-api-2.2.11.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jcip-annotations-1.0-1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jersey-core-1.19.4.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jersey-json-1.20.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jersey-server-1.19.4.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jersey-servlet-1.19.4.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jettison-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jsch-0.1.55.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/json-smart-2.4.7.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jsp-api-2.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jsr305-3.0.2.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jsr311-api-1.1.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/jul-to-slf4j-1.7.30.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/metrics-core-3.2.4.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/nimbus-jose-jwt-9.8.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/protobuf-java-2.5.0.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/re2j-1.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/snappy-java-1.1.8.2.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/stax2-api-4.2.1.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/token-provider-1.0.1.jar

:/opt/hadoop-3.3.3/share/hadoop/common/lib/commons-io-2.8.0.jar:/opt/hadoop-3.3.3/share/hadoop/common/lib/guava-27.0-jre.jar

:/opt/hadoop-3.3.3/share/hadoop/common/lib/*



---hadoop_java_exec /usr/local/openjdk-8/bin/java -Dproc_jar -Dproc_metastore  -Dlog4j.configurationFile=metastore-log4j2.properties  -Dyarn.log.dir=/opt/hadoop-3.3.3/logs -Dyarn.log.file=hadoop.log -Dyarn.home.dir=/opt/hadoop-3.3.3 -Dyarn.root.logger=INFO,console -Xmx256m -Dhadoop.log.dir=/opt/hadoop-3.3.3/logs -Dhadoop.log.file=hadoop.log -Dhadoop.home.dir=/opt/hadoop-3.3.3 -Dhadoop.id.str=hive -Dhadoop.root.logger=INFO,console -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore

/usr/local/openjdk-8/bin/java -Dproc_jar -Dproc_metastore  -Dlog4j.configurationFile=metastore-log4j2.properties  -Dyarn.log.dir=/opt/hadoop-3.3.3/logs -Dyarn.log.file=hadoop.log -Dyarn.home.dir=/opt/hadoop-3.3.3 -Dyarn.root.logger=INFO,console -Xmx256m -Dhadoop.log.dir=/opt/hadoop-3.3.3/logs -Dhadoop.log.file=hadoop.log -Dhadoop.home.dir=/opt/hadoop-3.3.3 -Dhadoop.id.str=hive -Dhadoop.root.logger=INFO,console -Dhadoop.policy.file=hadoop-policy.xml -Dhadoop.security.logger=INFO,NullAppender org.apache.hadoop.util.RunJar /opt/apache-hive-metastore-3.0.0-bin/lib/hive-standalone-metastore-3.0.0.jar org.apache.hadoop.hive.metastore.HiveMetaStore
```



# CVEs

```

./hadoop-3.4.0-SNAPSHOT/share/hadoop/yarn/hadoop-yarn-applications-catalog-webapp-3.4.0-SNAPSHOT.war

./hadoop-3.4.0-SNAPSHOT/share/hadoop/yarn/timelineservice/lib/htrace-core-3.1.0-incubating.jar

./apache-hive-metastore-3.0.0-bin/lib/derby-10.10.2.0.jar


./hadoop-3.4.0-SNAPSHOT/share/hadoop/hdfs/lib/log4j-1.2.17.jar
./hadoop-3.4.0-SNAPSHOT/share/hadoop/common/lib/log4j-1.2.17.jar

./hadoop-3.3.3/share/hadoop/hdfs/lib/netty-3.10.6.Final.jar
./hadoop-3.3.3/share/hadoop/common/lib/netty-3.10.6.Final.jar

./hadoop-3.4.0-SNAPSHOT/share/hadoop/hdfs/lib/netty-3.10.6.Final.jar

```