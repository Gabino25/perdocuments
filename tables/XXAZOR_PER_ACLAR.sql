DROP TABLE APPS.XXAZOR_PER_ACLAR CASCADE CONSTRAINT;


CREATE TABLE APPS.XXAZOR_PER_ACLAR(ID                NUMBER  NOT NULL
                                 ,PERSON_ID         NUMBER  NOT NULL
                                 ,ASSIGNMENT_ID     NUMBER  NOT NULL
                                 ,EFECTIVE_DATE     DATE    NOT NULL
                                 ,STATUS            VARCHAR2(200)  NOT NULL
                                 ,PADRE             VARCHAR2(500)  NOT NULL
                                 ,HIJO              VARCHAR2(500)  NOT NULL
                                 ,NIETO             VARCHAR2(500)  NOT NULL
                                 ,APPROVER_ID       NUMBER
                                 ,DESC_ACLARACION    VARCHAR2(4000)
                                 ,NOTA_APPROVER      VARCHAR2(4000)
                                 ,CREATED_BY        NUMBER  NOT NULL
                                 ,CREATION_DATE     DATE    NOT NULL
                                 ,LAST_UPDATED_BY   NUMBER  NOT NULL
                                 ,LAST_UPDATE_DATE  DATE    NOT NULL
                                 ,LAST_UPDATE_LOGIN NUMBER  NOT NULL
                                 ,CONSTRAINT XXAZOR_PER_ACLAR_U1 UNIQUE(PERSON_ID,ASSIGNMENT_ID,PADRE,HIJO,NIETO,EFECTIVE_DATE)
                                 );