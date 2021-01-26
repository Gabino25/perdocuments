package xxazor.oracle.apps.per.documents.server;

import oracle.apps.fnd.framework.server.OAViewRowImpl;

import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class PayPeriodsVORowImpl extends OAViewRowImpl {
    public static final int TIMEPERIODID = 0;
    public static final int PAYROLLID = 1;
    public static final int PERIODNUM = 2;
    public static final int PERIODTYPE = 3;
    public static final int STARTDATE = 4;
    public static final int ENDDATE = 5;
    public static final int PERIODNAME = 6;

    /**This is the default constructor (do not remove)
     */
    public PayPeriodsVORowImpl() {
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

    /**Gets the attribute value for the calculated attribute PeriodNum
     */
    public Number getPeriodNum() {
        return (Number) getAttributeInternal(PERIODNUM);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PeriodNum
     */
    public void setPeriodNum(Number value) {
        setAttributeInternal(PERIODNUM, value);
    }

    /**Gets the attribute value for the calculated attribute PeriodType
     */
    public String getPeriodType() {
        return (String) getAttributeInternal(PERIODTYPE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PeriodType
     */
    public void setPeriodType(String value) {
        setAttributeInternal(PERIODTYPE, value);
    }

    /**Gets the attribute value for the calculated attribute StartDate
     */
    public Date getStartDate() {
        return (Date) getAttributeInternal(STARTDATE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute StartDate
     */
    public void setStartDate(Date value) {
        setAttributeInternal(STARTDATE, value);
    }

    /**Gets the attribute value for the calculated attribute EndDate
     */
    public Date getEndDate() {
        return (Date) getAttributeInternal(ENDDATE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute EndDate
     */
    public void setEndDate(Date value) {
        setAttributeInternal(ENDDATE, value);
    }

    /**Gets the attribute value for the calculated attribute PeriodName
     */
    public String getPeriodName() {
        return (String) getAttributeInternal(PERIODNAME);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PeriodName
     */
    public void setPeriodName(String value) {
        setAttributeInternal(PERIODNAME, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case TIMEPERIODID:
            return getTimePeriodId();
        case PAYROLLID:
            return getPayrollId();
        case PERIODNUM:
            return getPeriodNum();
        case PERIODTYPE:
            return getPeriodType();
        case STARTDATE:
            return getStartDate();
        case ENDDATE:
            return getEndDate();
        case PERIODNAME:
            return getPeriodName();
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
