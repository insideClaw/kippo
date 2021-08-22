FROM debian:buster
COPY . /app
RUN chmod 777 -R /app
