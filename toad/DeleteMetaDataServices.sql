
DECLARE

BEGIN
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolicitudPG');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolicitudesMgrPG');  
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/AclaracionesPG');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/AclaracionesMgrPG');  
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/AclrStackLayRN');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolDocStackLayRN');  
   commit;
   /********************************************************************/
 exception when others then 
  dbms_output.put_line('sqlerrm'||sqlerrm||','||sqlcode); 
END;