CREATE OR REPLACE PACKAGE BODY APPS.XXAZOR_PAY_TE_PKG AS 

PROCEDURE GENERATE_ATI(PSI_ERRCOD               OUT VARCHAR2
                      ,PSI_ERRMSG               OUT VARCHAR2
                      ,PNI_BGID                 IN  NUMBER
                      ,PNI_PERSON_ID            IN  NUMBER
                      ,PNI_ASSIGNMENT_ID        IN  NUMBER
                      ,PNI_TIME_PERIOD_ID       IN  NUMBER
                      ,PNI_PAYROLL_ACTION_ID    IN  NUMBER
                      ,PNI_ASSIGNMENT_ACTION_ID IN  NUMBER
                      ) IS 
  LC_ATI      CLOB; 
  LS_VAL_REG  VARCHAR2(2000);                    
BEGIN 
  LC_ATI := '/INICIO'||CHR(13);
  LC_ATI:=LC_ATI||'/FIN';           
  
  BEGIN 
   SELECT ATI
    INTO LS_VAL_REG
    FROM APPS.XXAZOR_PAY_TE
   WHERE BUSINESS_GROUP_ID = PNI_BGID                 
     AND PERSON_ID = PNI_PERSON_ID            
     AND ASSIGNMENT_ID = PNI_ASSIGNMENT_ID        
     AND TIME_PERIOD_ID = PNI_TIME_PERIOD_ID       
     AND PAYROLL_ACTION_ID = PNI_PAYROLL_ACTION_ID    
     AND ASSIGNMENT_ACTION_ID = PNI_ASSIGNMENT_ACTION_ID; 
     
  UPDATE APPS.XXAZOR_PAY_TE
     SET ATI = LC_ATI
   WHERE BUSINESS_GROUP_ID = PNI_BGID                 
     AND PERSON_ID = PNI_PERSON_ID            
     AND ASSIGNMENT_ID = PNI_ASSIGNMENT_ID        
     AND TIME_PERIOD_ID = PNI_TIME_PERIOD_ID       
     AND PAYROLL_ACTION_ID = PNI_PAYROLL_ACTION_ID    
     AND ASSIGNMENT_ACTION_ID = PNI_ASSIGNMENT_ACTION_ID;
     
 
  EXCEPTION WHEN NO_DATA_FOUND THEN
    INSERT INTO APPS.XXAZOR_PAY_TE(BUSINESS_GROUP_ID    /** NUMBER  NOT NULL **/
                                 ,PERSON_ID            /** NUMBER  NOT NULL **/
                                 ,ASSIGNMENT_ID        /** NUMBER  NOT NULL **/
                                 ,TIME_PERIOD_ID       /** NUMBER  NOT NULL **/
                                 ,PAYROLL_ACTION_ID    /** NUMBER  NOT NULL **/
                                 ,ASSIGNMENT_ACTION_ID /** NUMBER  NOT NULL **/
                                 ,ATI                  /** CLOB **/
                                 ,CREATED_BY        /** NUMBER  NOT NULL **/
                                 ,CREATION_DATE     /** DATE    NOT NULL **/
                                 ,LAST_UPDATED_BY   /** NUMBER  NOT NULL **/
                                 ,LAST_UPDATE_DATE  /** DATE    NOT NULL **/
                                 ,LAST_UPDATE_LOGIN /** NUMBER  NOT NULL **/
                                 )
                            VALUES
                                 (PNI_BGID/** BUSINESS_GROUP_ID     NUMBER  NOT NULL **/
                                 ,PNI_PERSON_ID/** PERSON_ID            NUMBER  NOT NULL **/
                                 ,PNI_ASSIGNMENT_ID /** ASSIGNMENT_ID        NUMBER  NOT NULL **/
                                 ,PNI_TIME_PERIOD_ID /** TIME_PERIOD_ID       NUMBER  NOT NULL **/
                                 ,PNI_PAYROLL_ACTION_ID/** PAYROLL_ACTION_ID    NUMBER  NOT NULL **/
                                 ,PNI_ASSIGNMENT_ACTION_ID/** ASSIGNMENT_ACTION_ID NUMBER  NOT NULL **/
                                 ,LC_ATI/** ATI                  CLOB **/
                                 ,nvl(fnd_profile.value('USER_ID'),FND_GLOBAL.USER_ID)/** CREATED_BY         NUMBER  NOT NULL **/
                                 ,SYSDATE/** CREATION_DATE     DATE    NOT NULL **/
                                 ,nvl(fnd_profile.value('USER_ID'),FND_GLOBAL.USER_ID)/** LAST_UPDATED_BY   NUMBER  NOT NULL **/
                                 ,SYSDATE/** LAST_UPDATE_DATE  DATE    NOT NULL **/
                                 ,nvl(fnd_profile.value('LOGIN_ID'),FND_GLOBAL.LOGIN_ID)/** LAST_UPDATE_LOGIN NUMBER  NOT NULL **/
                                  ); 
   COMMIT; 
    
  END;
  
                 
EXCEPTION WHEN OTHERS THEN 
PSI_ERRCOD := '2';
PSI_ERRMSG := 'EXCEPTION OTHERS XXAZOR_PAY_TE_PKG.GENERATE_ATI '||SQLERRM||', '||SQLCODE;
END  GENERATE_ATI; 

PROCEDURE GET_ATI( PSI_ERRCOD               OUT VARCHAR2
                  ,PSI_ERRMSG               OUT VARCHAR2
                  ,PCO_ATI                  OUT CLOB
                  ,PNI_BGID                 IN  NUMBER
                  ,PNI_PERSON_ID            IN  NUMBER
                  ,PNI_ASSIGNMENT_ID        IN  NUMBER
                  ,PNI_TIME_PERIOD_ID       IN  NUMBER
                  ,PNI_PAYROLL_ACTION_ID    IN  NUMBER
                  ,PNI_ASSIGNMENT_ACTION_ID IN  NUMBER
                  ) IS 
BEGIN 

  SELECT ATI
    INTO PCO_ATI
    FROM APPS.XXAZOR_PAY_TE
   WHERE BUSINESS_GROUP_ID = PNI_BGID                 
     AND PERSON_ID = PNI_PERSON_ID            
     AND ASSIGNMENT_ID = PNI_ASSIGNMENT_ID        
     AND TIME_PERIOD_ID = PNI_TIME_PERIOD_ID       
     AND PAYROLL_ACTION_ID = PNI_PAYROLL_ACTION_ID    
     AND ASSIGNMENT_ACTION_ID = PNI_ASSIGNMENT_ACTION_ID; 
   
EXCEPTION WHEN OTHERS THEN 
PSI_ERRCOD := '2';
PSI_ERRMSG := 'EXCEPTION OTHERS XXAZOR_PAY_TE_PKG.GET_ATI '||SQLERRM||', '||SQLCODE;
END  GET_ATI;                   
                      
END XXAZOR_PAY_TE_PKG; 
/
