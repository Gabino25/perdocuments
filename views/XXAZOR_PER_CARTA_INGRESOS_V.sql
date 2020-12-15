DROP VIEW APPS.XXAZOR_PER_CARTA_INGRESOS_V;

/* Formatted on 15/12/2020 09:55:11 a. m. (QP5 v5.115.810.9015) */
CREATE OR REPLACE FORCE VIEW APPS.XXAZOR_PER_CARTA_INGRESOS_V
(
   PERSON_ID,
   ASSIGNMENT_ID,
   EMPLOYEE_NUMBER,
   FECHA_CONTRATACION,
   FECHA_BAJA,
   FULL_NAME,
   NAME,
   SUELDO_MENSUAL,
   POSITION_ID,
   RFC_EMP,
   NSS_EMP,
   DIRECCION_EMPLEADO,
   RAZON_SOCIAL,
   DIRECCION_EMPLEADOR_LEGAL,
   RFC_LEGAL_ENTITY,
   REG_IMSS_GRE
)
AS
   SELECT   UNIQUE
            (per.person_id) person_id,
            asg.assignment_id,
            per.employee_number,
            per.original_date_of_hire fecha_contratacion,
            baja.actual_termination_date fecha_baja,
            per.full_name,
            pos.name,
            (SELECT   s.proposed_salary_n
               FROM   per_pay_proposals_v2 s
              WHERE   asg.assignment_id = s.assignment_id
                      AND s.change_date >=
                            (SELECT   MAX (s2.change_date)
                               FROM   per_pay_proposals_v2 s2
                              WHERE   s.assignment_id = s2.assignment_id
                                      AND s.business_group_id =
                                            s2.business_group_id))
               sueldo_mensual,
            pos.position_id,
            per.per_information2 RFC_EMP,
            per.per_information3 NSS_EMP,
               ad.address_line1
            || ' '
            || ad.address_line2
            || ' '
            || ad.region_2
            || ' '
            || ad.town_or_city
            || ' '
            || ad.postal_code
            || ' '
            || ad.d_country
               direccion_empleado,
            le.razon_social,
               loc.address_line_1
            || ' '
            || loc.address_line_2
            || ' '
            || loc.region_2
            || ' '
            || loc.region_1
            || ' '
            || loc.postal_code
               direccion_empleador_legal,
            le.rfc_legal_entity,
            le.reg_imss_gre
     FROM   per_people_f per,
            per_assignments_f asg,
            per_positions pos,
            per_periods_of_service_v baja,
            per_addresses_v ad,
            hr_locations loc,
            hr_soft_coding_keyflex soft,
            xxazor_hr_legal_entity_v le
    WHERE       per.person_id = asg.person_id
            AND per.business_group_id = asg.business_group_id
            AND asg.position_id = pos.position_id
            AND asg.soft_coding_keyflex_id = soft.soft_coding_keyflex_id(+)
            AND soft.segment1 = le.organization_gre_id(+)
            AND le.le_location_id = loc.location_id(+)
            AND per.person_id = baja.person_id
            AND per.person_id = ad.person_id(+)
            AND per.business_group_id = ad.business_group_id(+)
            --and   ad.primary_flag       = 'Y'
            --and   ad.style          = 'MX'
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
                                  per.business_group_id);

