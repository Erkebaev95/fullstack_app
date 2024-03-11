CREATE SCHEMA IF NOT EXISTS fullstack;

SET NAMES 'UTF8MB4';

USE fullstack;

DROP TABLE IF EXISTS Users;

CREATE TABLE Users
(
    id         bigint unsigned not null auto_increment primary key,
    first_name varchar(50)  not null,
    last_name  varchar(50)  not null,
    email      varchar(100) not null,
    password   varchar(255) DEFAULT null,
    address    varchar(255) DEFAULT null,
    phone      varchar(30)  DEFAULT null,
    title      varchar(50)  DEFAULT null,
    bio        varchar(255) DEFAULT null,
    enabled    boolean      DEFAULT false,
    non_locked boolean      DEFAULT false,
    using_nfa  boolean      DEFAULT false,
    created_at datetime     DEFAULT CURRENT_TIMESTAMP,
    image_url  varchar(255) DEFAULT null,
    constraint UQ_Users_Email unique (email)
);

DROP TABLE IF EXISTS Roles;

CREATE TABLE Roles
(
    id         bigint unsigned not null auto_increment primary key,
    name       varchar(50)  not null,
    permission varchar(255) not null,
    constraint UQ_Roles_Name unique (name)
);

DROP TABLE IF EXISTS UserRoles;

CREATE TABLE UserRoles
(
    id      bigint unsigned not null auto_increment primary key,
    user_id bigint unsigned not null,
    role_id bigint unsigned not null,
    foreign key (user_id) references Users (id) on delete cascade on update cascade,
    foreign key (role_id) references Roles (id) on delete restrict on update cascade,
    constraint UQ_UserRoles_User_Id unique (user_id)
);

DROP TABLE IF EXISTS Events;

CREATE TABLE Events
(
    id          bigint unsigned not null auto_increment primary key,
    type        varchar(50)  not null check (type in ('LOGIN_ATTEMPT', 'LOGIN_ATTEMPT_FAILURE', 'LOGIN_ATTEMPT_SUCCESS',
                                                      'PROFILE_UPDATE', 'PROFILE_PICTURE_UPDATE', 'ROLE_UPDATE',
                                                      'ACCOUNT_SETTINGS_UPDATE', 'PASSWORD_UPDATE', 'MFA_UPDATE')),
    description varchar(255) not null,
    constraint UQ_Events_Type unique (type)
);

DROP TABLE IF EXISTS UserEvents;

CREATE TABLE UserEvents
(
    id         bigint unsigned not null auto_increment primary key,
    user_id    bigint unsigned not null,
    event_id   bigint unsigned not null,
    device     varchar(100) not null,
    ip_address varchar(100) not null,
    created_at datetime default CURRENT_TIMESTAMP,
    foreign key (user_id) references Users (id) on delete cascade on update cascade,
    foreign key (event_id) references Events (id) on delete restrict on update cascade,
    constraint UQ_UserEvents_User_Id unique (user_id)
);

DROP TABLE IF EXISTS AccountVerifications;

CREATE TABLE AccountVerifications
(
    id      bigint unsigned not null auto_increment primary key,
    user_id bigint unsigned not null,
    url     varchar(255) not null,
--     date    datetime     not null,
    foreign key (user_id) references Users (id) on delete cascade on update cascade,
    constraint UQ_AccountVerifications_User_Id unique (user_id),
    constraint UQ_AccountVerifications_Url unique (url)
);

DROP TABLE IF EXISTS ResetPasswordVerifications;

CREATE TABLE ResetPasswordVerifications
(
    id              bigint unsigned not null auto_increment primary key,
    user_id         bigint unsigned not null,
    url             varchar(255) not null,
    expiration_date datetime     not null,
    foreign key (user_id) references Users (id) on delete cascade on update cascade,
    constraint UQ_ResetPasswordVerifications_User_Id unique (user_id),
    constraint UQ_ResetPasswordVerifications_Url unique (url)
);

DROP TABLE IF EXISTS TwoFactoryVerifications;

CREATE TABLE TwoFactoryVerifications
(
    id              bigint unsigned not null auto_increment primary key,
    user_id         bigint unsigned not null,
    code            varchar(10) not null,
    expiration_date datetime    not null,
    foreign key (user_id) references Users (id) on delete cascade on update cascade,
    constraint UQ_TwoFactoryVerifications_User_Id unique (user_id),
    constraint UQ_TwoFactoryVerifications_Code unique (code)
);