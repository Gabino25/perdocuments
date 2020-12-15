CREATE OR REPLACE PACKAGE APPS.XXAZOR_PER_DOCS_PKG AS
 
gs_carta_laboral VARCHAR2(2000) := 'CARTA_LABORAL';
gs_carta_patronal VARCHAR2(2000) := 'CARTA_PATRONAL';
gs_carta_ingresos VARCHAR2(2000) := 'CARTA_INGRESOS';

gs_open  varchar2(200) := 'ABIERTA';
gs_close varchar2(200) := 'CERRADA';

PROCEDURE generate_request(PSI_ERRCOD         OUT VARCHAR2
                          ,PSI_ERRMSG         OUT VARCHAR2
                          ,PNI_PERSON_ID      IN  NUMBER
                          ,PNI_ASSIGNMENT_ID  IN  NUMBER
                          ,PDI_EFFECTIVE_DATE IN  DATE
                          ,PSI_DOC_TYPE       IN  VARCHAR2
                          ,PNI_APPROVER_ID    IN  NUMBER
                          ,PNI_USER_ID        IN  NUMBER
                          ,PNI_LOGIN_ID       IN  NUMBER
                          );
                          
PROCEDURE generate_xml(PSI_ERRCOD         OUT VARCHAR2
                      ,PSI_ERRMSG         OUT VARCHAR2
                      ,PNI_REQUEST_ID     IN  NUMBER
                      ,PNI_USER_ID        IN  NUMBER
                      ,PNI_LOGIN_ID       IN  NUMBER
                       );

PROCEDURE get_xml(PSO_XMLDOC         OUT CLOB
                 ,PNI_REQUEST_ID     IN  NUMBER
                  );                       
END XXAZOR_PER_DOCS_PKG; 
/

