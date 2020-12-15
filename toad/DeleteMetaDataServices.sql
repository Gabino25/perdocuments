
DECLARE
BEGIN
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolicitudPG');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolicitudesMgrPG');  
   commit;
   /********************************************************************/
 exception when others then 
  dbms_output.put_line('sqlerrm'||sqlerrm||','||sqlcode); 
END;