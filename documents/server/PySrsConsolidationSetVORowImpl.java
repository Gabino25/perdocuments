package xxazor.oracle.apps.per.documents.server;

import oracle.apps.fnd.framework.server.OAViewRowImpl;

import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class PySrsConsolidationSetVORowImpl extends OAViewRowImpl {
    public static final int CONSOLIDATIONSETNAME = 0;
    public static final int CONSOLIDATIONSETID = 1;
    public static final int BUSINESSGROUPID = 2;

    /**This is the default constructor (do not remove)
     */
    public PySrsConsolidationSetVORowImpl() {
    }

    /**Gets the attribute value for the calculated attribute ConsolidationSetName
     */
    public String getConsolidationSetName() {
        return (String) getAttributeInternal(CONSOLIDATIONSETNAME);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute ConsolidationSetName
     */
    public void setConsolidationSetName(String value) {
        setAttributeInternal(CONSOLIDATIONSETNAME, value);
    }

    /**Gets the attribute value for the calculated attribute ConsolidationSetId
     */
    public Number getConsolidationSetId() {
        return (Number) getAttributeInternal(CONSOLIDATIONSETID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute ConsolidationSetId
     */
    public void setConsolidationSetId(Number value) {
        setAttributeInternal(CONSOLIDATIONSETID, value);
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

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case CONSOLIDATIONSETNAME:
            return getConsolidationSetName();
        case CONSOLIDATIONSETID:
            return getConsolidationSetId();
        case BUSINESSGROUPID:
            return getBusinessGroupId();
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
