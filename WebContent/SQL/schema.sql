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
    postPhoto BLOB,
    postPhotoExtension VARCHAR2(5)
);

CREATE TABLE comments (
    commentid INT PRIMARY KEY,
    postId INT REFERENCES posts(postId) ON DELETE CASCADE,
    author VARCHAR2(50) REFERENCES users(userId),
    content VARCHAR2(4000),
    createdAt DATE DEFAULT SYSDATE
);

CREATE SEQUENCE posts_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE comments_seq START WITH 1 INCREMENT BY 1 NOCACHE;