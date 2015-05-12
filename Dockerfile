FROM debian:jessie

#MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

#RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
#RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

#ENV NGINX_VERSION 1.7.9-1~wheezy

#RUN apt-get update && apt-get install -y nginx=${NGINX_VERSION} && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y nginx-extras

# patch the Debian version of NGINX
RUN rm /etc/nginx/sites-enabled/default
ADD default.conf /etc/nginx/conf.d/default.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
