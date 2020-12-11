package xxazor.oracle.apps.per.documents.server;

import java.io.IOException;

import java.sql.SQLException;
import java.sql.Types;

import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.server.OAApplicationModuleImpl;

import oracle.apps.fnd.framework.server.OADBTransaction;

import oracle.jbo.Key;
import oracle.jbo.RowSetIterator;

import oracle.jbo.domain.Number;

import oracle.jdbc.OracleCallableStatement;

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

    public String crearSolicitud(String pDocumentType,int pUserID,int pLoginID) {
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
                                 "                                            , PNI_USER_ID            => :7\n" +
                                 "                                            , PNI_LOGIN_ID           => :8\n" +
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
            oraclecallablestatement.setDouble(7,new Double(pUserID));
            oraclecallablestatement.setDouble(8,new Double(pLoginID));
            oraclecallablestatement.execute();
            retval = oraclecallablestatement.getString(2);
            System.out.println("retval:"+retval);
           
        } catch (SQLException e) {
                   System.out.println("SQLException en el metodo crearSolicitud:"+e.getErrorCode()+", "+e.getMessage());
                   throw new OAException("SQLException en el metodo crearSolicitud:"+e.getErrorCode(),OAException.ERROR); 
       }
       return retval;
    }


    public void filterDocTypes() {
        UsersInfoVOImpl usersInfoVOImpl = getUsersInfoVO1();
        UsersInfoVORowImpl usersInfoVORowImpl = (UsersInfoVORowImpl)usersInfoVOImpl.first();
        PerDocsVOImpl perDocsVOImpl = getPerDocsVO1();
        System.out.println("perDocsVOImpl:"+perDocsVOImpl);
        System.out.println("usersInfoVORowImpl:"+usersInfoVORowImpl);
        perDocsVOImpl.filter(usersInfoVORowImpl.getPersonId()
                            ,usersInfoVORowImpl.getAssignmentId());
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
}
