package xxazor.oracle.apps.per.documents.server;

import java.io.BufferedReader;
import java.io.IOException;

import java.io.InputStreamReader;

import java.io.Reader;

import java.sql.SQLException;
import java.sql.Types;

import java.util.HashMap;
import java.util.Map;

import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.server.OAApplicationModuleImpl;

import oracle.apps.fnd.framework.server.OADBTransaction;

import oracle.jbo.Key;
import oracle.jbo.RowSetIterator;

import oracle.jbo.domain.Number;

import oracle.jdbc.OracleCallableStatement;

import org.tempuri.ServiceDeGeneracionSoap12Client;

import xxazor.oracle.apps.per.documents.utils.Utils;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class DocumentsAMImpl extends OAApplicationModuleImpl {
    /**This is the default constructor (do not remove)
     */
    public DocumentsAMImpl() {
    }

    /**Sample main for debugging Business Components code using the tester.
     */
    public static void main(String[] args) {
        launchTester("xxazor.oracle.apps.per.documents.server", /* package name */
      "DocumentsAMLocal" /* Configuration Name */);
    }

    /**
    public void initDocumentTypesVO(){
        DocumentTypesVOImpl vo = getDocumentTypesVO1();
        if(!vo.isPreparedForExecution()){
         vo.executeQuery();
        }
        String [][] getval = Utils.getDocuments();
        for(int i=0;i<getval.length;i++){
                System.out.println(getval[i][0]);
                DocumentTypesVORowImpl row = (DocumentTypesVORowImpl)vo.createRow();
                row.setcode(getval[i][0]);
                row.setmeaning(getval[i][1]);
                vo.insertRow(row);
        }
        RowSetIterator iter = vo.createRowSetIterator("");
        while(iter.hasNext()){
          DocumentTypesVORowImpl row = (DocumentTypesVORowImpl)iter.next();
          System.out.println("row.getcode()"+row.getcode());
          System.out.println("row.getmeaning()"+row.getmeaning());
        }
    }
    **/

    /**Container's getter for DocumentTypesVO1
     */
    public DocumentTypesVOImpl getDocumentTypesVO1() {
        return (DocumentTypesVOImpl)findViewObject("DocumentTypesVO1");
    }

    /**Container's getter for UsersInfoVO1
     */
    public UsersInfoVOImpl getUsersInfoVO1() {
        return (UsersInfoVOImpl)findViewObject("UsersInfoVO1");
    }

    public void filterUserInfo(int userId) {
        UsersInfoVOImpl usersInfoVOImpl = getUsersInfoVO1(); 
        usersInfoVOImpl.filterBy(userId);
    }

    public String crearSolicitud(String pDocumentType,String pAprobadorID,int pUserID,int pLoginID) {
        String retval =null;
        UsersInfoVOImpl usersInfoVOImpl = getUsersInfoVO1();
        UsersInfoVORowImpl usersInfoVORowImpl = (UsersInfoVORowImpl)usersInfoVOImpl.getCurrentRow();
        String strCallableStmt = " BEGIN \n" + 
                                 "  APPS.XXAZOR_PER_DOCS_PKG.generate_request ( PSI_ERRCOD             => :1\n" + 
                                 "                                            , PSI_ERRMSG             => :2\n" + 
                                 "                                            , PNI_PERSON_ID          => :3\n" + 
                                 "                                            , PNI_ASSIGNMENT_ID      => :4\n" + 
                                 "                                            , PDI_EFFECTIVE_DATE     => :5\n" + 
                                 "                                            , PSI_DOC_TYPE           => :6\n" +
                                 "                                            , PNI_APPROVER_ID        => :7\n" +
                                 "                                            , PNI_USER_ID            => :8\n" +
                                 "                                            , PNI_LOGIN_ID           => :9\n" +
                                 "                                            );\n" + 
                                 " END; \n";
      OADBTransaction oadbtransaction = (OADBTransaction)this.getTransaction();
      OracleCallableStatement oraclecallablestatement =  (OracleCallableStatement)oadbtransaction.createCallableStatement(strCallableStmt, 1);
        try {
            System.out.println("usersInfoVORowImpl.getFechaSolicitud().dateValue():"+usersInfoVORowImpl.getFechaSolicitud().dateValue());
            oraclecallablestatement.registerOutParameter(1,Types.VARCHAR);
            oraclecallablestatement.registerOutParameter(2,Types.VARCHAR);
            oraclecallablestatement.setDouble(3,usersInfoVORowImpl.getPersonId().doubleValue());
            oraclecallablestatement.setDouble(4,usersInfoVORowImpl.getAssignmentId().doubleValue());
            oraclecallablestatement.setDate(5,usersInfoVORowImpl.getFechaSolicitud().dateValue());
            oraclecallablestatement.setString(6,pDocumentType);
            oraclecallablestatement.setDouble(7,new Double(pAprobadorID));
            oraclecallablestatement.setDouble(8,new Double(pUserID));
            oraclecallablestatement.setDouble(9,new Double(pLoginID));
            oraclecallablestatement.execute();
            retval = oraclecallablestatement.getString(2);
            System.out.println("retval:"+retval);
           
        } catch (SQLException e) {
                   System.out.println("SQLException en el metodo crearSolicitud:"+e.getErrorCode()+", "+e.getMessage());
                   throw new OAException("SQLException en el metodo crearSolicitud:"+e.getErrorCode(),OAException.ERROR); 
       }
       return retval;
    }


    public String filterDocTypes() {
        String retval = null;
        UsersInfoVOImpl usersInfoVOImpl = getUsersInfoVO1();
        UsersInfoVORowImpl usersInfoVORowImpl = (UsersInfoVORowImpl)usersInfoVOImpl.first();
        PerDocsVOImpl perDocsVOImpl = getPerDocsVO1();
        System.out.println("perDocsVOImpl:"+perDocsVOImpl);
        System.out.println("usersInfoVORowImpl:"+usersInfoVORowImpl);
        if(null==usersInfoVORowImpl){
            retval ="No se encontro informacion de empleado";
        }else{
            perDocsVOImpl.filter(usersInfoVORowImpl.getPersonId()
                                ,usersInfoVORowImpl.getAssignmentId());
        }
        return retval;
    }

    /**Container's getter for PerDocsVO1
     */
    public PerDocsVOImpl getPerDocsVO1() {
        return (PerDocsVOImpl)findViewObject("PerDocsVO1");
    }

    public String generateReqDoc(Number numRecDocId,int pUserID,int pLoginID) {
        String retval =null;
        String strCallableStmt = " BEGIN \n" + 
                                 "  APPS.XXAZOR_PER_DOCS_PKG.generate_xml ( PSI_ERRCOD             => :1\n" + 
                                 "                                        , PSI_ERRMSG             => :2\n" + 
                                 "                                        , PNI_REQUEST_ID         => :3\n" + 
                                 "                                        , PNI_USER_ID            => :4\n" +
                                 "                                        , PNI_LOGIN_ID           => :5\n" +
                                 "                                         );\n" + 
                                 " END; \n";
        OADBTransaction oadbtransaction = (OADBTransaction)this.getTransaction();
        OracleCallableStatement oraclecallablestatement =  (OracleCallableStatement)oadbtransaction.createCallableStatement(strCallableStmt, 1);
        try {
            oraclecallablestatement.registerOutParameter(1,Types.VARCHAR);
            oraclecallablestatement.registerOutParameter(2,Types.VARCHAR);
            oraclecallablestatement.setDouble(3,numRecDocId.doubleValue());
            oraclecallablestatement.setDouble(4,new Double(pUserID));
            oraclecallablestatement.setDouble(5,new Double(pLoginID));
            oraclecallablestatement.execute();
            retval = oraclecallablestatement.getString(2);
            System.out.println("retval:"+retval);
            getPerDocsVO1().executeQuery();
        } catch (SQLException e) {
                   System.out.println("SQLException en el metodo generateReqDoc:"+e.getErrorCode()+", "+e.getMessage());
                   throw new OAException("SQLException en el metodo generateReqDoc:"+e.getErrorCode(),OAException.ERROR); 
        }
        return retval;
    }

    public PerDocsVORowImpl getPerDocsRowById(String pRowReference) {
        System.out.println("pRowReference:"+pRowReference);
        PerDocsVORowImpl retval;
        PerDocsVOImpl perDocsVOImpl = getPerDocsVO1();
        retval = (PerDocsVORowImpl)this.findRowByRef(pRowReference);
        System.out.println("*"+retval);
        System.out.println("*"+retval.getId());
        System.out.println("*"+retval.getDocType());
        return retval;
    }

    public String getXmlDocByReqId(String strRecDocId) {
        System.out.println("Entra getXmlDocByReqId strRecDocId:"+strRecDocId);
        String retval =null;
        String strCallableStmt = " BEGIN \n" + 
                                 "  APPS.XXAZOR_PER_DOCS_PKG.get_xml ( PSO_XMLDOC             => :1\n" + 
                                 "                                   , PNI_REQUEST_ID         => :2\n" + 
                                 "                                   );\n" + 
                                 " END; \n";
        OADBTransaction oadbtransaction = (OADBTransaction)this.getTransaction();
        OracleCallableStatement oraclecallablestatement =  (OracleCallableStatement)oadbtransaction.createCallableStatement(strCallableStmt, 1);
        try {
            oraclecallablestatement.registerOutParameter(1,Types.CLOB);
            oraclecallablestatement.setDouble(2,new Double(strRecDocId));
            oraclecallablestatement.execute();
            System.out.println("execute");
            retval = oraclecallablestatement.getString(1);
            
            java.sql.Clob retvalClob = oraclecallablestatement.getClob(1);
            java.io.Reader reader =retvalClob.getCharacterStream();
            java.io.BufferedReader bufferReader = new java.io.BufferedReader(reader);
            String retvalxml = "";
            String line = null; 
            while((line = bufferReader.readLine())!=null){
                retvalxml = retvalxml+line;
            }
            
            System.out.println(retvalxml);
            retval = retvalxml;
            bufferReader.close();
            reader.close();
            
            System.out.println("retval:"+retval);
        } catch (SQLException e) {
                   System.out.println("SQLException en el metodo getXmlDocByReqId:"+e.getErrorCode()+", "+e.getMessage());
                   throw new OAException("SQLException en el metodo getXmlDocByReqId:"+e.getErrorCode(),OAException.ERROR); 
        }catch (IOException ioe) {
            System.out.println("IOException en el metodo getXmlDocByReqId:"+ioe.getMessage());
            throw new OAException("IOException en el metodo getXmlDocByReqId:"+ioe.getMessage(),OAException.ERROR);
        }
        return retval;
    }

    /**Container's getter for AprovadoresInfoVO1
     */
    public AprovadoresInfoVOImpl getAprovadoresInfoVO1() {
        return (AprovadoresInfoVOImpl)findViewObject("AprovadoresInfoVO1");
    }

    /**Container's getter for DocumentsTypesMgrVO1
     */
    public DocumentsTypesMgrVOImpl getDocumentsTypesMgrVO1() {
        return (DocumentsTypesMgrVOImpl)findViewObject("DocumentsTypesMgrVO1");
    }

    /**Container's getter for AclPVO1
     */
    public AclPVOImpl getAclPVO1() {
        return (AclPVOImpl)findViewObject("AclPVO1");
    }

    /**Container's getter for AclHVO1
     */
    public AclHVOImpl getAclHVO1() {
        return (AclHVOImpl)findViewObject("AclHVO1");
    }

    /**Container's getter for AclNVO1
     */
    public AclNVOImpl getAclNVO1() {
        return (AclNVOImpl)findViewObject("AclNVO1");
    }

    /**Container's getter for AclControlsVO1
     */
    public AclControlsVOImpl getAclControlsVO1() {
        return (AclControlsVOImpl)findViewObject("AclControlsVO1");
    }

    public void initControls() {
        AclControlsVOImpl aclControlsVOImpl= getAclControlsVO1();
        AclControlsVORowImpl aclControlsVORowImpl = null; 
        aclControlsVOImpl.executeQuery();
        RowSetIterator rowSetIterator = aclControlsVOImpl.createRowSetIterator("");
        while(rowSetIterator.hasNext()){
           aclControlsVORowImpl = (AclControlsVORowImpl)rowSetIterator.next();
            System.out.println("aclControlsVORowImpl.getPadre():"+aclControlsVORowImpl.getPadre());
            System.out.println("aclControlsVORowImpl.getPadreR():"+aclControlsVORowImpl.getPadreR());
           aclControlsVORowImpl.setPadre("Y");
           aclControlsVORowImpl.setHijo("N");
           aclControlsVORowImpl.setNieto("N");
           aclControlsVORowImpl.setObservaciones("N");
           System.out.println("aclControlsVORowImpl.getPadre():"+aclControlsVORowImpl.getPadre());
           System.out.println("aclControlsVORowImpl.getPadreR():"+aclControlsVORowImpl.getPadreR());
        }
    }

    public void filterAclHijo(String pPadreValue) {
        AclHVOImpl aclHVOImpl= getAclHVO1(); 
        aclHVOImpl.filterAclHijo(pPadreValue);
        AclControlsVOImpl aclControlsVOImpl= getAclControlsVO1();
        AclControlsVORowImpl aclControlsVORowImpl = null; 
        aclControlsVORowImpl = (AclControlsVORowImpl)aclControlsVOImpl.first();
        int count = aclHVOImpl.getRowCount();
        if(count==0){
            aclControlsVORowImpl.setHijo("N");
        }else{
            aclControlsVORowImpl.setHijo("Y");
        }
    }

    public void filterAclNieto(String pHijoValue) {
        AclNVOImpl aclNVOImpl= getAclNVO1(); 
        aclNVOImpl.filterAclNieto(pHijoValue);
        AclControlsVOImpl aclControlsVOImpl= getAclControlsVO1();
        AclControlsVORowImpl aclControlsVORowImpl = null; 
        aclControlsVORowImpl = (AclControlsVORowImpl)aclControlsVOImpl.first();
        int count = aclNVOImpl.getRowCount();
        if(count==0){
            aclControlsVORowImpl.setNieto("N");
        }else{
            aclControlsVORowImpl.setNieto("Y");
        }
    }

    /**Container's getter for PerAclarVO1
     */
    public PerAclarVOImpl getPerAclarVO1() {
        return (PerAclarVOImpl)findViewObject("PerAclarVO1");
    }

    public String crearAclaracion(String pPadre
                                , String pHijo
                                , String pNieto
                                , String pObservacionesAcl
                                , int pUserID
                                , int pLoginID
                                ) {
        String retval =null;
        UsersInfoVOImpl usersInfoVOImpl = getUsersInfoVO1();
        UsersInfoVORowImpl usersInfoVORowImpl = (UsersInfoVORowImpl)usersInfoVOImpl.getCurrentRow();
        String strCallableStmt = " BEGIN \n" + 
                                 "  APPS.XXAZOR_PER_DOCS_PKG.generate_aclar ( PSI_ERRCOD             => :1\n" + 
                                 "                                            , PSI_ERRMSG             => :2\n" + 
                                 "                                            , PNI_PERSON_ID          => :3\n" + 
                                 "                                            , PNI_ASSIGNMENT_ID      => :4\n" + 
                                 "                                            , PDI_EFFECTIVE_DATE     => :5\n" + 
                                 "                                            , PSI_PADRE              => :6\n" +
                                 "                                            , PSI_HIJO               => :7\n" +
                                 "                                            , PSI_NIETO              => :8\n" +
                                 "                                            , PSI_OBS_ACLA           => :9\n" +
                                 "                                            , PNI_USER_ID            => :10\n" +
                                 "                                            , PNI_LOGIN_ID           => :11\n" +
                                 "                                            );\n" + 
                                 " END; \n";
        OADBTransaction oadbtransaction = (OADBTransaction)this.getTransaction();
        OracleCallableStatement oraclecallablestatement =  (OracleCallableStatement)oadbtransaction.createCallableStatement(strCallableStmt, 1);
        try {
            System.out.println("usersInfoVORowImpl.getFechaSolicitud().dateValue():"+usersInfoVORowImpl.getFechaSolicitud().dateValue());
            oraclecallablestatement.registerOutParameter(1,Types.VARCHAR);
            oraclecallablestatement.registerOutParameter(2,Types.VARCHAR);
            oraclecallablestatement.setDouble(3,usersInfoVORowImpl.getPersonId().doubleValue());
            oraclecallablestatement.setDouble(4,usersInfoVORowImpl.getAssignmentId().doubleValue());
            oraclecallablestatement.setDate(5,usersInfoVORowImpl.getFechaSolicitud().dateValue());
            oraclecallablestatement.setString(6,pPadre);
            oraclecallablestatement.setString(7,pHijo);
            oraclecallablestatement.setString(8,pNieto);
            oraclecallablestatement.setString(9,pObservacionesAcl);
            oraclecallablestatement.setDouble(10,new Double(pUserID));
            oraclecallablestatement.setDouble(11,new Double(pLoginID));
            oraclecallablestatement.execute();
            retval = oraclecallablestatement.getString(2);
            System.out.println("retval:"+retval);
           
        } catch (SQLException e) {
                   System.out.println("SQLException en el metodo crearAclaracion:"+e.getErrorCode()+", "+e.getMessage());
                   throw new OAException("SQLException en el metodo crearAclaracion:"+e.getErrorCode(),OAException.ERROR); 
        }
        return retval;                         
    }

    /**Container's getter for PerAclarViewVO1
     */
    public PerAclarViewVOImpl getPerAclarViewVO1() {
        return (PerAclarViewVOImpl)findViewObject("PerAclarViewVO1");
    }

    public void initAclaInfo() {
        PerAclarViewVOImpl perAclarViewVOImpl= getPerAclarViewVO1();
        UsersInfoVOImpl usersInfoVOImpl = getUsersInfoVO1(); 
        UsersInfoVORowImpl usersInfoVORowImpl = (UsersInfoVORowImpl)usersInfoVOImpl.first();
        perAclarViewVOImpl.filter(usersInfoVORowImpl.getPersonId(),usersInfoVORowImpl.getAssignmentId());
        
    }

    public void filterAclarInfo(String strAclarId) {
        PerAclarViewVOImpl perAclarViewVOImpl= getPerAclarViewVO1();
        oracle.jbo.domain.Number numAclarId;
        try {
            numAclarId = new  oracle.jbo.domain.Number(strAclarId);
            perAclarViewVOImpl.filter(numAclarId);
        } catch (SQLException e) {
          throw new OAException(e.getMessage(),OAException.ERROR);
        }
    }

    public void filterSolDocById(String strSolDocId) {
        PerDocsVOImpl perDocsVOImpl = getPerDocsVO1();
        oracle.jbo.domain.Number numSolDocId;
        try {
            numSolDocId = new  oracle.jbo.domain.Number(strSolDocId);
            perDocsVOImpl.filter(numSolDocId);
        } catch (SQLException e) {
          throw new OAException(e.getMessage(),OAException.ERROR);
        }
    }

    /**Container's getter for PayrollsVO1
     */
    public PayrollsVOImpl getPayrollsVO1() {
        return (PayrollsVOImpl)findViewObject("PayrollsVO1");
    }

    /**Container's getter for PayPeriodsVO1
     */
    public PayPeriodsVOImpl getPayPeriodsVO1() {
        return (PayPeriodsVOImpl)findViewObject("PayPeriodsVO1");
    }

    /**Container's getter for PayExecutionsVO1
     */
    public PayExecutionsVOImpl getPayExecutionsVO1() {
        return (PayExecutionsVOImpl)findViewObject("PayExecutionsVO1");
    }

    /**Container's getter for GenTimControlsVO1
     */
    public GenTimControlsVOImpl getGenTimControlsVO1() {
        return (GenTimControlsVOImpl)findViewObject("GenTimControlsVO1");
    }

    public void llamarServicioWeb() {
        PayExecutionsVOImpl payExecutionsVOImpl = getPayExecutionsVO1(); 
        RowSetIterator iterator  = payExecutionsVOImpl.createRowSetIterator(null);
        while(iterator.hasNext()){
             PayExecutionsVORowImpl payExecutionsVORowImpl = (PayExecutionsVORowImpl)iterator.next(); 
             if("Y".equals(payExecutionsVORowImpl.getMultiSelection())){
                 generarATI(payExecutionsVORowImpl.getBusinessGroupId()
                           ,payExecutionsVORowImpl.getPersonId()
                           ,payExecutionsVORowImpl.getAssignmentId()
                           ,payExecutionsVORowImpl.getTimePeriodId()
                           ,payExecutionsVORowImpl.getPayrollActionId()
                           ,payExecutionsVORowImpl.getAssignmentActionId()
                           );
                String[] strArray = getATI(payExecutionsVORowImpl.getBusinessGroupId()
                                ,payExecutionsVORowImpl.getPersonId()
                                ,payExecutionsVORowImpl.getAssignmentId()
                                ,payExecutionsVORowImpl.getTimePeriodId()
                                ,payExecutionsVORowImpl.getPayrollActionId()
                                ,payExecutionsVORowImpl.getAssignmentActionId()
                                );
                String strgeneraReciboWS = ServiceDeGeneracionSoap12Client.generaReciboWSByte(strArray[2].getBytes());
                System.out.println(strgeneraReciboWS);
            }
        }
    }

    private void generarATI(Number pBusinessGroupId
                          , Number pPersonId
                          , Number pAssignmentId
                          , Number pTimePeriodId
                          , Number pPayrollActionId
                          , Number pAssignmentActionId) {
        String strCallableStmt = "BEGIN\n" + 
                                 "   APPS.XXAZOR_PAY_TE_PKG.GENERATE_ATI (PSI_ERRCOD                => :1\n" + 
                                 "                                       ,PSI_ERRMSG                => :2\n" + 
                                 "                                       ,PNI_BGID                  => :3\n" + 
                                 "                                       ,PNI_PERSON_ID             => :4\n" + 
                                 "                                       ,PNI_ASSIGNMENT_ID         => :5\n" + 
                                 "                                       ,PNI_TIME_PERIOD_ID        => :6\n" + 
                                 "                                       ,PNI_PAYROLL_ACTION_ID     => :7\n" + 
                                 "                                       ,PNI_ASSIGNMENT_ACTION_ID  => :8\n" + 
                                 "                                        );\n" + 
                                 "END;";
        OADBTransaction oadbtransaction = (OADBTransaction)this.getTransaction();
        OracleCallableStatement oraclecallablestatement =  (OracleCallableStatement)oadbtransaction.createCallableStatement(strCallableStmt, 1);
       try {
        oraclecallablestatement.registerOutParameter(1,Types.VARCHAR);
        oraclecallablestatement.registerOutParameter(2,Types.VARCHAR);
        oraclecallablestatement.setDouble(3,pBusinessGroupId.doubleValue());
        oraclecallablestatement.setDouble(4,pPersonId.doubleValue());
        oraclecallablestatement.setDouble(5,pAssignmentId.doubleValue());
        oraclecallablestatement.setDouble(6,pTimePeriodId.doubleValue());
        oraclecallablestatement.setDouble(7,pPayrollActionId.doubleValue());
        oraclecallablestatement.setDouble(8,pAssignmentActionId.doubleValue());
        oraclecallablestatement.execute();
        
        } catch (SQLException e) {
               System.out.println("SQLException en el metodo generarATI:"+e.getErrorCode()+", "+e.getMessage());
               throw new OAException("SQLException en el metodo generarATI:"+e.getErrorCode(),OAException.ERROR); 
        }   
    }

    private String[] getATI(Number pBusinessGroupId
                      , Number pPersonId
                      , Number pAssignmentId
                      , Number pTimePeriodId
                      , Number pPayrollActionId
                      , Number pAssignmentActionId) {
        String[] retval = new String[3];
        String strCallableStmt = "BEGIN\n" + 
                                 "   APPS.XXAZOR_PAY_TE_PKG.GET_ATI(PSI_ERRCOD                => :1\n" + 
                                 "                                 ,PSI_ERRMSG                => :2\n" + 
                                 "                                 ,PCO_ATI                   => :3\n" +
                                 "                                 ,PNI_BGID                  => :4\n" + 
                                 "                                 ,PNI_PERSON_ID             => :5\n" + 
                                 "                                 ,PNI_ASSIGNMENT_ID         => :6\n" + 
                                 "                                 ,PNI_TIME_PERIOD_ID        => :7\n" + 
                                 "                                 ,PNI_PAYROLL_ACTION_ID     => :8\n" + 
                                 "                                 ,PNI_ASSIGNMENT_ACTION_ID  => :9\n" + 
                                 "                                  );\n" + 
                                 "END;";
        OADBTransaction oadbtransaction = (OADBTransaction)this.getTransaction();
        OracleCallableStatement oraclecallablestatement =  (OracleCallableStatement)oadbtransaction.createCallableStatement(strCallableStmt, 1);
        try {
        oraclecallablestatement.registerOutParameter(1,Types.VARCHAR);
        oraclecallablestatement.registerOutParameter(2,Types.VARCHAR);
        oraclecallablestatement.registerOutParameter(3,Types.CLOB);
        oraclecallablestatement.setDouble(4,pBusinessGroupId.doubleValue());
        oraclecallablestatement.setDouble(5,pPersonId.doubleValue());
        oraclecallablestatement.setDouble(6,pAssignmentId.doubleValue());
        oraclecallablestatement.setDouble(7,pTimePeriodId.doubleValue());
        oraclecallablestatement.setDouble(8,pPayrollActionId.doubleValue());
        oraclecallablestatement.setDouble(9,pAssignmentActionId.doubleValue());
        oraclecallablestatement.execute();
        
          
        java.sql.Clob atiClob = oraclecallablestatement.getClob(3);
        String strATI = clobToString(atiClob);
            /******************************************************
        System.out.println(atiClob);
          
            java.io.Reader reader =atiClob.getCharacterStream();
             java.io.BufferedReader bufferReader = new java.io.BufferedReader(reader);
           
            java.io.InputStream is = atiClob.getAsciiStream();
            java.io.Reader reader = new InputStreamReader(is);
            java.io.BufferedReader bufferReader = new java.io.BufferedReader(reader);
            String strATI = "";
            String line = null; 
            while((line = bufferReader.readLine())!=null){
                strATI = strATI+line;
            }
            
            System.out.println(strATI);
            bufferReader.close();
            reader.close();
             *******************************************************/
            /**
            oracle.sql.CLOB atiClob2 = oraclecallablestatement.getCLOB(3);
            System.out.println(atiClob2);
            java.io.InputStream is = atiClob2.getAsciiStream();
            java.io.Reader reader = new InputStreamReader(is);
            java.io.BufferedReader bufferReader = new java.io.BufferedReader(reader);
            String strATI = "";
            String line = null; 
            while((line = bufferReader.readLine())!=null){
                strATI = strATI+line;
            }
             System.out.println(strATI);
           
            bufferReader.close();
            reader.close();
            **/
             System.out.println(strATI);
            retval[0] = "ERRCOD";
            retval[1] = "ERRMSG";
            retval[2] = strATI;
        } catch (SQLException e) {
               System.out.println("SQLException en el metodo generarATI:"+e.getErrorCode()+", "+e.getMessage());
               throw new OAException("SQLException en el metodo generarATI:"+e.getErrorCode(),OAException.ERROR); 
        } 
        
       return retval; 
        
    }
    
    /*********************************************************************************************
     * From CLOB to String
     * @return string representation of clob
     *********************************************************************************************/
    private String clobToString(java.sql.Clob data)
    {
        final StringBuilder sb = new StringBuilder();

        try
        {
            final Reader         reader = data.getCharacterStream();
            final BufferedReader br     = new BufferedReader(reader);

            int b;
            while(-1 != (b = br.read()))
            {
                sb.append((char)b);
            }

            br.close();
        }
        catch (SQLException e)
        {
            System.out.println("SQL. Could not convert CLOB to string:"+e.toString());
            return e.toString();
        }
        catch (IOException e)
        {
            System.out.println("IO. Could not convert CLOB to string:"+e.toString());
            return e.toString();
        }

        return sb.toString();
    }
    
}
