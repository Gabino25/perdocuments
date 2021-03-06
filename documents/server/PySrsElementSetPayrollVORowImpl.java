package xxazor.oracle.apps.per.documents.server;

import oracle.apps.fnd.framework.server.OAViewRowImpl;

import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class PySrsElementSetPayrollVORowImpl extends OAViewRowImpl {
    public static final int ELEMENTSETNAME = 0;
    public static final int ELEMENTSETID = 1;
    public static final int BUSINESSGROUPID = 2;
    public static final int TIMEPERIODID = 3;
    public static final int PAYROLLID = 4;

    /**This is the default constructor (do not remove)
     */
    public PySrsElementSetPayrollVORowImpl() {
    }

    /**Gets the attribute value for the calculated attribute ElementSetName
     */
    public String getElementSetName() {
        return (String) getAttributeInternal(ELEMENTSETNAME);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute ElementSetName
     */
    public void setElementSetName(String value) {
        setAttributeInternal(ELEMENTSETNAME, value);
    }

    /**Gets the attribute value for the calculated attribute ElementSetId
     */
    public Number getElementSetId() {
        return (Number) getAttributeInternal(ELEMENTSETID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute ElementSetId
     */
    public void setElementSetId(Number value) {
        setAttributeInternal(ELEMENTSETID, value);
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

    /**Gets the attribute value for the calculated attribute TimePeriodId
     */
    public Number getTimePeriodId() {
        return (Number) getAttributeInternal(TIMEPERIODID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute TimePeriodId
     */
    public void setTimePeriodId(Number value) {
        setAttributeInternal(TIMEPERIODID, value);
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

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ELEMENTSETNAME:
            return getElementSetName();
        case ELEMENTSETID:
            return getElementSetId();
        case BUSINESSGROUPID:
            return getBusinessGroupId();
        case TIMEPERIODID:
            return getTimePeriodId();
        case PAYROLLID:
            return getPayrollId();
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
