FROM php:7.3.6-fpm-alpine3.9

#Adicionar o bash e o mysql-client
RUN apk add --no-cache shadow openssl bash mysql-client nodejs npm

#Instala as extensões pdo e pdo_mysql do PHP
RUN docker-php-ext-install pdo pdo_mysql

#Instalando o dockerize para ele trabalhar com o processo de esperar um serviço subir

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# seta a pasta de trabalho
WORKDIR /var/www

# apaga o conteudo da pasta original /var/www/html do container
RUN rm -rf /var/www/html 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# cria um link simbolico para a pasta public do laravel para a pasta html 
RUN ln -s public html

#comentando essa parte para ver se resolve o problema de permissão no GCP
# Muda o dono do arquivo (A instalação do pacote shadow para habilitar o comando usermod)
#RUN usermod -u 1000 www-data
#USER www-data


# RUN composer install && \
#     cp .env.example .env && \
#     php artisan key:generate && \
#     php artisan config:cache

# copia a pasta do laravel para /var/www
#COPY . /var/www


# expor a porta do PHP FPM
EXPOSE 9000

# entrypoint para deixar o php-fpm rodando
ENTRYPOINT ["php-fpm"]
