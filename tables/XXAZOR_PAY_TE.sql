DROP TABLE APPS.XXAZOR_PAY_TE CASCADE CONSTRAINT;


CREATE TABLE APPS.XXAZOR_PAY_TE(BUSINESS_GROUP_ID    NUMBER  NOT NULL
                               ,PERSON_ID            NUMBER  NOT NULL
                               ,ASSIGNMENT_ID        NUMBER  NOT NULL
                               ,TIME_PERIOD_ID       NUMBER  NOT NULL
                               ,PAYROLL_ACTION_ID    NUMBER  NOT NULL
                               ,ASSIGNMENT_ACTION_ID NUMBER  NOT NULL
                               ,CONSOLIDATION_SET_ID NUMBER
                               ,ELEMENT_SET_ID       NUMBER
                               ,ASSIGNMENT_SET_ID    NUMBER
                               ,FECHA_PAGO           DATE   
                               ,ATI                  CLOB
                               ,MSG_GRWSBYTE         VARCHAR2(4000)  /** MAX SIZE **/
                               ,CREATED_BY        NUMBER  NOT NULL
                               ,CREATION_DATE     DATE    NOT NULL
                               ,LAST_UPDATED_BY   NUMBER  NOT NULL
                               ,LAST_UPDATE_DATE  DATE    NOT NULL
                               ,LAST_UPDATE_LOGIN NUMBER  NOT NULL
                               ,CONSTRAINT XXAZOR_PAY_TE_U1 UNIQUE(PERSON_ID,ASSIGNMENT_ID,TIME_PERIOD_ID,PAYROLL_ACTION_ID,ASSIGNMENT_ACTION_ID)
                               );