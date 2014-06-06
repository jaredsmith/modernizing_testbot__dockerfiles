FROM centos

# Install Postgresql
RUN yum -y install postgresql-server postgresql

# Adjust PostgreSQL configuration so that remote connections to the database are possible.
RUN echo "host all all 0.0.0.0/0 md5" >> /var/lib/pgsql/data/pg_hba.conf
RUN echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf

ADD ./conf/startup.sh /opt/startup.sh

# Expose the PostgreSQL port
EXPOSE 5432

USER postgres
CMD ["bin/bash", "/opt/startup.sh"]
