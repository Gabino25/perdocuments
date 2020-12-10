CREATE OR REPLACE PACKAGE APPS.XXAZOR_PER_DOCS_PKG AS 
PROCEDURE generate_xml(PSI_ERRCOD         OUT VARCHAR2
                      ,PSI_ERRMSG         OUT VARCHAR2
                      ,PNI_PERSON_ID      IN  NUMBER
                      ,PNI_ASSIGNMENT_ID  IN  NUMBER
                      ,PDI_EFFECTIVE_DATE IN  VARCHAR2
                      ,PSI_DOC_TYPE       IN  VARCHAR2
                       );
END XXAZOR_PER_DOCS_PKG; 
/

