/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package xxazor.oracle.apps.per.documents.webui;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;

import oracle.apps.fnd.framework.webui.beans.message.OAMessageTextInputBean;

import oracle.apps.fnd.framework.webui.beans.nav.OAButtonBean;

import xxazor.oracle.apps.per.documents.server.DocumentsAMImpl;

/**
 * Controller for ...
 */
public class AclrStackLayCO extends OAControllerImpl
{
  public static final String RCS_ID="$Header$";
  public static final boolean RCS_ID_RECORDED =
        VersionInfo.recordClassVersion(RCS_ID, "%packagename%");

  /**
   * Layout and page setup logic for a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
  public void processRequest(OAPageContext pageContext, OAWebBean webBean)
  {
    super.processRequest(pageContext, webBean);
    DocumentsAMImpl documentsAM = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
    String strAclarId = pageContext.getParameter("pAclarId");
    if(null!=strAclarId&&!"".equals(strAclarId)){
        documentsAM.filterAclarInfoPersistent(strAclarId);
    }
    String strpReOn = pageContext.getParameter("pReOn");
    if("Y".equals(strpReOn)){
       OAMessageTextInputBean NotaApproverBean = (OAMessageTextInputBean)webBean.findChildRecursive("NotaApprover");
       if(null!=NotaApproverBean){
           NotaApproverBean.setReadOnly(true);
       }
       OAButtonBean UpdateBtnBean = (OAButtonBean)webBean.findChildRecursive("UpdateBtn");
       if(null!=UpdateBtnBean){
           UpdateBtnBean.setRendered(false);
       }
    }
      
  }

  /**
   * Procedure to handle form submissions for form elements in
   * a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
  public void processFormRequest(OAPageContext pageContext, OAWebBean webBean)
  {
    super.processFormRequest(pageContext, webBean);
    String strEventParam = pageContext.getParameter(this.EVENT_PARAM);
    if("UpdateEvt".equals(strEventParam)){
        DocumentsAMImpl documentsAM = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
        documentsAM.getOADBTransaction().commit();
        throw new OAException("Se guardo la nota",OAException.INFORMATION);
    }  
  }

}
