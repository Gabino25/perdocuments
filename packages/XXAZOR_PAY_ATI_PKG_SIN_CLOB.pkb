CREATE OR REPLACE PACKAGE BODY APPS.XXAZOR_PAY_ATI_PKG AS
/* $Header: XXAZOR_PAY_ATI_PKG.pkb 1.0 2020/10/13 12:00:00 pkm ship    $ */
/*
   ******************************************************************
   *                                                                *
   *  Copyright (C) 2001 Oracle Corporation.                        *
   *  All rights reserved.                                          *
   *                                                                *
   *  This material has been provided pursuant to an agreement      *
   *  containing restrictions on its use.  The material is also     *
   *  protected by copyright law.  No part of this material may     *
   *  be copied or distributed, transmitted or transcribed, in      *
   *  any form or by any means, electronic, mechanical, magnetic,   *
   *  manual, or otherwise, or disclosed to third parties without   *
   *  the express written permission of Oracle Corporation,         *
   *  500 Oracle Parkway, Redwood City, CA, 94065.                  *
   *                                                                *
   ******************************************************************
   Name        : XXAZOR_PAY_ATI_PKG
   Description : Package que contiene la logica generar el ATI del Timbraoo de Nomina.
   Uses        :
   Change List
   -----------
   Date        Name     Vers   Bug No  Description Email
   ----        ----     ----   ------  ----------- ------------
   24-AGO-2020 Aisidoro 1.0            Created     angeljr.isidoro@grupoisigo.com.mx
   *******************************************************************/

    -- Define Global Variable
   gn_hilos_action      number := 4;
   gn_bg_id             number := 0;
   gn_registro_patronal number := 0;
   gn_period_time_id_fin number:= 0;



   --ls_query1               varchar2(8000);
   --ls_payroll_id_string    varchar2(2000);
   --ls_action_type          varchar2(30);

   gn_defined_balance_id     number := 0;

   CURSOR gcur_def_balance_id(pcs_balance_name varchar2
                             ,pcs_item_suffix  varchar2
                            )
   IS
   SELECT defined_balance_id
   FROM   pay_defined_balances
   WHERE  balance_type_id = (SELECT balance_type_id
                             FROM   pay_balance_types
                             WHERE  UPPER (balance_name) =  UPPER (pcs_balance_name)
							 )
   AND balance_dimension_id = (SELECT balance_dimension_id
                               FROM   pay_balance_dimensions
                               WHERE  UPPER (database_item_suffix) = UPPER (pcs_item_suffix)
                               AND legislation_code = 'MX'
							   );

   PROCEDURE print_line (psi_type_msg in varchar2
                        ,psi_message  in varchar2) IS
      BEGIN
	     IF psi_type_msg = 'OUTPUT' THEN
            fnd_file.put(fnd_file.output,psi_message);
            fnd_file.new_line(fnd_file.output,1);
		 ELSIF  psi_type_msg = 'LOG' THEN
		    fnd_file.put_line(fnd_file.log,psi_message);
		    --dbms_output.put_line(psi_message);
		 END IF;
      EXCEPTION WHEN OTHERS THEN
            return;
      END print_line;

   FUNCTION get_days_paid ( p_defined_balance_id   in number
                           ,p_assignment_action_id in number
                           )
   RETURN number
   IS
   ln_days_paid  number:= 0;
   p_payroll_id  number;
   ls_error      varchar2(2000);

   BEGIN
      /*
      insert into AZOR_HR_DEBUG_PROCESS
	  values(1,'p_defined_balance_id:'||p_defined_balance_id||',p_assignment_action_id:'||p_assignment_action_id,sysdate);
	  commit;
	  */
	  -- begin
       hr_util_misc_web.insert_session_row(sysdate);
      --end;



      PAY_BALANCE_PKG.set_context ('ASSIGNMENT_ACTION_ID', p_assignment_action_id);
      PAY_BALANCE_PKG.set_context ('PAYROLL_ID', p_payroll_id);


      SELECT value
	  INTO   ln_days_paid
	  FROM   pay_balance_values_v
      where  assignment_action_id = p_assignment_action_id
      and    defined_balance_id   = p_defined_balance_id;


      --ln_days_paid := NVL(PAY_BALANCE_PKG.get_value(p_defined_balance_id,p_assignment_action_id),0);

   EXCEPTION WHEN OTHERS THEN
      print_line('LOG','Error dias de pago:'||ln_days_paid);
      ln_days_paid:=0;
   END get_days_paid;

   PROCEDURE get_time_marcajes ( pdi_dateLogTime     in  date
                                ,pni_payroll_id      in  number
					            ,pni_time_period_id  in  number
					            ,pni_person_id       in  number
                                ,pso_mananaentrada   out varchar2
                                ,pso_mananasalida    out varchar2
                                ,pso_tardeentrada    out varchar2
                                ,pso_tardesalida     out varchar2
                                ,pso_textra          out varchar2
                           )
   IS
   CURSOR cur_marcajes2( pcd_dateLogTime     date
                        ,pcn_payroll_id      number
					    ,pcn_time_period_id  number
					    ,pcn_person_id       number
                       )
   IS
   select trunc(dateLogTime)  dateLogTime
          ,b.slogtime
          ,b.hrLogTime
          ,per.person_id
          ,per.employee_number
          ,asg.assignment_id
          ,asg.payroll_id
          ,ptp.time_period_id
		  ,substr(b.slogtime,12,2) hra
   from   azor_pay_marcajes_v b
         ,per_people_f        per
         ,per_assignments_f   asg
         ,per_time_periods    ptp
   where per.employee_number = b.NUSERID
   and   per.person_id       = asg.person_id
   and   ptp.payroll_id      = asg.payroll_id
   and   trunc(dateLogTime) between ptp.start_date and ptp.end_date
   and   trunc(dateLogTime) between per.effective_start_date and per.effective_end_date
   and   trunc(dateLogTime) between asg.effective_start_date and asg.effective_end_date
   -- and   trunc(dateLogTime)  = pdi_dateLogTime
   and   per.person_id       = pcn_person_id
   and   asg.payroll_id      = pcn_payroll_id
   and   ptp.time_period_id  = pcn_time_period_id
   order by dateLogTime asc;

   ln_days_paid  number:= 0;
   p_payroll_id  number;
   ls_error      varchar2(2000);
   ls_mananaentrada  varchar2(10):=null;
   ls_mananasalida   varchar2(10):=null;
   ls_tardeentrada   varchar2(10):=null;
   ls_tardesalida    varchar2(10):=null;
   ls_textra         varchar2(10):=null;

   BEGIN
       FOR j IN cur_marcajes2( pdi_dateLogTime, pni_payroll_id,pni_time_period_id,pni_person_id) LOOP
	      IF j.hra between 05 and 10 THEN
		     ls_mananaentrada:= j.hrLogTime;
		  ELSIF j.hra between 15 and 23 THEN
		     ls_tardesalida:= j.hrLogTime;
		  END IF;
		  pso_mananaentrada  := ls_mananaentrada;
          pso_mananasalida   := ls_mananasalida;
          pso_tardeentrada   := ls_tardeentrada;
          pso_tardesalida    := ls_tardesalida;
          pso_textra         := ls_textra;
       END LOOP;


   EXCEPTION WHEN OTHERS THEN
      print_line('LOG','Error get_time_marcajes:'||ln_days_paid);
          pso_mananaentrada  := ls_mananaentrada;
          pso_mananasalida   := ls_mananasalida;
          pso_tardeentrada   := ls_tardeentrada;
          pso_tardesalida    := ls_tardesalida;
          pso_textra         := ls_textra;
   END get_time_marcajes;

   /******************************************************
   Procedure : Main
   Scope:      Local
   Author:     Angel Isidoro angel.isidoro@grupoisigo.com.mx
   Description: Main Procedure to call others procedure and functions
   ******************************************************/
   PROCEDURE MAIN (
                   pso_error_status         out varchar2
                  ,pso_error_msg            out varchar2
                  ,pni_business_group_id    in number
                  ,pni_payroll_id           in number
                  ,pni_time_period_id       in number
                  ,pni_consolidation_set_id IN NUMBER
                  ,pni_element_set_id       IN NUMBER
                  ,pni_assignment_set_id    IN NUMBER
                  ,pni_person_id            in number
                  )
             IS


   ln_request_id          number:=0;
   --ld_fecha_corte         date;
   --ls_error               varchar2(4000);
   --ln_cuenta              number:=0;
   --ln_threads             number;
   --ls_period_name         per_time_periods.period_name%type;
   --lcur_reg_patronal      gcur_reg_patronal%rowtype;
   --ln_submit_id           number:=0;
   --ln_request_id2         number:=0;
   ln_request_id3         number:=0;
   --ln_request_id4         number:=0;
   --lb_add_layout          boolean;
   --ls_x                   varchar2(1) default null;
   --ld_change_date         date;
   ld_fecha_ini           date;
   ld_fecha_fin           date;

    -- Variables temporales borrar
   --pni_payroll_id         number;
   --psi_ruta               varchar2(300);
   --psi_genera_archivo     varchar2(300);
   --pni_pay_action_id_ajuste number;
   --ln_valida_ajuste_anual   number:=0;


   BEGIN

      -- compute_statistics;

     -- ld_fecha_ini := fnd_date.canonical_to_date(psi_fecha_ini);
     -- ld_fecha_fin := fnd_date.canonical_to_date(psi_fecha_fin);

      fnd_profile.get('CONC_REQUEST_ID',ln_request_id);
      --fnd_file.put_line(fnd_file.output,'Inicia proceso:'||ln_request_id||','||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));
	  print_line('LOG','Inicia proceso:'||ln_request_id||','||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));

      --se quita desde aqui
      /*FOR j IN gcur_payroll_actions(pni_business_group_id,pni_org_le_id) LOOP
          ls_payroll_id_string := ls_payroll_id_string||j.payroll_id||',';
      END LOOP;


      ls_payroll_id_string := substr(ls_payroll_id_string,1,(length(ls_payroll_id_string)-1));
      ls_payroll_id_string := '('||ls_payroll_id_string||')';
      ls_action_type       := '('''||REPLACE('R,B,Q',',',''',''')||''')';

      print_line('LOG','ID Nominas a procesar, ls_payroll_id_string:'||ls_payroll_id_string||',ls_action_type:'||ls_action_type);

      ls_Query1 := ' SELECT  paa.assignment_action_id';
      ls_Query1 := ls_Query1 ||' ,paa.assignment_id';
      ls_Query1 := ls_Query1 ||' ,ppa.payroll_action_id';
      ls_Query1 := ls_Query1 ||' ,ppa.effective_date';
      ls_Query1 := ls_Query1 ||' ,ppa.date_earned';
      ls_Query1 := ls_Query1 ||' ,ppa.payroll_id';
      ls_Query1 := ls_Query1 ||' ,ppa.time_period_id';
      ls_Query1 := ls_Query1 ||' ,paa.tax_unit_id';
      ls_Query1 := ls_Query1 ||' ,ppa.run_type_id           ppa_run_type_id';
      ls_Query1 := ls_Query1 ||' ,paa.run_type_id           paa_run_type_id';
      ls_Query1 := ls_Query1 ||' ,ppa.consolidation_set_id';
      ls_Query1 := ls_Query1 ||' ,ppa.element_set_id';
      ls_Query1 := ls_Query1 ||' ,ppa.assignment_set_id';
      ls_Query1 := ls_Query1 ||' ,(select unique(asg.person_id)';
      ls_Query1 := ls_Query1 ||'   from   per_assignments_f asg';
      ls_Query1 := ls_Query1 ||'   where  asg.assignment_id = paa.assignment_id) person_id';
      ls_Query1 := ls_Query1 ||' FROM   pay_assignment_actions paa';
      ls_Query1 := ls_Query1 ||'       ,pay_payroll_actions    ppa';
      ls_Query1 := ls_Query1 ||' WHERE  ppa.payroll_action_id    =  paa.payroll_action_id';
      ls_Query1 := ls_Query1 ||' AND    ppa.action_type          IN '||ls_action_type;
      ls_Query1 := ls_Query1 ||' AND    ppa.action_status        =  ''C''';
      ls_Query1 := ls_Query1 ||' AND    ppa.business_group_id    =  '||pni_business_group_id;
      ls_Query1 := ls_Query1 ||' AND    ppa.payroll_id           IN '||ls_payroll_id_string;
      ls_Query1 := ls_Query1 ||' AND    ppa.effective_date       >= '||''''||ld_fecha_ini||''''||' and ppa.effective_date <= '||''''||ld_fecha_fin||'''';

      Fnd_File.put_line(Fnd_File.output,'ls_Query1:'||ls_Query1);*/
      ---asta aqui-----
     Populate_ATI_1
                  (
                   pni_business_group_id    => pni_business_group_id
                  ,pni_payroll_id           => pni_payroll_id
                  ,pni_time_period_id       => pni_time_period_id
				  ,pni_consolidation_set_id => pni_consolidation_set_id
                  ,pni_element_set_id       => pni_element_set_id
                  ,pni_assignment_set_id    => pni_assignment_set_id
                  ,pni_person_id            => pni_person_id
                  );

      print_line('LOG','Fin proceso:'||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));
      pso_error_status := null;
      pso_error_msg    := null;

   EXCEPTION WHEN OTHERS THEN
      rollback;
      print_line('LOG','XXAZOR_PAY_ATI_PKG.Main(1) Error:'||sqlerrm);

      pso_error_status := sqlerrm;
      pso_error_msg    := sqlerrm;
   END MAIN;


   /******************************************************
   Procedure :  Populate_ATI_1
   Scope:       Local
   Author:      Angel Isidoro angel.isidoro@grupoisigo.com.mx
   Description: Populate_ATI_1 Procedure to call others procedure and functions
    *****************************************************/
  PROCEDURE Populate_ATI_1
                  (
                   pni_business_group_id    in number
                  ,pni_payroll_id           in number
                  ,pni_time_period_id       in number
                  ,pni_consolidation_set_id IN NUMBER
                  ,pni_element_set_id       IN NUMBER
                  ,pni_assignment_set_id    IN NUMBER
                  ,pni_person_id            in number
                  )
             IS


   ln_request_id          number:=0;
   ln_request_id3         number:=0;
   ld_fecha_ini_TA        date;
   ld_fecha_fin_TA        date;
   ld_fecha_ini_SI        date;
   ld_fecha_fin_SI        date;

   CURSOR cur_balance
   IS
   SELECT defined_balance_id
   FROM   pay_defined_balances
   WHERE  balance_type_id = (SELECT balance_type_id
                             FROM   pay_balance_types
                             WHERE  UPPER (balance_name) =  UPPER ('Days Basis of Quotation 1')
							)
   AND balance_dimension_id = (SELECT balance_dimension_id
                               FROM  pay_balance_dimensions
                               WHERE UPPER (database_item_suffix) = UPPER ('_ASG_RUN')
                               AND legislation_code = 'MX'
							   );


   ln_def_bal_id  NUMBER:=0;

   CURSOR cur_marcajes( pcn_payroll_id      number
					   ,pcn_time_period_id  number
					   ,pcn_person_id       number
					   )
   IS
   SELECT trunc(b.datelogtime) datelogtime
   from   azor_pay_marcajes_v b
         ,per_people_f        per
         ,per_assignments_f   asg
         ,per_time_periods    ptp
   where per.employee_number = b.NUSERID(+)
   and   per.person_id       = asg.person_id
   and   ptp.payroll_id      = asg.payroll_id
   and   ptp.time_period_id = pcn_time_period_id
   and   trunc(dateLogTime) between ptp.start_date and ptp.end_date
   and   trunc(dateLogTime) between per.effective_start_date and per.effective_end_date
   and   trunc(dateLogTime) between asg.effective_start_date and asg.effective_end_date
   and   per.person_id = pcn_person_id
   and   asg.payroll_id = pcn_payroll_id
   group by trunc(dateLogTime)
   order by 1 asc;

   CURSOR cur_per(pcn_assignment_action_id    number)
   IS
   SELECT   (TO_NUMBER (NVL (TRUNC (prrv.result_value, 2), 0),'99999999999999.99')) percepciones
          ,petf.element_name    element_per
          ,petf.attribute3 clave_per
            FROM     pay_run_results prr
                    ,pay_run_result_values prrv
                    ,pay_element_types_f petf
                    ,pay_input_values_f pivf
                    ,pay_element_classifications cla
            WHERE    prr.element_type_id = petf.element_type_id
            AND      prr.run_result_id = prrv.run_result_id
            AND      prrv.input_value_id = pivf.input_value_id
            AND      UPPER(pivf.NAME) IN ('PAY VALUE','VALOR PAGO')
            and      petf.classification_id = cla.classification_id
            and      cla.classification_name in ('Amends','Earnings','Supplemental Earnings','Tax Credit','')
            and      petf.element_name not like '%AJUSTE%'
            and      prr.assignment_action_id = pcn_assignment_action_id;

    CURSOR cur_ded(pcn_assignment_action_id    number)
    IS
    SELECT    (TO_NUMBER (NVL (TRUNC (prrv.result_value, 2), 0),'99999999999999.99')) deducciones
                    ,petf.element_name   element_ded
                    ,decode(petf.element_name,'ISR','002','Social Security Quota Calculation EE','001',petf.attribute3) clave_ded
    FROM     pay_run_results prr
                    ,pay_run_result_values prrv
                    ,pay_element_types_f petf
                    ,pay_input_values_f pivf
                    ,pay_element_classifications cla
            WHERE    prr.element_type_id = petf.element_type_id
            AND      prr.run_result_id = prrv.run_result_id
            AND      prrv.input_value_id = pivf.input_value_id
            AND      UPPER(pivf.NAME) IN ('PAY VALUE','VALOR PAGO')
            and      petf.classification_id = cla.classification_id
            and      cla.classification_name in ('Involuntary Deductions','Tax Deductions','Voluntary Deductions')
            and      petf.element_name not like '%AJUSTE%'
            and      prr.assignment_action_id = pcn_assignment_action_id;

   CURSOR cur_employee(pcn_bd_id             number
                      ,pcn_payroll_id        number
					  ,pcn_time_period_id    number
					  ,pcn_pconsolidation_set_id number
					  ,pcn_element_set_id    number
					  ,pcn_assignment_set_id number
					  ,pcn_person_id     number
                      )
   IS
   SELECT per.employee_number
        ,per.full_name
        ,replace(per.per_information2,'-')    rfc
        ,replace(per.per_information3,'-')    no_imss
        ,per.national_identifier curp
		,per.email_address
        ,per.original_date_of_hire
        ,paa.assignment_action_id
        ,asg.organization_id
		,org.name        departamento
		,pos.name        position_name
        ,paa.tax_unit_id
        ,paa.assignment_id
        ,ppa.payroll_action_id
        ,ppa.effective_date
		,round((ptp.end_date-original_date_of_hire)/48,2) antiguedadporsemana
        ,to_char(ppa.date_earned,'yyyy-mm-dd') fechaLiquidacion
        ,to_number(to_char(ppa.date_earned,'YYYY'))   year
        ,to_number(to_char(ppa.date_earned,'MM'))     mes
        ,to_char(ppa.date_earned,'DDMMYYYY')          numeroRecibo
        ,ptp.period_num                               numReciboMes
        ,'DEL '||to_char(ptp.start_date,'YYYY/MM/DD')||' AL '||to_char(ptp.end_date,'YYYY/MM/DD') periodo
        ,to_char(ptp.start_date,'YYYY/MM/DD') fechainicialpago
        ,to_char(ptp.end_date,'YYYY/MM/DD')   fechafinalpago
		,(ptp.end_date - ptp.start_date)+1    diasTrabajados
		,to_char(ptp.start_date,'DD')         iniciadel
		,to_char(ptp.start_date,'MM')         iniciames
		,to_char(ptp.end_date,'DD')           final
		,to_char(ptp.end_date,'MM')           finmes
		,to_char(ptp.end_date,'YYYY')         finyear
        ,ppa.payroll_id
        ,ppa.time_period_id
        ,ppa.run_type_id           ppa_run_type_id
        ,paa.run_type_id           paa_run_type_id
        ,ppa.consolidation_set_id
        ,ppa.element_set_id
        ,ppa.assignment_set_id
        ,per.person_id
   FROM   pay_assignment_actions paa
       ,pay_payroll_actions    ppa
       ,pay_run_types_f        prtf
       ,per_assignments_f      asg
       ,per_people_f           per
       ,per_time_periods       ptp
	   ,hr_all_organization_units org
	   ,per_positions          pos
   WHERE  ppa.payroll_action_id     = paa.payroll_action_id
   AND    paa.assignment_id         = asg.assignment_id
   AND    asg.person_id             = per.person_id
   AND    asg.business_group_id     = per.business_group_id
   and    asg.organization_id       = org.organization_id
   and    asg.position_id           = pos.position_id
   AND    ppa.effective_date BETWEEN asg.effective_start_date AND asg.effective_end_date
   AND    ppa.effective_date BETWEEN per.effective_start_date AND per.effective_end_date
   AND    ppa.time_period_id        = ptp.time_period_id
   AND    ppa.payroll_id            = ptp.payroll_id
   AND    paa.run_type_id           = prtf.run_type_id
   AND    upper(prtf.run_type_name) = upper('Standard')
   AND    prtf.legislation_code     = 'MX'
   AND    ppa.action_type           IN ('R','B','Q')
   AND    ppa.action_status         = 'C'
   AND    ppa.business_group_id     = pcn_bd_id
   AND    ppa.payroll_id            = pcn_payroll_id
   AND    ppa.time_period_id        = pcn_time_period_id
   AND    per.person_id             = NVL(pcn_person_id,per.person_id)
   AND    ppa.consolidation_set_id  = NVL(pcn_pconsolidation_set_id,ppa.consolidation_set_id)
   AND    ppa.element_set_id        = NVL(pcn_element_set_id,ppa.element_set_id)
   AND    ppa.assignment_set_id     = NVL(pcn_assignment_set_id,ppa.assignment_set_id);

   CURSOR cur_ATI_1
   IS
   select lookup_code
         ,meaning
         ,description
   from  hr_lookups
   where lookup_type  = 'AZOR_PAY_ATI_CFDI'
   order by to_number(lookup_code) asc;

   type tt_ati_1       is table of cur_ATI_1%rowtype     index by binary_integer;
   ltrow_ati_1_column  cur_ATI_1%rowtype;
   ltt_ati_1_column    tt_ati_1;

   ln_indice            number := 0;
   ls_line_name         varchar2(8000);
   ln_fixed_idw         number:= 0;
   ln_variable_idw      number:= 0;
   ln_idw               number:= 0;
   ln_days_paid         number:= 0;
   ln_cuenta            number:= 0;
   ln_sueldo_diario     number:= 0;
   ln_totalPercepciones number:= 0;
   ln_totalDeducciones  number:= 0;
   ln_totalDescuentos   number:= 0;
   ls_postal_code       varchar2(12)  := NULL;
   ls_num_cta_emp       varchar2(30)  := NULL;
   ls_clave_banco       varchar2(6)   := NULL;
   ls_clabe             varchar2(18)  := NULL;
   ls_payroll_name      pay_payrolls_f.payroll_name%TYPE;
   ls_periodicidadpago  varchar2(4)   := NULL;
   ls_razon_social      varchar2(100) := NULL;
   ls_rfc_legal_entity  varchar2(30) := NULL;
   ls_reg_imss_gre      varchar2(30) := NULL;
   ls_le_regimen_fiscal varchar2(5)  := NULL;
   ls_gre_calle         varchar2(60)   := null;
   ls_gre_colonia       varchar2(50)   := null;
   ls_gre_alcaldia      varchar2(50)   := null;
   ls_gre_ciudad        varchar2(50)   := null;
   ls_gre_cp            varchar2(50)    := null;
   ls_gre_code_mx       varchar2(50)   := null;
   ls_gre_telefono      varchar2(50)   := null;
   ls_mananaentrada  varchar2(10):=null;
   ls_mananasalida   varchar2(10):=null;
   ls_tardeentrada   varchar2(10):=null;
   ls_tardesalida    varchar2(10):=null;
   ls_textra         varchar2(10):=null;
   BEGIN

      -- compute_statistics;
      /*
      ld_fecha_ini_TA := fnd_date.canonical_to_date(psi_fecha_ini_TA);
      ld_fecha_fin_TA := fnd_date.canonical_to_date(psi_fecha_fin_TA);
      ld_fecha_ini_SI := fnd_date.canonical_to_date(psi_fecha_ini_SI);
      ld_fecha_fin_SI := fnd_date.canonical_to_date(psi_fecha_fin_SI);
      */

      fnd_profile.get('CONC_REQUEST_ID',ln_request_id);
      --print_line('LOG','Inicia proceso:'||ln_request_id||','||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));

      -- Get Define Balance ID
      OPEN  gcur_def_balance_id('Days Basis of Quotation 1','_ASG_RUN');
	  FETCH gcur_def_balance_id INTO gn_defined_balance_id;
      CLOSE gcur_def_balance_id;

	  OPEN cur_ATI_1;
      LOOP
         FETCH cur_ATI_1 into ltrow_ati_1_column;
         EXIT when cur_ATI_1%NOTFOUND;

         ln_indice := ln_indice +1;
         ltt_ati_1_column(ln_indice) := ltrow_ati_1_column;
      END LOOP;
      CLOSE cur_ATI_1;

	  IF ltt_ati_1_column.count = 0  THEN
         print_line('LOG','No existen columnas a imprimir.');
         return;
      END IF;
	  /*
      IF ltt_ati_1_column.count > 0 THEN
         print_line('LOG','Columna Inicio:'||ltt_ati_1_column.first);
         print_line('LOG','Columna Fin:'||ltt_ati_1_column.last);
		 print_line('LOG','Count:'||ltt_ati_1_column.count);
         FOR r in 1..ltt_ati_1_column.last LOOP
            --ls_line_name := ltt_ati_1_column(r).lookup_code||'|'||ls_line_name;
			ls_line_name := ltt_ati_1_column(r).lookup_code||':'||ltt_ati_1_column(r).meaning;
			print_line('LOG','ls_line_name:'||ls_line_name);
         END LOOP;

      END IF;
	  */

      FOR j IN cur_employee(pni_business_group_id,pni_payroll_id,pni_time_period_id,pni_consolidation_set_id,pni_element_set_id,pni_assignment_set_id,pni_person_id)
	  LOOP
	     --ln_days_paid := NVL(get_days_paid(gn_defined_balance_id,j.assignment_action_id),0);
		 -- ln_days_paid := NVL(get_days_paid(gn_defined_balance_id,j.assignment_id,j.effective_date),0);
         ln_days_paid := 15; --NVL(get_days_paid(771,7691),0);
		 ln_cuenta := ln_cuenta + 1;
		 IF ltt_ati_1_column.count = 0  THEN
            print_line('LOG','No existen columnas a imprimir.');
            return;
         END IF;
		 BEGIN
		    SELECT   SUM (TO_NUMBER (NVL (TRUNC (prrv.result_value, 2), 0),'99999999999999.99')) percepciones
            INTO	 ln_totalPercepciones
            FROM     pay_run_results prr
                    ,pay_run_result_values prrv
                    ,pay_element_types_f petf
                    ,pay_input_values_f pivf
                    ,pay_element_classifications cla
            WHERE    prr.element_type_id = petf.element_type_id
            AND      prr.run_result_id = prrv.run_result_id
            AND      prrv.input_value_id = pivf.input_value_id
            AND      UPPER(pivf.NAME) IN ('PAY VALUE','VALOR PAGO')
            and      petf.classification_id = cla.classification_id
            and      cla.classification_name in ('Amends','Earnings','Supplemental Earnings','Tax Credit','')
            and      prr.assignment_action_id = j.assignment_action_id;
	     EXCEPTION WHEN OTHERS THEN
            ln_totalPercepciones := 0;
			print_line('LOG','Error obtener ln_totalPercepciones:'||sqlerrm);
		 END;
         BEGIN
		    SELECT   SUM (TO_NUMBER (NVL (TRUNC (prrv.result_value, 2), 0),'99999999999999.99')) deducciones
            INTO	 ln_totalDeducciones
            FROM     pay_run_results prr
                    ,pay_run_result_values prrv
                    ,pay_element_types_f petf
                    ,pay_input_values_f pivf
                    ,pay_element_classifications cla
            WHERE    prr.element_type_id = petf.element_type_id
            AND      prr.run_result_id = prrv.run_result_id
            AND      prrv.input_value_id = pivf.input_value_id
            AND      UPPER(pivf.NAME) IN ('PAY VALUE','VALOR PAGO')
            and      petf.classification_id = cla.classification_id
            and      cla.classification_name in ('Involuntary Deductions','Tax Deductions','Voluntary Deductions')
            and      prr.assignment_action_id = j.assignment_action_id;
	     EXCEPTION WHEN OTHERS THEN
            ln_totalDeducciones := 0;
			print_line('LOG','Error obtener ln_totalDeducciones:'||sqlerrm);
		 END;
		 BEGIN
		    select trunc((ppp.proposed_salary_n/30),2) sueldo_diario
			into   ln_sueldo_diario
            from   per_pay_proposals ppp
           where   ppp.assignment_id = j.assignment_id
             and   ppp.change_date   = (select max(v.change_date )
                                        from per_pay_proposals v
                                       where v.assignment_id = ppp.assignment_id
                                         and v.approved      = 'Y' )
             and ppp.business_group_id = pni_business_group_id
             and ppp.approved          = 'Y';
	     EXCEPTION WHEN OTHERS THEN
            ln_sueldo_diario := 0;
			print_line('LOG','Error obtener ln_sueldo_diario:'||sqlerrm);
		 END;
		 BEGIN
            ln_idw:= PAY_MX_SOC_SEC_ARCHIVE.get_idw( p_assignment_id  => j.assignment_id
                                                    ,p_tax_unit_id    => j.tax_unit_id
                                                    ,p_effective_date => j.effective_date
                                                    ,p_fixed_idw      => ln_fixed_idw    -- OUT NOCOPY NUMBER
                                                    ,p_variable_idw   => ln_variable_idw -- OUT NOCOPY NUMBER
				                                    );
            -- print_line('LOG','IDW:'||ln_idw);
         EXCEPTION WHEN OTHERS THEN
            ln_idw := 0;
			 print_line('LOG','Error obtener IDW:'||sqlerrm);
         END;
		 BEGIN
		    select loc.postal_code
			      ,le.razon_social
				  ,le.rfc_legal_entity
				  ,le.reg_imss_gre
				  ,le_regimen_fiscal
			into ls_postal_code
			    ,ls_razon_social
				,ls_rfc_legal_entity
				,ls_reg_imss_gre
				,ls_le_regimen_fiscal
            from  xxazor_hr_legal_entity_v le
                 ,hr_locations  loc
            where le.le_location_id = loc.location_id
            and   le.organization_le_id = 82; -- Cambiar por parametro dentro del MAIN
		 EXCEPTION WHEN OTHERS THEN
            ls_postal_code := NULL;
			print_line('LOG','Error obtener ls_postal_code:'||sqlerrm);
		 END;

		 BEGIN
		    select    gre.address_line_1
                     ,gre.address_line_2
                     ,gre.region_2
                     ,gre.town_or_city
                     ,gre.postal_code
                     ,gre.telephone_number_1
            into
                    ls_gre_calle
                   ,ls_gre_colonia
                   ,ls_gre_alcaldia
                   ,ls_gre_ciudad
                   ,ls_gre_cp
                   ,ls_gre_telefono
            from   hr_organization_units_v gre
            where  gre.organization_id = 83; -- Cambiar por parametro dentro del MAIN
		 EXCEPTION WHEN OTHERS THEN
            ls_gre_calle := NULL;
			print_line('LOG','Error obtener ls_gre_calle:'||sqlerrm);
		 END;

		 BEGIN
		    select payroll_name
                  ,decode(period_type,'Semi-Month','04','Week','02','Calendar Month','05')  periodicidadpago
			into   ls_payroll_name
			      ,ls_periodicidadpago
            from   pay_payrolls_f
            where payroll_id = pni_payroll_id
			and   j.effective_date between effective_start_date and effective_end_date
            and   business_group_id = pni_business_group_id;
		 EXCEPTION WHEN OTHERS THEN
            ls_payroll_name := NULL;
			print_line('LOG','Error obtener ls_payroll_name:'||sqlerrm);
		 END;

		 begin
			SELECT pea.segment3  cuentabancaria
                  ,substr(meaning,1,4) clave_banco
                  ,pea.segment5	clabe
			into  ls_num_cta_emp
			     ,ls_clave_banco
				 ,ls_clabe
            FROM  PAY_PERSONAL_PAYMENT_METHODS_F pppm
			     ,PAY_EXTERNAL_ACCOUNTS          pea
				 ,PAY_ORG_PAYMENT_METHODS_F      popm
				 ,fnd_lookup_values              lo
            WHERE       1 = 1
            AND pppm.external_account_id = pea.external_account_id(+)
            AND popm.org_payment_method_id(+) = pppm.org_payment_method_id
            AND popm.defined_balance_id IS NOT NULL
            AND j.effective_date BETWEEN popm.effective_start_date AND popm.effective_end_date
            AND j.effective_date BETWEEN pppm.effective_start_date AND pppm.effective_end_date
			and lo.lookup_type = 'MX_BANK'
            and lo.lookup_code = pea.segment1
            AND pea.segment1 IS NOT NULL
            AND ROWNUM = 1
            AND pppm.assignment_id = j.assignment_id;
         exception when others then
			ls_num_cta_emp := NULL;
			ls_clave_banco := NULL;
			print_line('LOG','Error obtener ls_clave_banco:'||sqlerrm);
         end;



	     print_line('OUTPUT','/INICIO');
		 print_line('OUTPUT','/ReciboDeNomina');
		 print_line('OUTPUT',rpad('fechaLiquidacion',75)||j.fechaLiquidacion);                                       -- 2019-01-19
         print_line('OUTPUT',rpad('anio',75)||j.year);                                                               -- 2019
         print_line('OUTPUT',rpad('mes',75)||j.mes);                                                                 -- 1
         print_line('OUTPUT',rpad('numeroRecibo',75)||j.numeroRecibo||ln_cuenta);                                    -- 170302110427410106
         print_line('OUTPUT',rpad('numReciboMes',75)||j.numReciboMes);                                               -- 1
         print_line('OUTPUT',rpad('diasTrabajados',75)||j.diasTrabajados);                                           -- 6
         print_line('OUTPUT',rpad('periodo',75)||j.periodo);                                                         -- DEL 2019/01/14 AL 2019/01/19
         print_line('OUTPUT',rpad('fechainicialpago',75)||j.fechainicialpago);                                       -- 2019-01-14
         print_line('OUTPUT',rpad('fechafinalpago',75)||j.fechafinalpago);                                           -- 2019-01-19
         print_line('OUTPUT',rpad('sueldoDiario',75)||ln_sueldo_diario);                                             -- 7247.64
         print_line('OUTPUT',rpad('totalPercepciones',75)||ln_totalPercepciones);                                    -- 179383.80
         print_line('OUTPUT',rpad('totalDeducciones',75)||ln_totalDeducciones);                                      -- 58783.67
         print_line('OUTPUT',rpad('netoPagado',75)||(ln_totalPercepciones-ln_totalDeducciones));                     -- 120600.13
         print_line('OUTPUT',rpad('totalDescuentos',75)||ln_totalDescuentos);                                        -- 58783.67
         print_line('OUTPUT',rpad('sdi',75)||ln_idw);                                                                -- 7247.64
         print_line('OUTPUT',rpad('salariobasecotapor',75)||ln_sueldo_diario);                                       -- 7247.64
         print_line('OUTPUT',rpad('fecha',75)||to_char(sysdate,'YYYY/MM/DD HH24:MI:SS'));                            -- 2019-01-31T08:39:06
         print_line('OUTPUT',rpad('metododepago',75)||'NA');                                                         -- NA
         print_line('OUTPUT',rpad('lugarexpedicion',75)||ls_postal_code);                                            -- 03810
         print_line('OUTPUT',rpad('tipodecambio',75)||1);                                                            -- 1
         print_line('OUTPUT',rpad('moneda',75)||'MXN');                                                              -- MXN
         print_line('OUTPUT',rpad('cuentabancaria',75)||ls_num_cta_emp);                                             -- 012580012749942802
         print_line('OUTPUT',rpad('tiponomina',75)||'O');                                                            -- O
         print_line('OUTPUT',rpad('totalotrospagos',75)||ln_totalPercepciones);                                      --
         print_line('OUTPUT',rpad('subTotal',75)||ln_totalPercepciones);                                                               -- 179383.80
         print_line('OUTPUT','/ReciboDeNomina/Adicionales');                                                       --
         print_line('OUTPUT',rpad('clavebanco',75)||ls_clave_banco);                                                             --
         print_line('OUTPUT',rpad('departamento',75)||j.departamento);                                                           --
         print_line('OUTPUT',rpad('clabe',75)||ls_clabe);                                                                  --
         print_line('OUTPUT',rpad('nomina',75)||ls_payroll_name);                                                    -- QUINCENAL
         print_line('OUTPUT',rpad('fechainiciorellaboral',75)||to_char(j.original_date_of_hire,'YYYY/MM/DD'));         -- 2014-03-03
         -- print_line('OUTPUT',rpad('antiguedadporsemana',75)||j.antiguedadporsemana);                                 -- P254W (Calculo en Semandas ) Quitar si no aplica. (Angelina)
         print_line('OUTPUT',rpad('tipocontrato',75)||'01');                                                           -- 03
         print_line('OUTPUT',rpad('tipojornada',75)||'08');                                                            -- 01
         print_line('OUTPUT',rpad('periodicidadpago',75)||ls_periodicidadpago);                                                       -- 04
         print_line('OUTPUT',rpad('tipoPago',75)||'001');                                                               -- Pago de nómina
         print_line('OUTPUT',rpad('tipo',75)||'001');                                                                   -- CONFIANZA
         print_line('OUTPUT',rpad('horasExtra',75)||'0.0');                                                             -- 0
         print_line('OUTPUT',rpad('pagoNetoMensual',75)||ln_totalPercepciones);                                                        --
         print_line('OUTPUT',rpad('numCuenta',75)||ls_num_cta_emp);                                                              --
         print_line('OUTPUT',rpad('numeronomina',75)||j.employee_number);                                                           --
         print_line('OUTPUT',rpad('banco',75)||'014');                                                                  --
         print_line('OUTPUT',rpad('pagonetoquincenal',75)||ln_totalPercepciones);                                                      --
         print_line('OUTPUT','/ReciboDeNomina/Patron');                                                 --
         print_line('OUTPUT',rpad('rfc',75)||ls_rfc_legal_entity);                                                                    -- AAA010101AAA
         print_line('OUTPUT',rpad('nombre',75)||ls_razon_social);                                                                 -- Empresa de pruebas SA  de CV
         print_line('OUTPUT',rpad('registropatronal',75)||ls_reg_imss_gre);                                                       -- Y6436441106
         print_line('OUTPUT','/ReciboDeNomina/Patron/Regimenes');                                       --
         print_line('OUTPUT',rpad('regimenfiscal',75)||ls_le_regimen_fiscal);                                                          -- 601
         print_line('OUTPUT','/ReciboDeNomina/Patron/DomicilioFiscal');                                 --
         print_line('OUTPUT',rpad('calle',75)||ls_gre_calle);                                                                  -- INSURGENTES SUR No. Ext. 863 Int. 9
         print_line('OUTPUT',rpad('noExterior',75)||substr(ls_gre_calle,-5));                                                             -- 0
         print_line('OUTPUT',rpad('noInterior',75)||' ');                                                             -- 0
         print_line('OUTPUT',rpad('colonia',75)||ls_gre_colonia);                                                                -- NAPOLES
         print_line('OUTPUT',rpad('localidad',75)||'02');                                                              -- DISTRITO FEDERAL
         print_line('OUTPUT',rpad('referencia',75)||' ');                                                             -- -
         print_line('OUTPUT',rpad('municipio',75)||'002');                                                             -- BENITO JUAREZ
         print_line('OUTPUT',rpad('estado',75)||'DIF');                                                                 -- DISTRITO FEDERAL
         print_line('OUTPUT',rpad('pais',75)||'MEX');                                                                   -- MEXICO
         print_line('OUTPUT',rpad('telefono',75)||ls_gre_telefono);                                                               --
         print_line('OUTPUT',rpad('codigoPostal',75)||ls_gre_cp);                                                           -- 03810
         print_line('OUTPUT','/ReciboDeNomina/Empleado');                                         --
         print_line('OUTPUT',rpad('rfc',75)||j.rfc);                                                                    -- MADC8712145Q7
         print_line('OUTPUT',rpad('imss',75)||j.no_imss);                                                                  -- 01967101659
         print_line('OUTPUT',rpad('nombre',75)||j.full_name);                                                                 -- Empleado de pruebas A
         print_line('OUTPUT',rpad('curp',75)||j.curp);                                                                 -- FOSJ911229HMCNNT09
         print_line('OUTPUT',rpad('correo',75)||j.email_address);                                                                 -- brenda.leon@indiciumsolutions.com.mx
         print_line('OUTPUT',rpad('tiporegimen',75)||'02');                                                            -- 02
         print_line('OUTPUT',rpad('riesgopuesto',75)||'99');                                                           -- 99
         print_line('OUTPUT',rpad('claveentfed',75)||'DIF');                                                            -- DIF
         print_line('OUTPUT',rpad('periodicidadPago',75)||ls_periodicidadpago);                                                       -- 04
         print_line('OUTPUT',rpad('banco',75)||'014');                                                                  --
         print_line('OUTPUT','/ReciboDeNomina/Empleado/Detalle');                                       --
         print_line('OUTPUT',rpad('numero',75)||j.employee_number);                                                                 -- 147281
         print_line('OUTPUT',rpad('puesto',75)||j.position_name);                                                                 -- SAPL 120 LIFE TECH DISTRICT LEADER PL09
        -- print_line('OUTPUT',rpad('nonomina',75)||'');                                                               --
        -- print_line('OUTPUT',rpad('puesto',75)||'');                                                                 --
        -- print_line('OUTPUT',rpad('jefedirecto',75)||'');                                                            --
        -- print_line('OUTPUT',rpad('correojefe',75)||'');                                                            --
         print_line('OUTPUT','/RecibosDeNomina/Conceptos');                                             --
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Percepciones');                                 --
         print_line('OUTPUT',rpad('totalsueldos',75)||ln_totalPercepciones);                                                           -- 179383.80
         print_line('OUTPUT',rpad('totalseparacionindemnizacion',75)||'');                                           -- 0.00
         print_line('OUTPUT',rpad('totaljubilacionpensionretiro',75)||'');                                           -- 0.00
         print_line('OUTPUT',rpad('totalgravado',75)||'');                                                           -- 179383.80
         print_line('OUTPUT',rpad('totalexento',75)||'');                                                            -- 0.00
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Percepciones/Percepcion');                                   --
		 FOR p IN cur_per(j.assignment_action_id) LOOP
		    print_line('OUTPUT',rpad('tipopercepcion',75)||'001');                                                   -- 001
            print_line('OUTPUT',rpad('clave',75)||p.clave_per);                                                      -- 001
            print_line('OUTPUT',rpad('descripcion',75)||p.element_per);                                              -- SUELDO
            print_line('OUTPUT',rpad('importe',75)||p.percepciones);                                                 -- 108714.60
            --print_line('OUTPUT',rpad('importeexento',75)||' ');                                                    -- 0.00
           -- print_line('OUTPUT',rpad('importegravado',75)||' ');                                                   -- 108714.60
		    print_line('OUTPUT','/ReciboDeNomina/Conceptos/Percepciones/Percepcion/AccionesOTitulos');               --
            print_line('OUTPUT',rpad('valormercado',75)||' ');
			print_line('OUTPUT',rpad('precioalotorgarse',75)||' ');                                                  --
		 END LOOP;
         /*
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Percepciones/Percepcion');                                  --
         print_line('OUTPUT',rpad('tipopercepcion',75)||99);                                                         -- 028
         print_line('OUTPUT',rpad('clave',75)||99);                                                                  -- 020
         print_line('OUTPUT',rpad('descripcion',75)||99);                                                            -- COMISIONES
         print_line('OUTPUT',rpad('importe',75)||99);                                                                -- 70669.20
         print_line('OUTPUT',rpad('importeexento',75)||99);                                                          -- 0.00
         print_line('OUTPUT',rpad('importegravado',75)||99);                                                         -- 70669.20
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Percepciones/Percepcion/AccionesOTitulos');     --
         print_line('OUTPUT',rpad('valormercado',75)||99);                                                           --
         print_line('OUTPUT',rpad('precioalotorgarse',75)||99);                                                      --
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/SeparacionIndemnizacion');                      --
         print_line('OUTPUT',rpad('totalpagado',75)||99);                                                            --
         print_line('OUTPUT',rpad('numañosservicio',75)||99);                                                        --
         print_line('OUTPUT',rpad('ultimosueldomensord',75)||99);                                                    --
         print_line('OUTPUT',rpad('ingresoacumulable',75)||99);                                                      --
         print_line('OUTPUT',rpad('ingresonoacumulable',75)||99);                                                    --
		 */
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Deducciones');                                  --
         print_line('OUTPUT',rpad('totalgravado',75)||' ');                                                           -- 58783.67
         print_line('OUTPUT',rpad('totalexento',75)||' ');                                                            -- 0.00
         print_line('OUTPUT',rpad('totalotrasdeducciones',75)||ln_totalDeducciones);                                                  -- 710.08
         print_line('OUTPUT',rpad('totalimpuestosretenidos',75)||' ');                                                -- 58073.59
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Deducciones/Deduccion');                                     --
		 FOR d IN cur_ded(j.assignment_action_id) LOOP
			print_line('OUTPUT',rpad('tipodeduccion',75)||'002');                                                      -- 002
            print_line('OUTPUT',rpad('clave',75)||d.clave_ded);                                                        -- D001
            print_line('OUTPUT',rpad('descripcion',75)||d.element_ded);                                                -- ISR
            print_line('OUTPUT',rpad('importe',75)||d.deducciones);                                                    -- 58073.59
            print_line('OUTPUT',rpad('importeexento',75)||' ');                                                        -- 0.00
            print_line('OUTPUT',rpad('importegravado',75)||' ');
		 END LOOP;
		 /*
         print_line('OUTPUT','/ReciboDeNomina/Conceptos/Deducciones/Deduccion');                        --
         print_line('OUTPUT',rpad('tipodeduccion',75)||99);                                                          -- 001
         print_line('OUTPUT',rpad('clave',75)||99);                                                                  -- D002
         print_line('OUTPUT',rpad('descripcion',75)||99);                                                            -- IMSS
         print_line('OUTPUT',rpad('importe',75)||99);                                                                -- 710.08
         print_line('OUTPUT',rpad('importeexento',75)||99);                                                          -- 0.00
         print_line('OUTPUT',rpad('importegravado',75)||99);                                                         -- 710.08
		 */
         print_line('OUTPUT','/ReciboDeNomina/Leyendas');                                               --
         print_line('OUTPUT',rpad('texto',75)||' ');                                                                  -- Pago Efectivo : $ 120600.13
         print_line('OUTPUT','/ReciboDeNomina/Asistencia');                                             --
         print_line('OUTPUT','/ReciboDeNomina/Asistencia/Periodo');                                     --
         print_line('OUTPUT',rpad('depto',75)||j.departamento);                                                                  --
         print_line('OUTPUT',rpad('semana',75)||j.numReciboMes);                                                                 --
         print_line('OUTPUT',rpad('iniciadel',75)||j.iniciadel);                                                              --
         print_line('OUTPUT',rpad('iniciames',75)||j.iniciames);                                                              --
         print_line('OUTPUT',rpad('final',75)||j.final);                                                                  --
         print_line('OUTPUT',rpad('finmes',75)||j.finmes);                                                                 --
         print_line('OUTPUT',rpad('finaño',75)||j.finyear);                                                                 --

		 FOR k IN cur_marcajes( pni_payroll_id,pni_time_period_id,j.person_id) LOOP
		    get_time_marcajes ( k.dateLogTime
                                ,pni_payroll_id
					            ,pni_time_period_id
					            ,j.person_id
                                ,ls_mananaentrada
                                ,ls_mananasalida
                                ,ls_tardeentrada
                                ,ls_tardesalida
                                ,ls_textra
                             );
		    print_line('OUTPUT','/ReciboDeNomina/Asistencia/Periodo/Detalle');                             --
            print_line('OUTPUT',rpad('fecha',75)||99);                                                                  --
            print_line('OUTPUT',rpad('mañanaentrada',75)||ls_mananaentrada);                                                          --
            print_line('OUTPUT',rpad('mañanasalida',75)||ls_mananasalida);                                                           --
            print_line('OUTPUT',rpad('tardeentrada',75)||ls_tardeentrada);                                                           --
            print_line('OUTPUT',rpad('tardesalida',75)||ls_tardesalida);                                                            --
            print_line('OUTPUT',rpad('textra',75)||ls_textra); 		                                                         --
		 END LOOP;
	     /*
         print_line('OUTPUT','/ReciboDeNomina/Asistencia/Periodo/Detalle');                             --
         print_line('OUTPUT',rpad('fecha',75)||99);                                                                  --
         print_line('OUTPUT',rpad('mañanaentrada',75)||);                                                          --
         print_line('OUTPUT',rpad('mañanasalida',75)||99);                                                           --
         print_line('OUTPUT',rpad('tardeentrada',75)||99);                                                           --
         print_line('OUTPUT',rpad('tardesalida',75)||99);                                                            --
         print_line('OUTPUT',rpad('textra',75)||99); 		                                                         --
		 */
		 print_line('OUTPUT','/FIN');



		 /*

         IF ltt_ati_1_column.count > 0 THEN
            FOR r in 1..ltt_ati_1_column.last LOOP
               --ls_line_name := ltt_ati_1_column(r).lookup_code||'|'||ls_line_name;
               if ltt_ati_1_column(r).meaning = 'fechaLiquidacion'	then
	              ls_line_name := rpad(ltt_ati_1_column(r).meaning,30)||lpad(rpad(j.fechaLiquidacion,15),30);
	              print_line('OUTPUT',ls_line_name);
			   elsif ltt_ati_1_column(r).meaning = 'anio' then
			      ls_line_name := rpad(ltt_ati_1_column(r).meaning,30)||lpad(rpad(j.year,15),30);
				  print_line('OUTPUT',ls_line_name);
			   elsif ltt_ati_1_column(r).meaning = 'mes' then
			      ls_line_name := rpad(ltt_ati_1_column(r).meaning,30)||lpad(rpad(j.mes,15),30);
				  print_line('OUTPUT',ls_line_name);
			   elsif ltt_ati_1_column(r).meaning = 'cuentabancaria' then
			      ls_line_name := rpad(ltt_ati_1_column(r).meaning,30)||lpad(rpad(j.employee_number,15),30);
				  print_line('OUTPUT',ls_line_name);
			   end if;
            END LOOP;
         END IF;
		 */
         BEGIN
            ln_idw:= PAY_MX_SOC_SEC_ARCHIVE.get_idw( p_assignment_id  => j.assignment_id
                                                    ,p_tax_unit_id    => j.tax_unit_id
                                                    ,p_effective_date => j.effective_date
                                                    ,p_fixed_idw      => ln_fixed_idw    -- OUT NOCOPY NUMBER
                                                    ,p_variable_idw   => ln_variable_idw -- OUT NOCOPY NUMBER
				                                    );
            -- print_line('LOG','IDW:'||ln_idw);
         EXCEPTION WHEN OTHERS THEN
            ln_idw := 0;
			 print_line('LOG','Error obtener IDW:'||sqlerrm);
         END;

	  END LOOP;




      print_line('LOG','Fin proceso:'||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));

   EXCEPTION WHEN OTHERS THEN

      print_line('LOG','XXAZOR_PAY_ATI_PKG.Populate_ATI_1 Error:'||sqlerrm);

   END Populate_ATI_1;


END XXAZOR_PAY_ATI_PKG;
/

