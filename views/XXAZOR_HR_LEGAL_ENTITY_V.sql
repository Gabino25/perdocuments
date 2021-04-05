DROP VIEW APPS.XXAZOR_HR_LEGAL_ENTITY_V;

/* Formatted on 4/4/2021 8:49:13 PM (QP5 v5.115.810.9015) */
CREATE OR REPLACE FORCE VIEW APPS.XXAZOR_HR_LEGAL_ENTITY_V
(
   LEGAL_ENTITY,
   ORGANIZATION_LE_ID,
   GRE,
   ORGANIZATION_GRE_ID,
   RAZON_SOCIAL,
   RFC_LEGAL_ENTITY,
   REG_IMSS_GRE,
   ZONA_ECONOMICA,
   BUSINESS_GROUP_ID,
   LE_LOCATION_ID,
   GRE_LOCATION_ID,
   LE_REGIMEN_FISCAL
)
AS
   SELECT   org_le.name legal_entity,
            hn_le.entity_id organization_le_id,
            org_gre.name gre,
            hn_gre.entity_id organization_gre_id,
            oi_le.org_information1 razon_social,
            oi_le.org_information2 rfc_legal_entity,
            oi_gre.org_information1 reg_imss_gre,
            oi_gre.org_information7 zona_economica,
            org_le.business_group_id,
            org_le.location_id le_location_id,
            org_gre.location_id gre_location_id,
            oi_le.org_information9 le_regimen_fiscal
     FROM   hr_all_organization_units org_le,
            per_gen_hierarchy_nodes hn_le,
            hr_all_organization_units org_gre,
            per_gen_hierarchy_nodes hn_gre,
            hr_organization_information oi_le,
            hr_organization_information oi_gre
    WHERE       org_le.organization_id = hn_le.entity_id
            AND hn_le.node_type = 'MX LEGAL EMPLOYER'
            AND oi_le.organization_id = org_le.organization_id
            AND oi_le.org_information_context = 'MX_TAX_REGISTRATION'
            AND TO_CHAR (org_gre.organization_id) = hn_gre.entity_id
            AND hn_gre.node_type = 'MX GRE'
            AND hn_gre.parent_hierarchy_node_id = hn_le.hierarchy_node_id
            AND oi_gre.organization_id = org_gre.organization_id
            AND oi_gre.org_information_context = 'MX_SOC_SEC_DETAILS';

