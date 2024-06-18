CREATE TABLE users (
    userType VARCHAR2(10),
    userAddress VARCHAR2(255) DEFAULT NULL,
    userId VARCHAR2(50) PRIMARY KEY,
    userPassword VARCHAR2(50) NOT NULL,
    userName VARCHAR2(50),
    userLocation VARCHAR2(50) DEFAULT NULL
);


CREATE TABLE posts (
    postName VARCHAR2(255),
    postTime DATE DEFAULT SYSDATE,
    postId INT PRIMARY KEY,
    postUser VARCHAR2(50),
    postContent VARCHAR2(4000),
    postPhoto BLOB,
    postPhotoExtension VARCHAR2(5),
    CONSTRAINT posts_postuser_fk FOREIGN KEY (postUser) REFERENCES users(userId) ON DELETE CASCADE
);

CREATE TABLE comments (
    commentid INT PRIMARY KEY,
    postId INT,
    author VARCHAR2(50),
    content VARCHAR2(4000),
    createdAt DATE DEFAULT SYSDATE,
    CONSTRAINT comments_postid_fk FOREIGN KEY (postId) REFERENCES posts(postId) ON DELETE CASCADE,
    CONSTRAINT comments_author_fk FOREIGN KEY (author) REFERENCES users(userId) ON DELETE CASCADE
);

CREATE SEQUENCE posts_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE comments_seq START WITH 1 INCREMENT BY 1 NOCACHE;