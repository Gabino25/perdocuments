CREATE OR REPLACE PACKAGE BODY APPS.XXAZOR_PER_DOCS_PKG AS 

CURSOR get_per_info(CUR_PERSON_ID        NUMBER
                    ,CUR_ASSIGNMENT_ID   NUMBER
                    ,CUR_EFFECTIVE_DATE  DATE
                    ) IS
   SELECT V.PERSON_ID,
          V.ASSIGNMENT_ID,
          V.EMPLOYEE_NUMBER,
          V.FECHA_CONTRATACION,
          V.FECHA_BAJA,
          V.FULL_NAME,
          V.NAME,
          V.POSITION_ID 
     FROM APPS.XXAZOR_PER_CARTA_LABORAL_V V
    WHERE V.PERSON_ID = CUR_PERSON_ID
      AND V.ASSIGNMENT_ID = CUR_ASSIGNMENT_ID
      AND CUR_EFFECTIVE_DATE BETWEEN V.FECHA_CONTRATACION AND NVL(V.FECHA_BAJA,to_date ('31/12/4712','DD/MM/YYYY'));

PROCEDURE generate_request(PSI_ERRCOD         OUT VARCHAR2
                          ,PSI_ERRMSG         OUT VARCHAR2
                          ,PNI_PERSON_ID      IN  NUMBER
                          ,PNI_ASSIGNMENT_ID  IN  NUMBER
                          ,PDI_EFFECTIVE_DATE IN  DATE
                          ,PSI_DOC_TYPE       IN  VARCHAR2
                          ,PNI_USER_ID        IN  NUMBER
                          ,PNI_LOGIN_ID       IN  NUMBER
                          ) IS 

 per_info_rec get_per_info%ROWTYPE;
  
BEGIN 

  PSI_ERRCOD := null; 
  PSI_ERRMSG := null;
 
  if gs_carta_laboral =  PSI_DOC_TYPE then 
 
  OPEN get_per_info(PNI_PERSON_ID
                   ,PNI_ASSIGNMENT_ID
                   ,PDI_EFFECTIVE_DATE
                   );
   LOOP
      FETCH get_per_info INTO per_info_rec;
      EXIT WHEN get_per_info%NOTFOUND;
      
      PSI_ERRMSG := 'ENTRA LOOP';
      
       INSERT INTO  APPS.XXAZOR_PER_DOCS(ID           /**NUMBER  NOT NULL **/
                                 ,PERSON_ID         /**NUMBER  NOT NULL**/
                                 ,ASSIGNMENT_ID     /**NUMBER  NOT NULL**/
                                 ,DOC_TYPE          /**VARCHAR2  NOT NULL**/
                                 ,EFECTIVE_DATE     /**DATE  NOT NULL**/
                                 ,XML               /**CLOB**/    
                                 ,STATUS            /**VARCHAR2(200)  NOT NULL**/
                                 ,CREATED_BY        /**NUMBER  NOT NULL**/
                                 ,CREATION_DATE     /**DATE    NOT NULL**/
                                 ,LAST_UPDATED_BY   /**NUMBER  NOT NULL**/
                                 ,LAST_UPDATE_DATE   /**DATE    NOT NULL**/
                                 ,LAST_UPDATE_LOGIN  /**NUMBER  NOT NULL**/
                                 ) VALUES
                                 (XXAZOR_PER_DOCS_S.NEXTVAL
                                 ,per_info_rec.person_id
                                 ,per_info_rec.assignment_id
                                 ,psi_doc_type
                                 ,pdi_effective_date
                                 ,PSI_DOC_TYPE
                                 ,gs_open
                                 ,PNI_USER_ID
                                 ,SYSDATE
                                 ,PNI_USER_ID
                                 ,SYSDATE
                                 ,PNI_LOGIN_ID
                                 );
                                 
    commit; 
    
    PSI_ERRMSG := 'SE HA CREADO LA SOLICITUD';
     
    exit;
      
   END LOOP;
   CLOSE get_per_info;
  
  
   return;
  end if; 
  
   

EXCEPTION WHEN OTHERS THEN 
 PSI_ERRCOD := SQLCODE;
 PSI_ERRMSG := SQLERRM; 
 
END generate_request; 

                          

PROCEDURE generate_xml(PSI_ERRCOD  OUT  VARCHAR2
                      ,PSI_ERRMSG  OUT  VARCHAR2
                      ,PNI_REQUEST_ID     IN  NUMBER
                      ,PNI_PERSON_ID      IN  NUMBER
                      ,PNI_ASSIGNMENT_ID  IN  NUMBER
                      ,PDI_EFFECTIVE_DATE IN  DATE
                      ,PSI_DOC_TYPE       IN  VARCHAR2
                      ) IS 


ls_per_doc   clob := '';



BEGIN 

  PSI_ERRCOD := null; 
  PSI_ERRMSG := null;
 
  if gs_carta_laboral =  PSI_DOC_TYPE then 
 
  ls_per_doc := ls_per_doc||'<XXAZOR_PER_DOC>';
  ls_per_doc := ls_per_doc||'</XXAZOR_PER_DOC>';
  
   return;
  end if; 
  
   

EXCEPTION WHEN OTHERS THEN 
 PSI_ERRCOD := SQLCODE;
 PSI_ERRMSG := SQLERRM; 
 
END generate_xml; 


END XXAZOR_PER_DOCS_PKG; 
/

