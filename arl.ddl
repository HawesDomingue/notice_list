-- Generated by Oracle SQL Developer Data Modeler 4.0.3.853
--   at:        2015-04-27 16:59:02 CDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g




DROP TABLE ACTIVE_EMPLOYEES CASCADE CONSTRAINTS ;

DROP TABLE DOCUMENT CASCADE CONSTRAINTS ;

DROP TABLE NL_MEMBERS CASCADE CONSTRAINTS ;

DROP TABLE NOTICE_LISTS CASCADE CONSTRAINTS ;

DROP TABLE "User" CASCADE CONSTRAINTS ;

CREATE TABLE ACTIVE_EMPLOYEES
  (
    EMPLOYEE_ID       INTEGER NOT NULL ,
    EMPLOYEE_NAME     VARCHAR2 (512) ,
    EMPLOYEE_STATUS   VARCHAR2 (1) ,
    STATUS_EFF_DATE   DATE ,
    EMPLOYEE_LAB      VARCHAR2 (4) ,
    EMPLOYEE_DIVISION VARCHAR2 (4) ,
    User_USER_ID      INTEGER
  ) ;
CREATE UNIQUE INDEX ACTIVE_EMPLOYEES__IDX ON ACTIVE_EMPLOYEES
  (
    User_USER_ID ASC
  )
  ;
  ALTER TABLE ACTIVE_EMPLOYEES ADD CONSTRAINT ACTIVE_EMPLOYEES_PK PRIMARY KEY ( EMPLOYEE_ID ) ;

CREATE TABLE DOCUMENT
  (
    DOCUMENT_ID   INTEGER NOT NULL ,
    FILENAME      VARCHAR2 (4000) ,
    FILE_MIMETYPE VARCHAR2 (512) ,
    FILE_CHARSET  VARCHAR2 (512) ,
    FILE_DATA BLOB ,
    FILE_COMMENTS VARCHAR2 (4000) ,
    TAGS          VARCHAR2 (4000) ,
    User_USER_ID  INTEGER
  ) ;
ALTER TABLE DOCUMENT ADD CONSTRAINT DOCUMENT_PK PRIMARY KEY ( DOCUMENT_ID ) ;

CREATE TABLE NL_MEMBERS
  (
    LIST_SEQ_ID                  INTEGER NOT NULL ,
    ACTIVE_EMPLOYEES_EMPLOYEE_ID INTEGER ,
    NOTICE_LISTS_NOTICE_LIST_ID  INTEGER ,
    NOTICE_LIST                  INTEGER
  ) ;
ALTER TABLE NL_MEMBERS ADD CONSTRAINT NL_MEMBERS_PK PRIMARY KEY ( LIST_SEQ_ID ) ;

CREATE TABLE NOTICE_LISTS
  (
    NOTICE_LIST_ID     INTEGER NOT NULL ,
    LIST_NAME          VARCHAR2 (40) ,
    OWNERSHIP_DIV_CODE VARCHAR2 (4) ,
    LIST_DESCRIPTION   VARCHAR2 (3500) ,
    EXTERNAL_VIEW_NAME VARCHAR2 (50) ,
    LIST_STATUS        VARCHAR2 (1) ,
    STATUS_EFF_DATE    DATE
  ) ;
ALTER TABLE NOTICE_LISTS ADD CONSTRAINT NOTICE_LISTS_PK PRIMARY KEY ( NOTICE_LIST_ID ) ;

CREATE TABLE "User"
  (
    USER_ID                      INTEGER NOT NULL ,
    IS_ADMIN                     CHAR (1) ,
    APEX_USER                    VARCHAR2 (50) ,
    ACTIVE_EMPLOYEES_EMPLOYEE_ID INTEGER
  ) ;
CREATE UNIQUE INDEX User__IDX ON "User"
  (
    ACTIVE_EMPLOYEES_EMPLOYEE_ID ASC
  )
  ;
  ALTER TABLE "User" ADD CONSTRAINT User_PK PRIMARY KEY ( USER_ID ) ;

ALTER TABLE ACTIVE_EMPLOYEES ADD CONSTRAINT ACTIVE_EMPLOYEES_User_FK FOREIGN KEY ( User_USER_ID ) REFERENCES "User" ( USER_ID ) ;

ALTER TABLE DOCUMENT ADD CONSTRAINT DOCUMENT_User_FK FOREIGN KEY ( User_USER_ID ) REFERENCES "User" ( USER_ID ) ;

ALTER TABLE NL_MEMBERS ADD CONSTRAINT NL_MEMBERS_ACTIVE_EMPLOYEES_FK FOREIGN KEY ( ACTIVE_EMPLOYEES_EMPLOYEE_ID ) REFERENCES ACTIVE_EMPLOYEES ( EMPLOYEE_ID ) ;

ALTER TABLE NL_MEMBERS ADD CONSTRAINT NL_MEMBERS_NOTICE_LISTS_FK FOREIGN KEY ( NOTICE_LISTS_NOTICE_LIST_ID ) REFERENCES NOTICE_LISTS ( NOTICE_LIST_ID ) ;

ALTER TABLE NL_MEMBERS ADD CONSTRAINT NL_MEMBERS_NOTICE_LISTS_FKv1 FOREIGN KEY ( NOTICE_LIST ) REFERENCES NOTICE_LISTS ( NOTICE_LIST_ID ) ;

ALTER TABLE "User" ADD CONSTRAINT User_ACTIVE_EMPLOYEES_FK FOREIGN KEY ( ACTIVE_EMPLOYEES_EMPLOYEE_ID ) REFERENCES ACTIVE_EMPLOYEES ( EMPLOYEE_ID ) ;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             2
-- ALTER TABLE                             11
-- CREATE VIEW                              0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
