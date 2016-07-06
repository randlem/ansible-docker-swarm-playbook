FROM nginx:latest

RUN apt-get update -qq \
 && apt-get -y install curl zip \
 && apt-get -y clean \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -O https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip \
 && unzip consul-template_0.15.0_linux_amd64.zip consul-template -d /usr/local/bin \
 && rm consul-template_0.15.0_linux_amd64.zip

RUN mkdir /etc/consul-template
ADD nginx.conf /etc/consul-template

CMD /usr/sbin/nginx -c /etc/nginx/nginx.conf \
  & CONSUL_TEMPLATE_LOG=debug consul-template \
      -consul=$CONSUL \
      -template "/etc/consul-template/nginx.conf:/etc/nginx/conf.d/app.conf:/usr/sbin/nginx -s reload";