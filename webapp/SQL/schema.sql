CREATE TABLE users (
    userType VARCHAR2(10),
    userAddress VARCHAR2(255) DEFAULT NULL,
    userId VARCHAR2(50) PRIMARY KEY,
    userPassword VARCHAR2(50) NOT NULL,
    userName VARCHAR2(50),
    userProfilePost INT DEFAULT NULL
);

CREATE TABLE posts (
    postName VARCHAR2(255),
    postTime DATE DEFAULT SYSDATE,
    postId INT PRIMARY KEY,
    postUser VARCHAR2(50) REFERENCES users(userId),
    postContent VARCHAR2(4000),
    postPhoto BLOB
);

CREATE SEQUENCE post_seq START WITH 1 INCREMENT BY 1 NOCACHE;
