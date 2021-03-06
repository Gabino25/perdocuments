package xxazor.oracle.apps.per.documents.server;

import oracle.apps.fnd.framework.server.OAViewRowImpl;

import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class PayrollsVORowImpl extends OAViewRowImpl {
    public static final int PAYROLLID = 0;
    public static final int BUSINESSGROUPID = 1;
    public static final int PAYROLLNAME = 2;

    /**This is the default constructor (do not remove)
     */
    public PayrollsVORowImpl() {
    }

    /**Gets the attribute value for the calculated attribute PayrollId
     */
    public Number getPayrollId() {
        return (Number) getAttributeInternal(PAYROLLID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PayrollId
     */
    public void setPayrollId(Number value) {
        setAttributeInternal(PAYROLLID, value);
    }

    /**Gets the attribute value for the calculated attribute BusinessGroupId
     */
    public Number getBusinessGroupId() {
        return (Number) getAttributeInternal(BUSINESSGROUPID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute BusinessGroupId
     */
    public void setBusinessGroupId(Number value) {
        setAttributeInternal(BUSINESSGROUPID, value);
    }

    /**Gets the attribute value for the calculated attribute PayrollName
     */
    public String getPayrollName() {
        return (String) getAttributeInternal(PAYROLLNAME);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PayrollName
     */
    public void setPayrollName(String value) {
        setAttributeInternal(PAYROLLNAME, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case PAYROLLID:
            return getPayrollId();
        case BUSINESSGROUPID:
            return getBusinessGroupId();
        case PAYROLLNAME:
            return getPayrollName();
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
