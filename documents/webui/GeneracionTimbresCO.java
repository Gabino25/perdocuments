/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package xxazor.oracle.apps.per.documents.webui;

import java.io.File;

import java.io.FileInputStream;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;

import org.tempuri.ServiceDeGeneracionSoap12Client;

import xxazor.oracle.apps.per.documents.server.DocumentsAMImpl;
import xxazor.oracle.apps.per.documents.server.GenTimControlsVOImpl;
import xxazor.oracle.apps.per.documents.server.GenTimControlsVORowImpl;
import xxazor.oracle.apps.per.documents.server.PayExecutionsVOImpl;

/**
 * Controller for ...
 */
public class GeneracionTimbresCO extends OAControllerImpl
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
    DocumentsAMImpl am = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
    GenTimControlsVOImpl genTimControlsVOImpl =  am.getGenTimControlsVO1();  
    System.out.println("genTimControlsVOImpl.isPreparedForExecution():"+genTimControlsVOImpl.isPreparedForExecution());
    if(!genTimControlsVOImpl.isPreparedForExecution()){
        genTimControlsVOImpl.executeQuery();
        GenTimControlsVORowImpl genTimControlsVORowImpl = (GenTimControlsVORowImpl)genTimControlsVOImpl.first();
        genTimControlsVORowImpl.setPeriodo("N");
        genTimControlsVORowImpl.setConsultaBtn("N");
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
    System.out.println("strEventParam:"+strEventParam);
    DocumentsAMImpl am = (DocumentsAMImpl)pageContext.getApplicationModule(webBean);
    GenTimControlsVOImpl genTimControlsVOImpl =  am.getGenTimControlsVO1();  
    GenTimControlsVORowImpl genTimControlsVORowImpl = (GenTimControlsVORowImpl)genTimControlsVOImpl.first();
    PayExecutionsVOImpl payExecutionsVOImpl = am.getPayExecutionsVO1();    
    if(pageContext.isLovEvent()){
        String lovInputSourceId = pageContext.getLovInputSourceId();  
        System.out.println("lovInputSourceId:"+lovInputSourceId);
        if(this.LOV_UPDATE.equals(strEventParam)&&"PayrollName".equals(lovInputSourceId)){
          String strPayrollIdFV = pageContext.getParameter("PayrollIdFV");
          System.out.println("strPayrollIdFV:"+strPayrollIdFV);
          genTimControlsVORowImpl.setPeriodo("Y");
          genTimControlsVORowImpl.setConsultaBtn("Y");
        }
    }
    if("ConsultarEvt".equals(strEventParam)){
        String strPayrollIdFV = pageContext.getParameter("PayrollIdFV");
        String strBusinessGroupIdFV = pageContext.getParameter("BusinessGroupIdFV");
        String strTimePeriodIdFV = pageContext.getParameter("TimePeriodIdFV");
        payExecutionsVOImpl.filter(strPayrollIdFV,strBusinessGroupIdFV,strTimePeriodIdFV);
    }
    /** 
    File file = new File("C:\\Users\\Dell\\Downloads\\ATI_ACOSTA_CORDOBA_JESUS_JAVIER.txt");
    byte[] bytes = readContentIntoByteArray(file);
    String strGetval = ServiceDeGeneracionSoap12Client.generaReciboWSByte(bytes);
    System.out.println(strGetval);
    **/
  }
  
    private static byte[] readContentIntoByteArray(File file)
       {
          FileInputStream fileInputStream = null;
          byte[] bFile = new byte[(int) file.length()];
          try
          {
             //convert file into array of bytes
             fileInputStream = new FileInputStream(file);
             fileInputStream.read(bFile);
             fileInputStream.close();
             for (int i = 0; i < bFile.length; i++)
             {
                System.out.print((char) bFile[i]);
             }
          }
          catch (Exception e)
          {
             e.printStackTrace();
          }
          return bFile;
       }

}
