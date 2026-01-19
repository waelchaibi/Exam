From debian:buster
RUN apt-get update && apt-get install -y php php-mysql
EXPOSE 80


