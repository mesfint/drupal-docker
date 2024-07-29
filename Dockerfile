# Use the official Drupal image as the base image
FROM drupal:10

# Set the working directory
WORKDIR /var/www/html

# Copy the custom Drupal files into the container
COPY drupal/ .

# Install Composer dependencies
RUN apt-get update && \
    apt-get install -y git unzip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer install

# Set the appropriate permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]
