CREATE OR REPLACE PACKAGE APPS.XXAZOR_PAY_ATI_PKG AUTHID CURRENT_USER AS
/* $Header: XXAZOR_PAY_ATI_PKG.pks 1.0 2020/09/24 12:00:00 pkm ship    $ */
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
   Concurrente Program: Package que contiene la logica generar el ATI del Timbraoo de Nomina

   Description : Package include All procedures and functions for generate Layout ATI
   Uses        :
   Change List
   -----------
   Date        Name     Vers   Bug No  Description Email
   ----        ----     ----   ------  ----------- ------------
   24-SEP-2020 Aisidoro 1.0            Created     angeljr.isidoro@grupoisigo.com.mx

   *******************************************************************/

   PROCEDURE MAIN (
                   pso_error_status         out varchar2
                  ,pso_error_msg            out varchar2
                  ,pni_business_group_id    in number
                  ,pni_payroll_id           in number
                  ,pni_time_period_id       in number
                  ,pni_payroll_action_id    in number
                  ,pni_assignment_id        in number
                  );
   PROCEDURE Populate_ATI_1
                  (
                   pni_business_group_id    in number
                  ,pni_payroll_id           in number
                  ,pni_time_period_id       in number
                  ,pni_payroll_action_id    in number
				  ,pni_assignment_id        in number
                  );
END XXAZOR_PAY_ATI_PKG;
/

