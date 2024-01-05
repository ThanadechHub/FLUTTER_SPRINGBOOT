CREATE TABLE users(
    id int auto_increment,
    name varchar(255) NOT NULL,
    username varchar(255) NOT NULL,
    password varchar(255) NOT NULL
);

CREATE TABLE Loan(
    id int auto_increment,
    name varchar(255) NOT NULL
);

-- insert into book(title,pages,author) values ('Spring Boot: Up and Running',328,'Mark Heckler');