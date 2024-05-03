-- MariaDB script

-- Drop the database if it exists
DROP DATABASE IF EXISTS ums_db;

-- Create the database
CREATE DATABASE ums_db;

-- Use the database
USE ums_db;

-- Table 'UserData'
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    INDEX users_username_index (username),
    INDEX users_email_index (email)
);

-- Create root user with admin privileges
INSERT INTO users (username, password, email, is_admin) VALUES ('root', 'root', 'admin@example.local', TRUE);