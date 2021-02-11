CREATE OR REPLACE PACKAGE APPS.XXAZOR_PAY_TE_PKG AS 

PROCEDURE GENERATE_ATI(PSI_ERRCOD               OUT VARCHAR2
                      ,PSI_ERRMSG               OUT VARCHAR2
                      ,PNI_BGID                 IN  NUMBER
                      ,PNI_PERSON_ID            IN  NUMBER
                      ,PNI_ASSIGNMENT_ID        IN  NUMBER
                      ,PNI_TIME_PERIOD_ID       IN  NUMBER
                      ,PNI_PAYROLL_ACTION_ID    IN  NUMBER
                      ,PNI_ASSIGNMENT_ACTION_ID IN  NUMBER
                      ); 

PROCEDURE GET_ATI( PSI_ERRCOD               OUT VARCHAR2
                  ,PSI_ERRMSG               OUT VARCHAR2
                  ,PCO_ATI                  OUT CLOB
                  ,PNI_BGID                 IN  NUMBER
                  ,PNI_PERSON_ID            IN  NUMBER
                  ,PNI_ASSIGNMENT_ID        IN  NUMBER
                  ,PNI_TIME_PERIOD_ID       IN  NUMBER
                  ,PNI_PAYROLL_ACTION_ID    IN  NUMBER
                  ,PNI_ASSIGNMENT_ACTION_ID IN  NUMBER
                  );
                      
END XXAZOR_PAY_TE_PKG; 
/

