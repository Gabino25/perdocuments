CREATE OR REPLACE PACKAGE APPS.XXAZOR_SDGS12_PKG
   AUTHID CURRENT_USER
AS
   FUNCTION generaReciboWSByte (pAIT IN RAW)
      RETURN VARCHAR2;

   FUNCTION generaReciboWSByteFull (pAIT IN RAW)
      RETURN VARCHAR2;
END XXAZOR_SDGS12_PKG; 
/

