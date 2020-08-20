FROM nginx:1.15.0-alpine

# Remove o arquivo padrão de configuração do nginx
RUN rm /etc/nginx/conf.d/default.conf
# Copia o arquivo de configuração do nginx que configura o PHP FPM
COPY ./nginx.conf /etc/nginx/conf.d
