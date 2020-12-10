CREATE OR REPLACE PACKAGE BODY APPS.XXAZOR_PER_DOCS_PKG AS 
PROCEDURE generate_xml(PSI_ERRCOD  OUT  VARCHAR2
                      ,PSI_ERRMSG  OUT  VARCHAR2
                      ,PNI_PERSON_ID      IN  NUMBER
                      ,PNI_ASSIGNMENT_ID  IN  NUMBER
                      ,PDI_EFFECTIVE_DATE IN  VARCHAR2
                      ,PSI_DOC_TYPE       IN  VARCHAR2
                      ) IS 

ls_per_doc   clob := '';
BEGIN 

  PSI_ERRCOD := null; 
  PSI_ERRMSG := null;
  
  ls_per_doc := ls_per_doc||'<XXAZOR_PER_DOC>';
  ls_per_doc := ls_per_doc||'</XXAZOR_PER_DOC>';
   

EXCEPTION WHEN OTHERS THEN 
 PSI_ERRCOD := SQLCODE;
 PSI_ERRMSG := SQLERRM; 
 
END generate_xml; 

END XXAZOR_PER_DOCS_PKG; 
/

