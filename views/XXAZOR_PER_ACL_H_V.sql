 CREATE OR REPLACE VIEW XXAZOR_PER_ACL_H_V AS 
 select upper('ACLARACIONES_NOMINA') code_k, upper('FONACOT') code, REPLACE(INITCAP('FONACOT'),'_',' ') meaning from dual
 union select upper('ACLARACIONES_NOMINA') code_k, upper('CREDENCIALES_Y_PERMISOSOS_DE_ACCEOS') code, REPLACE(INITCAP('CREDENCIALES_Y_PERMISOSOS_DE_ACCEOS'),'_',' ') meaning from dual
 union select upper('ACLARACIONES_NOMINA') code_k, upper('ISPT') code, REPLACE(INITCAP('ISPT'),'_',' ') meaning from dual
 union select upper('ACLARACIONES_NOMINA') code_k, upper('POR_PERCEPCIONES_O_DEDUCCIONES') code, REPLACE(INITCAP('POR_PERCEPCIONES_O_DEDUCCIONES'),'_',' ') meaning from dual
 