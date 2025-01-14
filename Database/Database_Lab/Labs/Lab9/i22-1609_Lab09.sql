Create DATABASE lab09
use lab09;

CREATE TABLE Users (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    DOB BIGINT -- UNIXTIME can be stored as a BIGINT or INT for date
);

CREATE TABLE Post (
    id INT NOT NULL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    date BIGINT, -- UNIXTIME format
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Comment (
    id INT NOT NULL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    date BIGINT, -- UNIXTIME format
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);
