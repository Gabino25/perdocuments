DROP VIEW APPS.XXAZOR_PER_ACL_N_V;

/* Formatted on 4/12/2021 9:50:33 PM (QP5 v5.115.810.9015) */
CREATE OR REPLACE FORCE VIEW APPS.XXAZOR_PER_ACL_N_V
(
   CODE_K,
   CODE,
   MEANING
)
AS
   SELECT   UPPER ('POR_PERCEPCIONES_O_DEDUCCIONES') code_k,
            UPPER ('NO_SE_ME_APLICO_UN_DIA_DE_VACACIONES') code,
            REPLACE (INITCAP ('NO_SE_ME_APLICO_UN_DIA_DE_VACACIONES'),
                     '_',
                     ' ')
               meaning
     FROM   DUAL
   UNION
   SELECT   UPPER ('POR_PERCEPCIONES_O_DEDUCCIONES') code_k,
            UPPER ('NO_SE_ME_REALIZO_EL_PAGO_DE:') code,
            REPLACE (INITCAP ('NO_SE_ME_REALIZO_EL_PAGO_DE:'), '_', ' ')
               meaning
     FROM   DUAL
   UNION
   SELECT   UPPER ('POR_PERCEPCIONES_O_DEDUCCIONES') code_k,
            UPPER ('NO_SOLICITE_LA_JUSTIFICACION_DE_UN_DIA') code,
            REPLACE (INITCAP ('NO_SOLICITE_LA_JUSTIFICACION_DE_UN_DIA'),
                     '_',
                     ' ')
               meaning
     FROM   DUAL
   UNION
   SELECT   UPPER ('POR_PERCEPCIONES_O_DEDUCCIONES') code_k,
            UPPER ('NO_SOLICITE_UN_DIA_DE_VACACIONES') code,
            REPLACE (INITCAP ('NO_SOLICITE_UN_DIA_DE_VACACIONES'), '_', ' ')
               meaning
     FROM   DUAL
   UNION
   SELECT   UPPER ('POR_PERCEPCIONES_O_DEDUCCIONES') code_k,
            UPPER ('SE_ME_APLICO_UNA_O_VARIAS_FALTAS') code,
            REPLACE (INITCAP ('SE_ME_APLICO_UNA_O_VARIAS_FALTAS'), '_', ' ')
               meaning
     FROM   DUAL
   UNION
   SELECT   UPPER ('POR_PERCEPCIONES_O_DEDUCCIONES') code_k,
            UPPER ('OMITIERON_JUSTIFICARME_UN_DIA') code,
            REPLACE (INITCAP ('OMITIERON_JUSTIFICARME_UN_DIA'), '_', ' ')
               meaning
     FROM   DUAL;

