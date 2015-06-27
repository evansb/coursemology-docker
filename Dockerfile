
# This is a Dockerfile for setting up Coursemology
FROM ubuntu:15.04
MAINTAINER Evan Sebastian

# Expose Port 3000
EXPOSE 3000

# Setup correct locale for Postgres database template later
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Replace with NUS Mirror for faster downloading
RUN sed -i 's/archive.ubuntu.com/mirror.nus.edu.sg/g' /etc/apt/sources.list

# Install required dependencies
RUN apt-get update
RUN apt-get install -y git npm rubygems ruby-dev postgresql \
                       postgresql-contrib libpq-dev
RUN gem install bundler -v1.10.3

# Grant access to root in Postgresql, and fix the annoying locale difference
RUN /etc/init.d/postgresql start \
    && su -c "createuser -s root" postgres \
    && psql -c "UPDATE pg_database SET datistemplate = FALSE WHERE \
         datname = 'template1';" postgres \
    && psql -c "DROP DATABASE template1;" postgres \
    && psql -c "CREATE DATABASE template1 WITH TEMPLATE = template0 \
         ENCODING = 'UNICODE';" postgres \
    && psql -c "UPDATE pg_database SET datistemplate = TRUE WHERE \
       datname = 'template1';" postgres \
    && psql -c "VACUUM FREEZE" template1

ADD start.sh /start.sh

# Start server by default
CMD sh /start.sh
ENTRYPOINT /etc/init.d/postgresql start && /bin/sh -c "$0"