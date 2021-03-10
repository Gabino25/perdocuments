
DECLARE

BEGIN
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/DocumentTypesRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/PayEmpRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/PayPeriodsRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/PayrollsRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/PySrsAssetRunRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/PySrsConsolidationSetRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/lov/webui/PySrsElementSetPayrollRN'); 
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolicitudPG');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolicitudesMgrPG');  
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/AclaracionesPG');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/AclaracionesMgrPG');  
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/AclrStackLayRN');
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/SolDocStackLayRN');  
    jdr_utils.deleteDocument('/xxazor/oracle/apps/per/documents/webui/GeneracionTimbresPG');
   commit;
   /********************************************************************/
 exception when others then 
  dbms_output.put_line('sqlerrm'||sqlerrm||','||sqlcode); 
END;