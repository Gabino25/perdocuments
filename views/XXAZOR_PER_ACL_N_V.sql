 CREATE OR REPLACE VIEW XXAZOR_PER_ACL_N_V AS 
 select upper('POR_PERCEPCIONES_O_DEDUCCIONES') code_k, upper('NO_SE_ME_APLICO_UN_DIA_DE_VACACIONES') code,  REPLACE(INITCAP('NO_SE_ME_APLICO_UN_DIA_DE_VACACIONES'),'_',' ') meaning from dual
 union select upper('POR_PERCEPCIONES_O_DEDUCCIONES') code_k, upper('NO_SE_ME_REALIZO_EL_PAGO_DE:') code,  REPLACE(INITCAP('NO_SE_ME_REALIZO_EL_PAGO_DE:'),'_',' ') meaning from dual
 union select upper('POR_PERCEPCIONES_O_DEDUCCIONES') code_k, upper('NO_SOLICITE_LA_JUSTIFICACION_DE_UN_DIA') code,  REPLACE(INITCAP('NO_SOLICITE_LA_JUSTIFICACION_DE_UN_DIA'),'_',' ') meaning from dual
 union select upper('POR_PERCEPCIONES_O_DEDUCCIONES') code_k, upper('NO_SOLICITE_UN_DIA_DE_VACACIONES') code,  REPLACE(INITCAP('NO_SOLICITE_UN_DIA_DE_VACACIONES'),'_',' ') meaning from dual
 union select upper('POR_PERCEPCIONES_O_DEDUCCIONES') code_k, upper('SE_ME_APLICO_UNA_O_VARIAS_FALTAS') code,  REPLACE(INITCAP('SE_ME_APLICO_UNA_O_VARIAS_FALTAS'),'_',' ') meaning from dual
 union select upper('POR_PERCEPCIONES_O_DEDUCCIONES') code_k, upper('OMITIERON_JUSTIFICARME_UN_DIA') code,  REPLACE(INITCAP('OMITIERON_JUSTIFICARME_UN_DIA'),'_',' ') meaning from dual
 