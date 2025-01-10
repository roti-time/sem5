create database lab09

use lab09

-- # 1: Create the Users Table with ID (no width specification for INT)
CREATE TABLE Users (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    DOB INT NULL
);

-- # 2: Create the Post Table with Foreign Key to Users Table (no width specification for INT)
CREATE TABLE Post (
    id INT NOT NULL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    date INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- # 3: Create the Comment Table with Foreign Keys to Post and Users Tables (no width specification for INT)
CREATE TABLE Comment (
    id INT NOT NULL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    date INT NOT NULL,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);