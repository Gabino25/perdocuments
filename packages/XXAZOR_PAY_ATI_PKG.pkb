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

   PROCEDURE print_line (psi_message in varchar2) IS
      BEGIN
         fnd_file.put(fnd_file.output,psi_message);
         fnd_file.new_line(fnd_file.output,1);
		 fnd_file.put_line(fnd_file.log,psi_message);
		 dbms_output.put_line(psi_message);
         exception when others then
            return;
   END print_line;

   FUNCTION get_days_paid ( pcn_defined_balance_id  in number
                           ,pcn_assig_action_id     in number
                           )
   RETURN number
   IS
   ln_days_paid  number:= 0;
   BEGIN
      ln_days_paid := NVL(PAY_BALANCE_PKG.get_value(pcn_defined_balance_id,pcn_assig_action_id),0);
   EXCEPTION WHEN OTHERS THEN
      ln_days_paid:=0;
   END get_days_paid;

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
                  ,pni_payroll_action_id    in number
                  ,pni_assignment_id        in number
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
	  print_line('Inicia proceso:'||ln_request_id||','||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));

      --se quita desde aqui
      /*FOR j IN gcur_payroll_actions(pni_business_group_id,pni_org_le_id) LOOP
          ls_payroll_id_string := ls_payroll_id_string||j.payroll_id||',';
      END LOOP;


      ls_payroll_id_string := substr(ls_payroll_id_string,1,(length(ls_payroll_id_string)-1));
      ls_payroll_id_string := '('||ls_payroll_id_string||')';
      ls_action_type       := '('''||REPLACE('R,B,Q',',',''',''')||''')';

      print_line('ID Nominas a procesar, ls_payroll_id_string:'||ls_payroll_id_string||',ls_action_type:'||ls_action_type);

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
				  ,pni_payroll_action_id    => pni_payroll_action_id
                  ,pni_assignment_id        => pni_assignment_id
                  );

      print_line('Fin proceso:'||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));
      pso_error_status := null;
      pso_error_msg    := null;

   EXCEPTION WHEN OTHERS THEN
      rollback;
      print_line('XXAZOR_PAY_ATI_PKG.Main(1) Error:'||sqlerrm);

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
                  ,pni_payroll_action_id    in number
                  ,pni_assignment_id        in number
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

   CURSOR cur_employee(pcn_bd_id             number
                      ,pcn_payroll_id        number
					  ,pcn_time_period_id    number
					  ,pcn_payroll_action_id number
					  ,pcn_assignment_id     number
                      )
   IS
   SELECT per.employee_number
        ,paa.assignment_action_id
        ,asg.organization_id
        ,paa.tax_unit_id
        ,paa.assignment_id
        ,ppa.payroll_action_id
        ,ppa.effective_date
        ,ppa.date_earned
        ,to_number(to_char(ppa.date_earned,'YYYY'))   year
        ,to_number(to_char(ppa.date_earned,'MM'))     mes
        ,to_char(ppa.date_earned,'DDMMYYYY')||ROWNUM  numeroRecibo
        ,ptp.period_num                               numReciboMes
        ,'DEL '||to_char(ptp.start_date,'YYYY/MM/DD')||' AL '||to_char(ptp.end_date,'YYYY/MM/DD') periodo
        ,ptp.start_date
        ,ptp.end_date
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
   WHERE  ppa.payroll_action_id     = paa.payroll_action_id
   AND    paa.assignment_id         = asg.assignment_id
   AND    asg.person_id             = per.person_id
   AND    asg.business_group_id     = per.business_group_id
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
   AND    paa.assignment_id         = NVL(pcn_assignment_id,paa.assignment_id)
   AND    ppa.payroll_action_id     = pcn_payroll_action_id;

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

   ln_indice          number := 0;
   ls_line_name       varchar2(8000);
   ln_fixed_idw     number:= 0;
   ln_variable_idw  number:= 0;
   ln_idw           number:= 0;
   ln_days_paid     number:= 0;
   BEGIN

      -- compute_statistics;
      /*
      ld_fecha_ini_TA := fnd_date.canonical_to_date(psi_fecha_ini_TA);
      ld_fecha_fin_TA := fnd_date.canonical_to_date(psi_fecha_fin_TA);
      ld_fecha_ini_SI := fnd_date.canonical_to_date(psi_fecha_ini_SI);
      ld_fecha_fin_SI := fnd_date.canonical_to_date(psi_fecha_fin_SI);
      */

      fnd_profile.get('CONC_REQUEST_ID',ln_request_id);
      print_line('Inicia proceso:'||ln_request_id||','||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));

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
         print_line('No existen columnas a imprimir.');
         return;
      END IF;
      IF ltt_ati_1_column.count > 0 THEN
         print_line('Columna Inicio:'||ltt_ati_1_column.first);
         print_line('Columna Fin:'||ltt_ati_1_column.last);
         FOR r in 1..ltt_ati_1_column.count LOOP
            --ls_line_name := ltt_ati_1_column(r).lookup_code||'|'||ls_line_name;
			ls_line_name := ltt_ati_1_column(r).meaning;
			print_line('ls_line_name:'||ls_line_name);
         END LOOP;
      END IF;
      FOR j IN cur_employee(pni_business_group_id,pni_payroll_id,pni_time_period_id,pni_payroll_action_id,pni_assignment_id)
	  LOOP
	     ln_days_paid := NVL(get_days_paid(gn_defined_balance_id,j.assignment_action_id),0);

         BEGIN
            ln_idw:= PAY_MX_SOC_SEC_ARCHIVE.get_idw( p_assignment_id  => j.assignment_id
                                                    ,p_tax_unit_id    => j.tax_unit_id
                                                    ,p_effective_date => j.effective_date
                                                    ,p_fixed_idw      => ln_fixed_idw    -- OUT NOCOPY NUMBER
                                                    ,p_variable_idw   => ln_variable_idw -- OUT NOCOPY NUMBER
				                                    );

         EXCEPTION WHEN OTHERS THEN
            ln_idw := 0;
			 print_line('Error obtener IDW:'||sqlerrm);
         END;
	  END LOOP;


      print_line('Fin proceso:'||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'));

   EXCEPTION WHEN OTHERS THEN

      print_line('XXAZOR_PAY_ATI_PKG.Populate_ATI_1 Error:'||sqlerrm);

   END Populate_ATI_1;


END XXAZOR_PAY_ATI_PKG;
/

