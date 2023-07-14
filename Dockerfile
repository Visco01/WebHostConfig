# Utilizza l'immagine base di Apache con supporto PHP
FROM php:7.4-apache

# Imposta la direttiva ServerName
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Abilita i moduli SSL e headers
RUN a2enmod ssl headers

# Copia i file di configurazione dei virtual host di Apache nel container
COPY ./site1/site1.conf /etc/apache2/sites-available/
COPY ./site2/site2.conf /etc/apache2/sites-available/

# Abilita i virtual host
RUN a2ensite site1.conf && a2ensite site2.conf

# Disabilita il virtual host predefinito
RUN a2dissite 000-default.conf

# Rimuovi la document root predefinita
RUN rm -rf /var/www/html

# Crea le directory per i virtual host
RUN mkdir -p /var/www/site1 /var/www/site2

# Copia i file del sito nelle rispettive directory
COPY site1 /var/www/site1
COPY site2 /var/www/site2

# Imposta i permessi appropriati per i file del sito
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www

# Genera un certificato SSL autofirmato
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=site1.local" \
    -keyout /etc/ssl/private/apache-selfsigned.key \
    -out /etc/ssl/certs/apache-selfsigned.crt

# Abilita la configurazione SSL
COPY ssl-params.conf /etc/apache2/conf-available/
RUN a2enconf ssl-params

# Espone le porte 80 (HTTP) e 443 (HTTPS)
EXPOSE 80
EXPOSE 443

# Esegue il comando per avviare Apache
CMD ["apache2-foreground"]
