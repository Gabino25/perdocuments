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
          INITCAP(V.FULL_NAME) FULL_NAME,
          V.NAME POSITION_NAME,
          V.POSITION_ID,
          XPD.ID,
          XPD.CREATION_DATE,
          XPD.EFECTIVE_DATE,
          XPD.STATUS,
          XPD.DOC_TYPE,
          XPDT.MEANING DOC_TYPE_MEANING,
          (SELECT INITCAP(ppf.FULL_NAME) FROM per_people_f ppf WHERE XPD.EFECTIVE_DATE BETWEEN ppf.effective_start_date and ppf.effective_end_date and ppf.person_id = XPD.approver_id) nombre_aprobador
     FROM APPS.XXAZOR_PER_CARTA_LABORAL_V V
         ,XXAZOR_PER_DOCS XPD
         ,XXAZOR_PER_DOC_TYPES XPDT
    WHERE V.PERSON_ID = XPD.PERSON_ID
      AND V.ASSIGNMENT_ID = XPD.ASSIGNMENT_ID
      AND XPD.DOC_TYPE = XPDT.CODE
      AND XPD.ID = CUR_REQ_DOC_ID;
 
 
 CURSOR get_PerDocs_info_v2(CUR_REQ_DOC_ID NUMBER) IS
    SELECT V.PERSON_ID,
          V.ASSIGNMENT_ID,
          V.EMPLOYEE_NUMBER,
          V.FECHA_CONTRATACION,
          V.FECHA_BAJA,
          INITCAP(V.FULL_NAME) FULL_NAME,
          V.NAME POSITION_NAME,
          V.POSITION_ID,
          XPD.ID,
          XPD.CREATION_DATE,
          XPD.EFECTIVE_DATE,
          XPD.STATUS,
          XPD.DOC_TYPE,
          XPDT.MEANING DOC_TYPE_MEANING,
          (SELECT INITCAP(ppf.FULL_NAME) FROM per_people_f ppf WHERE XPD.EFECTIVE_DATE BETWEEN ppf.effective_start_date and ppf.effective_end_date and ppf.person_id = XPD.approver_id) nombre_aprobador,
          V.RFC_EMP,
          V.NSS_EMP,
          V.DIRECCION_EMPLEADO
     FROM APPS.XXAZOR_PER_CARTA_PATRONAL_V V
         ,XXAZOR_PER_DOCS XPD
         ,XXAZOR_PER_DOC_TYPES XPDT
    WHERE V.PERSON_ID = XPD.PERSON_ID
      AND V.ASSIGNMENT_ID = XPD.ASSIGNMENT_ID
      AND XPD.DOC_TYPE = XPDT.CODE
      AND XPD.ID = CUR_REQ_DOC_ID;
      
   CURSOR get_PerDocs_info_v3(CUR_REQ_DOC_ID NUMBER) IS
    SELECT V.PERSON_ID,
          V.ASSIGNMENT_ID,
          V.EMPLOYEE_NUMBER,
          V.FECHA_CONTRATACION,
          V.FECHA_BAJA,
          INITCAP(V.FULL_NAME) FULL_NAME,
          V.NAME POSITION_NAME,
          V.POSITION_ID,
          XPD.ID,
          XPD.CREATION_DATE,
          XPD.EFECTIVE_DATE,
          XPD.STATUS,
          XPD.DOC_TYPE,
          XPDT.MEANING DOC_TYPE_MEANING,
          (SELECT INITCAP(ppf.FULL_NAME) FROM per_people_f ppf WHERE XPD.EFECTIVE_DATE BETWEEN ppf.effective_start_date and ppf.effective_end_date and ppf.person_id = XPD.approver_id) nombre_aprobador,
          V.RFC_EMP,
          V.NSS_EMP,
          V.DIRECCION_EMPLEADO,
          nvl(V.SUELDO_MENSUAL,0)  SUELDO_MENSUAL
     FROM APPS.XXAZOR_PER_CARTA_INGRESOS_V V
         ,XXAZOR_PER_DOCS XPD
         ,XXAZOR_PER_DOC_TYPES XPDT
    WHERE V.PERSON_ID = XPD.PERSON_ID
      AND V.ASSIGNMENT_ID = XPD.ASSIGNMENT_ID
      AND XPD.DOC_TYPE = XPDT.CODE
      AND XPD.ID = CUR_REQ_DOC_ID;   
 
 /**Funcion de reemplazo**/
