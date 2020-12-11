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
      
 CURSOR get_PerDocs_info(CUR_REQ_DOC_ID NUMBER) IS
    SELECT V.PERSON_ID,
          V.ASSIGNMENT_ID,
          V.EMPLOYEE_NUMBER,
          V.FECHA_CONTRATACION,
          V.FECHA_BAJA,
          V.FULL_NAME,
          V.NAME POSITION_NAME,
          V.POSITION_ID,
          XPD.ID,
          XPD.CREATION_DATE,
          XPD.EFECTIVE_DATE,
          XPD.STATUS,
          XPD.DOC_TYPE,
          XPDT.MEANING DOC_TYPE_MEANING
     FROM APPS.XXAZOR_PER_CARTA_LABORAL_V V
         ,XXAZOR_PER_DOCS XPD
         ,XXAZOR_PER_DOC_TYPES XPDT
    WHERE V.PERSON_ID = XPD.PERSON_ID
      AND V.ASSIGNMENT_ID = XPD.ASSIGNMENT_ID
      AND XPD.DOC_TYPE = XPDT.CODE
      AND XPD.ID = CUR_REQ_DOC_ID;
      

function getMonthDesc(pni_month  in natural) return varchar2 is 
begin 
 
 if pni_month = 1 then 
   return 'Enero';
 elsif pni_month = 2 then 
   return 'Febrero';  
 elsif pni_month = 3 then 
   return 'Marzo';    
 elsif pni_month = 4 then 
   return 'Abril';
 elsif pni_month = 5 then 
   return 'Mayo';
 elsif pni_month = 6 then 
   return 'Junio';  
 elsif pni_month = 7 then 
   return 'Julio';   
 elsif pni_month = 8 then 
   return 'Agosto';   
 elsif pni_month = 9 then 
   return 'Septiembre'; 
 elsif pni_month = 10 then 
   return 'Octubre';    
 elsif pni_month = 11 then 
   return 'Nomviembre'; 
 elsif pni_month = 12 then 
   return 'Diciembre';             
 end if; 
 
Exception when others then 
 return 'Invalid Month'; 
end getMonthDesc; 
            

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
                      ,PNI_USER_ID        IN  NUMBER
                      ,PNI_LOGIN_ID       IN  NUMBER
                      ) IS 


ls_per_doc   clob := '';

 PerDocs_info_rec get_PerDocs_info%ROWTYPE;
 ls_day           varchar2(200);
 ls_month         varchar2(200);
 ls_year          varchar2(200);

BEGIN 

  PSI_ERRCOD := null; 
  PSI_ERRMSG := null;
 
  
  ls_per_doc := ls_per_doc||'<XXAZOR_PER_DOC>';
   
   OPEN get_PerDocs_info(PNI_REQUEST_ID);
   LOOP
      FETCH get_PerDocs_info INTO PerDocs_info_rec;
      EXIT WHEN get_PerDocs_info%NOTFOUND;
      
      ls_day := extract(day from PerDocs_info_rec.efective_date);
      ls_month := getMonthDesc(extract(month from PerDocs_info_rec.efective_date));
      ls_year := extract(year from PerDocs_info_rec.efective_date);
      
      ls_per_doc := ls_per_doc||'<FECHA>'||'a '||ls_day||' de '||ls_month||' a '||ls_year||'</FECHA>';
      ls_per_doc := ls_per_doc||'<EMPLOYEE_NAME>'||PerDocs_info_rec.full_name||'</EMPLOYEE_NAME>';
      ls_per_doc := ls_per_doc||'<FECHA_INGRESO>'||replace(to_char(PerDocs_info_rec.fecha_contratacion,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_INGRESO>';
      ls_per_doc := ls_per_doc||'<FECHA_BAJA>'||replace(to_char(PerDocs_info_rec.fecha_baja,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_BAJA>';
      ls_per_doc := ls_per_doc||'<PUESTO>'||PerDocs_info_rec.position_name||'</PUESTO>';
      
      EXIT;
   END LOOP;
   CLOSE get_PerDocs_info;
   
  ls_per_doc := ls_per_doc||'</XXAZOR_PER_DOC>';
  
  UPDATE XXAZOR_PER_DOCS
     SET XML = ls_per_doc
        ,STATUS = gs_close
        ,LAST_UPDATE_DATE = SYSDATE
        ,LAST_UPDATED_BY = PNI_USER_ID
        ,LAST_UPDATE_LOGIN = PNI_LOGIN_ID
    WHERE ID = PNI_REQUEST_ID;
    
    commit; 
   
   PSI_ERRMSG := 'SE HA GENERADO EL DOCUMENTO'; 
   

EXCEPTION WHEN OTHERS THEN 
 PSI_ERRCOD := SQLCODE;
 PSI_ERRMSG := SQLERRM; 
 
END generate_xml; 


PROCEDURE get_xml(PSO_XMLDOC         OUT CLOB
                 ,PNI_REQUEST_ID     IN  NUMBER
                  )IS 
BEGIN 
  select XML
    INTO PSO_XMLDOC
    from XXAZOR_PER_DOCS
   WHERE ID = PNI_REQUEST_ID;
EXCEPTION WHEN OTHERS THEN 
 null; 
END get_xml; 
   
                  

END XXAZOR_PER_DOCS_PKG; 
/

