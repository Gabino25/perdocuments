/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package xxazor.oracle.apps.per.documents.webui;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;

import oracle.apps.fnd.framework.webui.beans.message.OAMessageChoiceBean;

import xxazor.oracle.apps.per.documents.server.DocumentTypesVOImpl;
import xxazor.oracle.apps.per.documents.server.DocumentsAMImpl;

/**
 * Controller for ...
 */
public class SolicitudCO extends OAControllerImpl
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
    System.out.println("Entra SolicitudCO");
    DocumentsAMImpl  documentsAMImpl = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
    OAMessageChoiceBean poplistBean = (OAMessageChoiceBean)webBean.findChildRecursive("item1");  
    poplistBean.setPickListCacheEnabled(false);  
    int userId = pageContext.getUserId();
    documentsAMImpl.filterUserInfo(userId);
   
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
  }

}
