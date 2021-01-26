DECLARE 
  RetVal VARCHAR2(32767);
  PAIT RAW(32767);

BEGIN 
  -- PAIT := NULL;  Modify the code to initialize this parameter
  PAIT := utl_encode.base64_encode(utl_raw.cast_to_raw('Archivo de texto inteligente'));
  RetVal := APPS.XXAZOR_SDGS12_PKG.GENERARECIBOWSBYTEFULL ( PAIT );
  DBMS_OUTPUT.PUT_LINE('RetVal:'||RetVal);
END; 