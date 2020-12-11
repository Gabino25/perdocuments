/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package xxazor.oracle.apps.per.documents.webui;

import java.io.ByteArrayInputStream;

import java.io.ByteArrayOutputStream;

import java.io.IOException;

import java.sql.SQLException;

import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import oracle.apps.fnd.common.AppsContext;
import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.server.OADBTransactionImpl;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;

import xxazor.oracle.apps.per.documents.server.DocumentsAMImpl;
import oracle.apps.xdo.XDOException;
import oracle.apps.xdo.oa.schema.server.TemplateHelper;

import oracle.cabo.ui.data.DataObject;

import xxazor.oracle.apps.per.documents.server.PerDocsVORowImpl;
import xxazor.oracle.apps.per.documents.utils.Utils;

/**
 * Controller for ...
 */
public class SolicitudesMgrCO extends OAControllerImpl
{
  public static final String RCS_ID="$Header$";
  public static final boolean RCS_ID_RECORDED =
        VersionInfo.recordClassVersion(RCS_ID, "%packagename%");

  /**
   * Layout and page setup logic for a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
   private DocumentsAMImpl  documentsAMImpl; 
  public void processRequest(OAPageContext pageContext, OAWebBean webBean)
  {
    super.processRequest(pageContext, webBean);
    documentsAMImpl = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
    documentsAMImpl.getPerDocsVO1().executeQuery();
    
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
    if("generarEvt".equals(strEventParam)){
      String strRecDocId =  pageContext.getParameter("pRecDocId");
        System.out.println("strRecDocId:"+strRecDocId);
      oracle.jbo.domain.Number numRecDocId;
        int loginID = pageContext.getLoginId();
        int userID  = pageContext.getUserId();
        try {
            numRecDocId = new oracle.jbo.domain.Number(strRecDocId);
            String strGetVal = documentsAMImpl.generateReqDoc(numRecDocId,userID,loginID);
            if(null!=strGetVal){
                throw new OAException(strGetVal,OAException.INFORMATION); 
            }
        } catch (SQLException e) {
            throw new OAException(e.toString(),OAException.ERROR);
        }
      return; 
    }  
      if("RevisarDocumentoEvt".equals(strEventParam)){
          String strRecDocId =  pageContext.getParameter("pReqDocId");
          System.out.println("strRecDocId:"+strRecDocId);
          String rowReference = pageContext.getParameter(EVENT_SOURCE_ROW_REFERENCE);
          PerDocsVORowImpl row = documentsAMImpl.getPerDocsRowById(rowReference);
          DataObject sessionDictionary = (DataObject)pageContext.getNamedDataObject("_SessionParameters");
          HttpServletResponse response = (HttpServletResponse)sessionDictionary.selectValue(null,"HttpServletResponse");
          String contentDisposition = "attachment;filename="+row.getDocType()+"_"+row.getId()+".rtf";
          response.setHeader("Content-Disposition",contentDisposition);
          response.setContentType("application/rtf");
          ServletOutputStream os=null;
         
              String strXML = "";
              System.out.println("Llamar executeMypGetInfo.");
              strXML = documentsAMImpl.getXmlDocByReqId(strRecDocId);
              System.out.println("strXML:"+strXML);
              try {
                  os = response.getOutputStream();
                  byte[] aByte = strXML.getBytes();
                  ByteArrayInputStream inputStream = new ByteArrayInputStream(aByte);
                  ByteArrayOutputStream rtfFile = new ByteArrayOutputStream();
                  AppsContext appsContext = ((OADBTransactionImpl)documentsAMImpl.getOADBTransaction()).getAppsContext();
                  Locale locale = ((OADBTransactionImpl)documentsAMImpl.getOADBTransaction()).getUserLocale();
                  TemplateHelper.processTemplate(appsContext, 
                                                 Utils.strShortApplication,//XxGQRecibosConstants.XXGQ_APP_SHORT_CUSTOM, 
                                                 "XXAZOR_PER_DOCS", 
                                                 locale.getLanguage(), 
                                                 locale.getCountry(), 
                                                 inputStream, 
                                                 TemplateHelper.OUTPUT_TYPE_RTF, 
                                                  null, 
                                                 rtfFile);

                                      byte[] b = rtfFile.toByteArray();
                                      response.setContentLength(b.length);
                                      os.write(b, 0, b.length);
                                      os.flush();
                                      os.close();
                 
              } catch (IOException e) {
                 throw new OAException("IOException al obtener el ServletOutputStream.",OAException.ERROR); 
              } catch (SQLException e) {
                  throw new OAException("SQLException al obtener el DataTemplate.",OAException.ERROR);
              } catch (XDOException e) {
                  throw new OAException("XDOException al obtener el DataTemplate.",OAException.ERROR);
              }
              return;
          } /** END  if("RevisarDocumentoEvt".equals(strEventParam)){ **/
          
  }

}
