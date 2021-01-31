FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_admin'@'%' IDENTIFIED BY 'admin';
FLUSH PRIVILEGES;