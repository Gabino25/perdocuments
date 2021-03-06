package xxazor.oracle.apps.per.documents.server;

import oracle.apps.fnd.framework.server.OAViewRowImpl;

import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class AprovadoresInfoVORowImpl extends OAViewRowImpl {
    public static final int EMPLOYEENUMBER = 0;
    public static final int FULLNAME = 1;
    public static final int PERSONID = 2;
    public static final int AUTORIZACARTASRH = 3;

    /**This is the default constructor (do not remove)
     */
    public AprovadoresInfoVORowImpl() {
    }

    /**Gets the attribute value for the calculated attribute EmployeeNumber
     */
    public String getEmployeeNumber() {
        return (String) getAttributeInternal(EMPLOYEENUMBER);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute EmployeeNumber
     */
    public void setEmployeeNumber(String value) {
        setAttributeInternal(EMPLOYEENUMBER, value);
    }

    /**Gets the attribute value for the calculated attribute FullName
     */
    public String getFullName() {
        return (String) getAttributeInternal(FULLNAME);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute FullName
     */
    public void setFullName(String value) {
        setAttributeInternal(FULLNAME, value);
    }

    /**Gets the attribute value for the calculated attribute PersonId
     */
    public Number getPersonId() {
        return (Number) getAttributeInternal(PERSONID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PersonId
     */
    public void setPersonId(Number value) {
        setAttributeInternal(PERSONID, value);
    }

    /**Gets the attribute value for the calculated attribute AutorizaCartasRh
     */
    public String getAutorizaCartasRh() {
        return (String) getAttributeInternal(AUTORIZACARTASRH);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute AutorizaCartasRh
     */
    public void setAutorizaCartasRh(String value) {
        setAttributeInternal(AUTORIZACARTASRH, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case EMPLOYEENUMBER:
            return getEmployeeNumber();
        case FULLNAME:
            return getFullName();
        case PERSONID:
            return getPersonId();
        case AUTORIZACARTASRH:
            return getAutorizaCartasRh();
        default:
            return super.getAttrInvokeAccessor(index, attrDef);
        }
    }

    /**setAttrInvokeAccessor: generated method. Do not modify.
     */
    protected void setAttrInvokeAccessor(int index, Object value, 
                                         AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }
}
