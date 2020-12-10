DROP VIEW APPS.XXAZOR_PER_CARTA_LABORAL_V;

CREATE OR REPLACE FORCE VIEW APPS.XXAZOR_PER_CARTA_LABORAL_V AS
   SELECT   per.person_id,
            asg.assignment_id,
            per.employee_number,
            per.original_date_of_hire fecha_contratacion,
            baja.actual_termination_date fecha_baja,
            per.full_name,
            pos.name,
            pos.position_id
     FROM   per_people_f per,
            per_assignments_f asg,
            per_positions pos,
            per_periods_of_service_v baja
    WHERE       per.person_id = asg.person_id
            AND per.business_group_id = asg.business_group_id
            AND asg.position_id = pos.position_id
            AND per.person_id = baja.person_id
            --and   per.employee_number  = '2408'
            AND SYSDATE BETWEEN per.effective_start_date
                            AND  per.effective_end_date
            AND SYSDATE BETWEEN asg.effective_start_date
                            AND  asg.effective_end_date
            AND baja.date_start >=
                  (SELECT   MAX (pofser.date_start)
                     FROM   per_periods_of_service_v pofser
                    WHERE   pofser.person_id = per.person_id
                            AND pofser.business_group_id =
                                  per.business_group_id)

