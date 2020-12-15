DROP TABLE APPS.XXAZOR_PER_DOCS CASCADE CONSTRAINT;


CREATE TABLE APPS.XXAZOR_PER_DOCS(ID                NUMBER  NOT NULL
                                 ,PERSON_ID         NUMBER  NOT NULL
                                 ,ASSIGNMENT_ID     NUMBER  NOT NULL
                                 ,DOC_TYPE          VARCHAR2(200)  NOT NULL
                                 ,EFECTIVE_DATE     DATE    NOT NULL
                                 ,XML               CLOB    
                                 ,STATUS            VARCHAR2(200)  NOT NULL
                                 ,APPROVER_ID       NUMBER
                                 ,CREATED_BY        NUMBER  NOT NULL
                                 ,CREATION_DATE     DATE    NOT NULL
                                 ,LAST_UPDATED_BY   NUMBER  NOT NULL
                                 ,LAST_UPDATE_DATE  DATE    NOT NULL
                                 ,LAST_UPDATE_LOGIN NUMBER  NOT NULL
                                 ,CONSTRAINT XXAZOR_PER_DOCS_U1 UNIQUE(PERSON_ID,ASSIGNMENT_ID,DOC_TYPE,EFECTIVE_DATE)
                                 );