FUNCTION replace_char_esp(p_cadena IN VARCHAR2)
 RETURN VARCHAR2 IS
 v_cadena VARCHAR2(4000);
 BEGIN
 v_cadena := REPLACE(p_cadena, CHR(38), CHR(38) || 'amp;');
 v_cadena := REPLACE(v_cadena, CHR(50081), CHR(38)||'#225;'); /* v_cadena := REPLACE(v_cadena, CHR(50081), 'HR(38)||'acute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50089), CHR(38)||'#233;'); /* v_cadena := REPLACE(v_cadena, CHR(50089), CHR(38)||'acute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50093), CHR(38)||'#237;'); /* v_cadena := REPLACE(v_cadena, CHR(50093), CHR(38)||'iacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50099), CHR(38)||'#243;'); /* v_cadena := REPLACE(v_cadena, CHR(50099), cHR(38)||'oacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50106), CHR(38)||'#250;'); /* v_cadena := REPLACE(v_cadena, CHR(50106), CHR(38)||'uacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50049), CHR(38)||'#193;'); /* v_cadena := REPLACE(v_cadena, CHR(50049), CHR(38)||'Aacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50057), CHR(38)||'#201;'); /* v_cadena := REPLACE(v_cadena, CHR(50057), CHR(38)||'Eacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50061), CHR(38)||'#205;'); /* v_cadena := REPLACE(v_cadena, CHR(50061), CHR(38)||'Iacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50067), CHR(38)||'#211;'); /* v_cadena := REPLACE(v_cadena, CHR(50067), CHR(38)||'Oacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50074), CHR(38)||'#218;'); /* v_cadena := REPLACE(v_cadena, CHR(50074), CHR(38)||'Uacute;'); */
 v_cadena := REPLACE(v_cadena, CHR(50065), CHR(38)||'#209;'); /* v_cadena := REPLACE(v_cadena, CHR(50065), CHR(38)||'Ntilde;'); */
 v_cadena := REPLACE(v_cadena, CHR(50097), CHR(38)||'#241;'); /* v_cadena := REPLACE(v_cadena, CHR(50097), CHR(38)||'ntilde'); */
 v_cadena := REPLACE(v_cadena, CHR(49844), '');
 v_cadena := REPLACE(v_cadena, CHR(50090), '');
 v_cadena := REPLACE(v_cadena, CHR(50056), 'E');
 RETURN v_cadena;
 END replace_char_esp;     

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
                          ,PNI_APPROVER_ID    IN  NUMBER
                          ,PNI_USER_ID        IN  NUMBER
                          ,PNI_LOGIN_ID       IN  NUMBER
                          ) IS 

 per_info_rec get_per_info%ROWTYPE;
 ls_itemkey   varchar2(2000);
 ln_per_doc_id number; 
