CREATE OR REPLACE PACKAGE BODY APPS.XXAZOR_PAY_TE_PKG AS 

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
                      ) IS 
  LC_ATI      CLOB; 
  LS_VAL_REG  VARCHAR2(2000);   
  
  ln_payroll_id   number;                  
BEGIN 

   
   DBMS_LOB.CREATETEMPORARY(lob_loc   => LC_ATI    
                               ,cache    => true     
                               ,dur      => dbms_lob.call
                               );
                                                     
  DBMS_LOB.OPEN(lob_loc    => LC_ATI
                 ,open_mode  => DBMS_LOB.LOB_READWRITE
                 );
                  
      select payroll_id 
        into ln_payroll_id
        from per_time_periods
       where time_period_id = PNI_TIME_PERIOD_ID;           
      
     XXAZOR_PAY_ATI_PKG.Populate_ATI_1(pci_ati                  => LC_ATI
                                      ,pni_business_group_id    => PNI_BGID
                                      ,pni_payroll_id           => ln_payroll_id
                                      ,pni_time_period_id       => pni_time_period_id
                                      ,pni_consolidation_set_id => pni_consolidation_set_id
                                      ,pni_element_set_id       => pni_element_set_id
                                      ,pni_assignment_set_id    => pni_assignment_set_id
                                      ,pni_person_id            => pni_person_id
                                      );

  
--  LC_ATI := '/INICIO'||CHR(10);
--  LC_ATI := LC_ATI||'HOLA'||CHR(10);
--  LC_ATI := LC_ATI||'/FIN';   
          
  
  BEGIN 
   SELECT 'Y'
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
        ,LAST_UPDATED_BY   = nvl(fnd_profile.value('USER_ID'),FND_GLOBAL.USER_ID)
        ,LAST_UPDATE_DATE  = SYSDATE 
        ,LAST_UPDATE_LOGIN = nvl(fnd_profile.value('LOGIN_ID'),FND_GLOBAL.LOGIN_ID)
   WHERE BUSINESS_GROUP_ID = PNI_BGID                 
     AND PERSON_ID = PNI_PERSON_ID            
     AND ASSIGNMENT_ID = PNI_ASSIGNMENT_ID        
     AND TIME_PERIOD_ID = PNI_TIME_PERIOD_ID       
     AND PAYROLL_ACTION_ID = PNI_PAYROLL_ACTION_ID    
     AND ASSIGNMENT_ACTION_ID = PNI_ASSIGNMENT_ACTION_ID;
     
     COMMIT;
 
  EXCEPTION WHEN NO_DATA_FOUND THEN
    INSERT INTO APPS.XXAZOR_PAY_TE(BUSINESS_GROUP_ID    /** NUMBER  NOT NULL **/
                                 ,PERSON_ID            /** NUMBER  NOT NULL **/
                                 ,ASSIGNMENT_ID        /** NUMBER  NOT NULL **/
                                 ,TIME_PERIOD_ID       /** NUMBER  NOT NULL **/
                                 ,PAYROLL_ACTION_ID    /** NUMBER  NOT NULL **/
                                 ,ASSIGNMENT_ACTION_ID /** NUMBER  NOT NULL **/
                                 ,CONSOLIDATION_SET_ID /** NUMBER **/
                                 ,ELEMENT_SET_ID       /** NUMBER **/
                                 ,ASSIGNMENT_SET_ID    /** NUMBER **/
                                 ,FECHA_PAGO           /** DATE   **/ 
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
                                 ,PNI_CONSOLIDATION_SET_ID /** IN  NUMBER **/
                                 ,PNI_ELEMENT_SET_ID       /** IN  NUMBER **/
                                 ,PNI_ASSIGNMENT_SET_ID    /** IN  NUMBER **/
                                 ,PDI_FECHA_PAGO           /** IN  DATE  **/
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
                  ,PNI_CONSOLIDATION_SET_ID IN  NUMBER
                  ,PNI_ELEMENT_SET_ID       IN  NUMBER
                  ,PNI_ASSIGNMENT_SET_ID    IN  NUMBER
                  ,PDI_FECHA_PAGO           IN  DATE   
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
                  ) IS 
BEGIN 
                  
 UPDATE APPS.XXAZOR_PAY_TE
     SET MSG_GRWSBYTE = SUBSTR(PSI_MSG_GRWSBYTE,1,4000)
        ,LAST_UPDATED_BY   = nvl(fnd_profile.value('USER_ID'),FND_GLOBAL.USER_ID)
        ,LAST_UPDATE_DATE  = SYSDATE 
        ,LAST_UPDATE_LOGIN = nvl(fnd_profile.value('LOGIN_ID'),FND_GLOBAL.LOGIN_ID)
   WHERE BUSINESS_GROUP_ID = PNI_BGID                 
     AND PERSON_ID = PNI_PERSON_ID            
     AND ASSIGNMENT_ID = PNI_ASSIGNMENT_ID        
     AND TIME_PERIOD_ID = PNI_TIME_PERIOD_ID       
     AND PAYROLL_ACTION_ID = PNI_PAYROLL_ACTION_ID    
     AND ASSIGNMENT_ACTION_ID = PNI_ASSIGNMENT_ACTION_ID;
     
     COMMIT;
     
EXCEPTION WHEN OTHERS THEN 
PSI_ERRCOD := '2';
PSI_ERRMSG := 'EXCEPTION OTHERS XXAZOR_PAY_TE_PKG.UPD_XPT '||SQLERRM||', '||SQLCODE;
END  UPD_XPT;                       
                      
END XXAZOR_PAY_TE_PKG; 
/

