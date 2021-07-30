APPS.XXAZOR_PAY_TE_PKG

/* Formatted on 7/21/2021 2:39:30 PM (QP5 v5.115.810.9015) */
CREATE TABLE tmp_2107201_1724
AS
   SELECT   a.VALUE,
            s.username,
            s.sid,
            s.serial#
     FROM   v$sesstat a, v$statname b, v$session s
    WHERE       a.statistic# = b.statistic#
            AND s.sid = a.sid
            AND b.name = 'opened cursors current'
            AND s.username IS NOT NULL;  


select * from tmp_2107201_1438            

select * from tmp_2107201_1442;

DROP TABLE tmp_2107201_1442;

DROP TABLE tmp_2107201_1438; 

DROP TABLE tmp_2107201_1653;

APPS.XXAZOR_PAY_TE_PKG.GENERATE_ATI


select * from XXAZOR_PAY_TE
order by creation_date desc


 select sid from (
 SELECT   a.VALUE,
            s.username,
            s.sid,
            s.serial#
     FROM   v$sesstat a, v$statname b, v$session s
    WHERE       a.statistic# = b.statistic#
            AND s.sid = a.sid
            AND b.name = 'opened cursors current'
            AND s.username IS NOT NULL
  MINUS 
  SELECT value
        ,username
        ,sid
        ,serial#
    from tmp_2107201_1653
    )
    
    
    SID



    
    select  * from v$open_cursor
  where sql_text like '%XXAZOR%'
    order by LAST_SQL_ACTIVE_TIME desc
    
    BEGIN    APPS.XXAZOR_PAY_TE_PKG.GENERATE_ATI (PSI_ERRCOD    
    
    
    
     select  * from v$open_cursor
     where sid in ( select sid from (
 SELECT   a.VALUE,
            s.username,
            s.sid,
            s.serial#
     FROM   v$sesstat a, v$statname b, v$session s
    WHERE       a.statistic# = b.statistic#
            AND s.sid = a.sid
            AND b.name = 'opened cursors current'
            AND s.username IS NOT NULL
  MINUS 
  SELECT value
        ,username
        ,sid
        ,serial#
    from tmp_2107201_1724
    )
   )
  and SQL_TEXT LIKE '%XXAZOR_PAY_TE_PKG%'
    