# Use the official Drupal image as the base image
FROM drupal:10

# Install necessary packages
RUN apt-get update && \
    apt-get install -y git unzip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www/html

# Clone the custom Drupal files into the container
RUN git clone https://github.com/mesfint/drupal-docker.git drupal

# Move the cloned files to the appropriate directory
RUN mv drupal/* . && rm -rf drupal

# Install Composer dependencies
RUN composer install

# Set the appropriate permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]
