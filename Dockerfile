FROM php:4-apache
ADD index.php /var/www/html/index.php
RUN chmod a+x index.php
