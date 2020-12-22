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

import xxazor.oracle.apps.per.documents.server.AclControlsVORowImpl;
import xxazor.oracle.apps.per.documents.server.DocumentsAMImpl;

/**
 * Controller for ...
 */
public class AclaracionesCO extends OAControllerImpl
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
    documentsAM.initControls();
    /*
    if(null!=webBean.findChildRecursive("HijoRL")){
        webBean.findChildRecursive("HijoRL").setRendered(false);
    }
    if(null!=webBean.findChildRecursive("NietoRL")){
         webBean.findChildRecursive("NietoRL").setRendered(false);
     }
     */
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
    System.out.println("strEventParam:"+strEventParam);
    DocumentsAMImpl documentsAM = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
    OAMessageChoiceBean oAMessageChoiceBean = null; 
    AclControlsVORowImpl aclControlsVORowImpl = (AclControlsVORowImpl)documentsAM.getAclControlsVO1().first();
    if(null==aclControlsVORowImpl){
     return;
    }
    
    if("PadreEvt".equals(strEventParam)){
        aclControlsVORowImpl.setHijo("Y");
        oAMessageChoiceBean = (OAMessageChoiceBean)webBean.findChildRecursive("padre"); 
        String strPadre = oAMessageChoiceBean.getSelectionText(pageContext);
        System.out.println(oAMessageChoiceBean.getText(pageContext));
        System.out.println(oAMessageChoiceBean.getValue(pageContext));
        System.out.println(oAMessageChoiceBean.getSelectionText(pageContext));
        oAMessageChoiceBean = (OAMessageChoiceBean)webBean.findChildRecursive("hijo"); 
        oAMessageChoiceBean.setPrompt(strPadre);
    }else if("HijoEvt".equals(strEventParam)){
        aclControlsVORowImpl.setNieto("Y");
        oAMessageChoiceBean = (OAMessageChoiceBean)webBean.findChildRecursive("hijo"); 
        String strHijo  = oAMessageChoiceBean.getSelectionText(pageContext);
        oAMessageChoiceBean = (OAMessageChoiceBean)webBean.findChildRecursive("nieto"); 
        oAMessageChoiceBean.setPrompt(strHijo);
    }
    
  }

}
