CREATE OR REPLACE PACKAGE BODY APPS.XXAZOR_SDGS12_PKG
AS
   FUNCTION generaReciboWSByte (
      pAIT   IN            RAW
   )
      RETURN VARCHAR2
   AS
      LANGUAGE JAVA
      NAME 'xxazor.oracle.per.ws.ServiceDeGeneracionSoap12Client.generaReciboWSByte(byte[]) return java.lang.String';

   FUNCTION generaReciboWSByteFull (
      pAIT   IN            RAW
   )
      RETURN VARCHAR2
   AS
      LANGUAGE JAVA
      NAME 'xxazor.oracle.per.ws.ServiceDeGeneracionSoap12Client.generaReciboWSByteFull(byte[]) return java.lang.String';
END XXAZOR_SDGS12_PKG; 
/