BEGIN 

  PSI_ERRCOD := null; 
  PSI_ERRMSG := null;
 
  if PSI_DOC_TYPE in (gs_carta_laboral
                     ,gs_carta_patronal
                     ,gs_carta_ingresos
                     )   then 
 
  OPEN get_per_info(PNI_PERSON_ID
                   ,PNI_ASSIGNMENT_ID
                   ,PDI_EFFECTIVE_DATE
                   );
   LOOP
      FETCH get_per_info INTO per_info_rec;
      EXIT WHEN get_per_info%NOTFOUND;
      
      PSI_ERRMSG := 'ENTRA LOOP';
      
      select XXAZOR_PER_DOCS_S.NEXTVAL
        into ln_per_doc_id
        from dual; 
      
       INSERT INTO  APPS.XXAZOR_PER_DOCS(ID           /**NUMBER  NOT NULL **/
                                 ,PERSON_ID         /**NUMBER  NOT NULL**/
                                 ,ASSIGNMENT_ID     /**NUMBER  NOT NULL**/
                                 ,DOC_TYPE          /**VARCHAR2  NOT NULL**/
                                 ,EFECTIVE_DATE     /**DATE  NOT NULL**/
                                 ,XML               /**CLOB**/    
                                 ,STATUS            /**VARCHAR2(200)  NOT NULL**/
                                 ,APPROVER_ID 
                                 ,CREATED_BY        /**NUMBER  NOT NULL**/
                                 ,CREATION_DATE     /**DATE    NOT NULL**/
                                 ,LAST_UPDATED_BY   /**NUMBER  NOT NULL**/
                                 ,LAST_UPDATE_DATE   /**DATE    NOT NULL**/
                                 ,LAST_UPDATE_LOGIN  /**NUMBER  NOT NULL**/
                                 ) VALUES
                                 (ln_per_doc_id
                                 ,per_info_rec.person_id
                                 ,per_info_rec.assignment_id
                                 ,psi_doc_type
                                 ,pdi_effective_date
                                 ,PSI_DOC_TYPE
                                 ,gs_open
                                 ,PNI_APPROVER_ID
                                 ,PNI_USER_ID
                                 ,SYSDATE
                                 ,PNI_USER_ID
                                 ,SYSDATE
                                 ,PNI_LOGIN_ID
                                 );
                                 
    commit; 
    
    PSI_ERRMSG := 'SE HA CREADO LA SOLICITUD';
    
    for idx in (SELECT full_name,doc_type_meaning from XXAZOR_PER_DOCS_V where id = ln_per_doc_id) loop
        
        select XXAZOR_PER_DOCS_WF_S.nextval
          into ls_itemkey
          from dual;
         
        wf_engine.CreateProcess (itemtype => gs_item_type
                                ,itemkey  => ls_itemkey
                                ,process  => gs_documents_prc
                                );
        
        wf_engine.SetItemUserKey (itemtype => gs_item_type
                                 ,itemkey  => ls_itemkey
                                 ,userkey  => nvl(fnd_global.user_name,'SYSADMIN')
                                 );
     
       wf_engine.SetItemAttrText (itemtype => gs_item_type
                                 ,itemkey  => ls_itemkey
                                 ,aname    => '#FROM_ROLE'
                                 ,avalue   =>  nvl(fnd_global.user_name,'SYSADMIN')
                                  );
                                  
       wf_engine.SetItemAttrText (itemtype => gs_item_type
                                 ,itemkey  => ls_itemkey
                                 ,aname    => 'SUPERVISOR'
                                 ,avalue   => 'MPMOYA'
                                  );
     
       wf_engine.SetItemAttrNumber(itemtype => gs_item_type
                                 ,itemkey  => ls_itemkey
                                 ,aname    => 'REQ_DOC_ID'
                                 ,avalue   => ln_per_doc_id
                                  );
                                  
        wf_engine.SetItemAttrText (itemtype => gs_item_type
                                 ,itemkey  => ls_itemkey
                                 ,aname    => 'DOC_TYPE'
                                 ,avalue   => idx.doc_type_meaning
                                  );
                                  
          wf_engine.SetItemAttrText (itemtype => gs_item_type
                                 ,itemkey  => ls_itemkey
                                 ,aname    => 'EMPLOYEE'
                                 ,avalue   => idx.full_name
                                  );
                                                           
        wf_engine.SetItemOwner (itemtype =>  gs_item_type
                               ,itemkey  =>  ls_itemkey
                               ,owner    =>  nvl(fnd_global.user_name,'SYSADMIN')
                               );
     
        wf_engine.StartProcess (itemtype  => gs_item_type
                               ,itemkey   => ls_itemkey
                               );
         
         commit;
    
    end loop; 
    
    
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

 PerDocs_info_rec     get_PerDocs_info%ROWTYPE;
 PerDocs_info_rec_v2  get_PerDocs_info_v2%ROWTYPE;
 PerDocs_info_rec_v3  get_PerDocs_info_v3%ROWTYPE;
 
 ls_day           varchar2(200);
 ls_month         varchar2(200);
 ls_year          varchar2(200);
 ls_doc_type      varchar2(200);

