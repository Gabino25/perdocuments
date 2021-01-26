/** NO APLICA WS CON RFC **/
DECLARE 
  RetVal LONG RAW;
  PATI LONG RAW;
  PRFC VARCHAR2(32767);

BEGIN 
  -- PATI := NULL;  Modify the code to initialize this parameter
  PATI := utl_encode.base64_encode(utl_raw.cast_to_raw('Archivo de texto inteligente'));
  PRFC := 'RFC';
 
  RetVal := APPS.XXAZOR_PER_SDG_PKG.GENERARECIBOWSBYTEFULL (pATI  => PATI  /** IN LONG RAW **/
                                                           ,PRFC  => PRFC  /** IN VARCHAR2 **/
                                                           );
  COMMIT; 
  dbms_output.put_line('RetVal:'||RetVal);
END; 



