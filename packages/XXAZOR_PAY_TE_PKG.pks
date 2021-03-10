CREATE OR REPLACE PACKAGE APPS.XXAZOR_PAY_TE_PKG AS 

PROCEDURE GENERATE_ATI(PSI_ERRCOD               OUT VARCHAR2
                      ,PSI_ERRMSG               OUT VARCHAR2
                      ,PNI_BGID                 IN  NUMBER
                      ,PNI_PERSON_ID            IN  NUMBER
                      ,PNI_ASSIGNMENT_ID        IN  NUMBER
                      ,PNI_TIME_PERIOD_ID       IN  NUMBER
                      ,PNI_PAYROLL_ACTION_ID    IN  NUMBER
                      ,PNI_ASSIGNMENT_ACTION_ID IN  NUMBER
                      ,PNI_CONSOLIDATION_SET_ID IN  NUMBER
                      ,PNI_ELEMENT_SET_ID       IN  NUMBER
                      ,PNI_ASSIGNMENT_SET_ID    IN  NUMBER
                      ,PDI_FECHA_PAGO           IN  DATE   
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
                  ,PNI_CONSOLIDATION_SET_ID IN  NUMBER
                  ,PNI_ELEMENT_SET_ID       IN  NUMBER
                  ,PNI_ASSIGNMENT_SET_ID    IN  NUMBER
                  ,PDI_FECHA_PAGO           IN  DATE   
                  );

PROCEDURE UPD_XPT( PSI_ERRCOD               OUT VARCHAR2
                  ,PSI_ERRMSG               OUT VARCHAR2
                  ,PSI_MSG_GRWSBYTE         IN  VARCHAR2
                  ,PNI_BGID                 IN  NUMBER
                  ,PNI_PERSON_ID            IN  NUMBER
                  ,PNI_ASSIGNMENT_ID        IN  NUMBER
                  ,PNI_TIME_PERIOD_ID       IN  NUMBER
                  ,PNI_PAYROLL_ACTION_ID    IN  NUMBER
                  ,PNI_ASSIGNMENT_ACTION_ID IN  NUMBER
                  ,PNI_CONSOLIDATION_SET_ID IN  NUMBER
                  ,PNI_ELEMENT_SET_ID       IN  NUMBER
                  ,PNI_ASSIGNMENT_SET_ID    IN  NUMBER
                  ,PDI_FECHA_PAGO           IN  DATE   
                  );
                                        
END XXAZOR_PAY_TE_PKG; 
/

