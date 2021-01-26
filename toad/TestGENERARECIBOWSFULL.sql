/** NO APLICA WS CON RFC**/
DECLARE 
  RetVal VARCHAR2(32767);
  P1 CLOB;
  P2 VARCHAR2(32767);

BEGIN 
  P1 := to_clob('ARCHIVO');
  P2 := 'RFC';

  RetVal := APPS.XXAZOR_PER_SDG_PKG.GENERARECIBOWSFULL ( pATI => P1 /** IN CLOB **/
                                                       , pRFC => P2 /** VARCHAR2 **/
                                                        );
  dbms_output.put_line('RetVal:'||RetVal);
  COMMIT; 
END;