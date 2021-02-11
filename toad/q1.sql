XXAZOR_PAY_ATI_PKG

SELECT  per.employee_number 
        ,per.full_name 
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
        ,asg.business_group_id   
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