# Gunakan image PHP FPM
FROM php:8.2-fpm-alpine

# Set working directory
WORKDIR /var/www/html

# Install dependensi sistem jika diperlukan (misalnya, git, unzip untuk composer)
# RUN apk add --no-cache git unzip

# Install Composer (opsional, jika Anda punya composer.json)
# COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Copy aplikasi
COPY . .

# Install dependensi PHP (opsional, jika ada composer.json)
# RUN composer install --no-dev --optimize-autoloader

# Ekspos port yang digunakan aplikasi Anda (biasanya 9000 untuk FPM, atau 80 untuk server web seperti Nginx/Apache)
EXPOSE 80 # Mengasumsikan Anda akan menjalankannya langsung atau dengan web server lain yang memproses PHP

# Command untuk menjalankan server web internal PHP (hanya untuk demo sederhana)
CMD ["php", "-S", "0.0.0.0:80", "-t", "."]