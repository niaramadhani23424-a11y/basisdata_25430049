CREATE DATABASE kopma_49
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE USER 'mhs_49'@'localhost'
    IDENTIFIED BY '<nama_samarannya_ini_birudongker>';

GRANT ALL PRIVILEGES ON kopma_49.* TO 'mhs_49'@'localhost';