BEGIN 

  PSI_ERRCOD := null; 
  PSI_ERRMSG := null;
 
  select doc_type
   into ls_doc_type
    from XXAZOR_PER_DOCS 
    where id = PNI_REQUEST_ID;
  
  ls_per_doc := ls_per_doc||'<XXAZOR_PER_DOC>';
  
   if 'CARTA_LABORAL' = ls_doc_type then 
  
   OPEN get_PerDocs_info(PNI_REQUEST_ID);
   LOOP
      FETCH get_PerDocs_info INTO PerDocs_info_rec;
      EXIT WHEN get_PerDocs_info%NOTFOUND;
      
      ls_day := extract(day from PerDocs_info_rec.efective_date);
      ls_month := getMonthDesc(extract(month from PerDocs_info_rec.efective_date));
      ls_year := extract(year from PerDocs_info_rec.efective_date);
      
      ls_per_doc := ls_per_doc||'<FECHA>'||'a '||ls_day||' de '||ls_month||' a '||ls_year||'</FECHA>';
      ls_per_doc := ls_per_doc||'<EMPLOYEE_NAME>'||replace_char_esp(PerDocs_info_rec.full_name)||'</EMPLOYEE_NAME>';
      ls_per_doc := ls_per_doc||'<FECHA_INGRESO>'||replace(to_char(PerDocs_info_rec.fecha_contratacion,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_INGRESO>';
      ls_per_doc := ls_per_doc||'<FECHA_BAJA>'||replace(to_char(PerDocs_info_rec.fecha_baja,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_BAJA>';
      ls_per_doc := ls_per_doc||'<PUESTO>'||replace_char_esp(PerDocs_info_rec.position_name)||'</PUESTO>';
      ls_per_doc := ls_per_doc||'<APROBADOR>'||replace_char_esp(PerDocs_info_rec.nombre_aprobador)||'</APROBADOR>';
      ls_per_doc := ls_per_doc||'<DOC_TYPE>'||ls_doc_type||'</DOC_TYPE>';
      
      EXIT;
   END LOOP;
   CLOSE get_PerDocs_info;
   
  elsif  'CARTA_PATRONAL' = ls_doc_type then 
      
   OPEN get_PerDocs_info_v2(PNI_REQUEST_ID);
   LOOP
      FETCH get_PerDocs_info_v2 INTO PerDocs_info_rec_v2;
      EXIT WHEN get_PerDocs_info_v2%NOTFOUND;
      
      ls_day := extract(day from PerDocs_info_rec_v2.efective_date);
      ls_month := getMonthDesc(extract(month from PerDocs_info_rec_v2.efective_date));
      ls_year := extract(year from PerDocs_info_rec_v2.efective_date);
      
      ls_per_doc := ls_per_doc||'<FECHA>'||'a '||ls_day||' de '||ls_month||' a '||ls_year||'</FECHA>';
      ls_per_doc := ls_per_doc||'<EMPLOYEE_NAME>'||replace_char_esp(PerDocs_info_rec_v2.full_name)||'</EMPLOYEE_NAME>';
      ls_per_doc := ls_per_doc||'<FECHA_INGRESO>'||replace(to_char(PerDocs_info_rec_v2.fecha_contratacion,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_INGRESO>';
      ls_per_doc := ls_per_doc||'<FECHA_BAJA>'||replace(to_char(PerDocs_info_rec_v2.fecha_baja,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_BAJA>';
      ls_per_doc := ls_per_doc||'<PUESTO>'||replace_char_esp(PerDocs_info_rec_v2.position_name)||'</PUESTO>';
      ls_per_doc := ls_per_doc||'<APROBADOR>'||replace_char_esp(PerDocs_info_rec_v2.nombre_aprobador)||'</APROBADOR>';
      ls_per_doc := ls_per_doc||'<RFC_EMP>'||PerDocs_info_rec_v2.rfc_emp||'</RFC_EMP>';
      ls_per_doc := ls_per_doc||'<NSS_EMP>'||PerDocs_info_rec_v2.nss_emp||'</NSS_EMP>';
      ls_per_doc := ls_per_doc||'<DIRECCION_EMP>'||replace_char_esp(PerDocs_info_rec_v2.direccion_empleado)||'</DIRECCION_EMP>';
      ls_per_doc := ls_per_doc||'<DOC_TYPE>'||ls_doc_type||'</DOC_TYPE>';
    
      EXIT;
   END LOOP;
   CLOSE get_PerDocs_info_v2;
     
  elsif  'CARTA_INGRESOS' = ls_doc_type then 
      
   OPEN get_PerDocs_info_v3(PNI_REQUEST_ID);
   LOOP
      FETCH get_PerDocs_info_v3 INTO PerDocs_info_rec_v3;
      EXIT WHEN get_PerDocs_info_v3%NOTFOUND;
      
      ls_day := extract(day from PerDocs_info_rec_v3.efective_date);
      ls_month := getMonthDesc(extract(month from PerDocs_info_rec_v3.efective_date));
      ls_year := extract(year from PerDocs_info_rec_v3.efective_date);
      
      ls_per_doc := ls_per_doc||'<FECHA>'||'a '||ls_day||' de '||ls_month||' a '||ls_year||'</FECHA>';
      ls_per_doc := ls_per_doc||'<EMPLOYEE_NAME>'||replace_char_esp(PerDocs_info_rec_v3.full_name)||'</EMPLOYEE_NAME>';
      ls_per_doc := ls_per_doc||'<FECHA_INGRESO>'||replace(to_char(PerDocs_info_rec_v3.fecha_contratacion,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_INGRESO>';
      ls_per_doc := ls_per_doc||'<FECHA_BAJA>'||replace(to_char(PerDocs_info_rec_v3.fecha_baja,'DD/MONTH/YYYY','NLS_DATE_LANGUAGE=SPANISH'),' ','')||'</FECHA_BAJA>';
      ls_per_doc := ls_per_doc||'<PUESTO>'||replace_char_esp(PerDocs_info_rec_v3.position_name)||'</PUESTO>';
      ls_per_doc := ls_per_doc||'<APROBADOR>'||replace_char_esp(PerDocs_info_rec_v3.nombre_aprobador)||'</APROBADOR>';
      ls_per_doc := ls_per_doc||'<RFC_EMP>'||PerDocs_info_rec_v3.rfc_emp||'</RFC_EMP>';
      ls_per_doc := ls_per_doc||'<NSS_EMP>'||PerDocs_info_rec_v3.nss_emp||'</NSS_EMP>';
      ls_per_doc := ls_per_doc||'<DIRECCION_EMP>'||replace_char_esp(PerDocs_info_rec_v3.direccion_empleado)||'</DIRECCION_EMP>';
      ls_per_doc := ls_per_doc||'<SUELDO_MENSUAL>'||trim(to_char(PerDocs_info_rec_v3.sueldo_mensual,gs_currency_format))||'</SUELDO_MENSUAL>';
      ls_per_doc := ls_per_doc||'<DOC_TYPE>'||ls_doc_type||'</DOC_TYPE>';
    
      EXIT;
   END LOOP;
   CLOSE get_PerDocs_info_v3; 
  end if;
  
   
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

