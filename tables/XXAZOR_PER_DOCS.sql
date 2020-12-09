


DROP TABLE XXAZOR_PER_DOCS;

CREATE TABLE XXAZOR_PER_DOCS(ID                NUMBER  NOT NULL
                            ,PERSON_ID         NUMBER  NOT NULL
                            ,ASSIGNMENT_ID     NUMBER  NOT NULL
                            ,DOC_TYPE          NUMBER  NOT NULL
                            ,EFECTIVE_DATE     NUMBER  NOT NULL
                            ,CREATED_BY        NUMBER  NOT NULL
                            ,CREATION_DATE     DATE    NOT NULL
                            ,LAST_UPDATED_BY   NUMBER  NOT NULL
                            ,LAST_UPDATE_DATE  DATE    NOT NULL
                            ,LAST_UPDATE_LOGIN NUMBER  NOT NULL
                            )