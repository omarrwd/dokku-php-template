# Use the E2B base image
FROM e2bdev/code-interpreter:latest

# Install PHP and Apache
RUN apt-get update && \
    apt-get install -y php libapache2-mod-php && \
    apt-get clean

# Enable Apache rewrite module
RUN a2enmod rewrite

# Configure Apache for the project directory
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /home/user/project\n\
    <Directory /home/user/project>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Set proper permissions for the project directory
RUN mkdir -p /home/user/project && \
    chown -R www-data:www-data /home/user/project && \
    chmod -R 755 /home/user/project

WORKDIR /home/user/project
# Copy everything from the current directory into /home/user/project
COPY . /home/user/project
EXPOSE 80

CMD ["apache2-foreground"]

