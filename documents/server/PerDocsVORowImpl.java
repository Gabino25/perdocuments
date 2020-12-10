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
public class PerDocsVORowImpl extends OAViewRowImpl {
    public static final int PERSONID = 0;
    public static final int ASSIGNMENTID = 1;
    public static final int EMPLOYEENUMBER = 2;
    public static final int FECHACONTRATACION = 3;
    public static final int FECHABAJA = 4;
    public static final int FULLNAME = 5;
    public static final int NAME = 6;
    public static final int POSITIONID = 7;
    public static final int ID = 8;
    public static final int CREATIONDATE = 9;
    public static final int EFECTIVEDATE = 10;
    public static final int STATUS = 11;

    /**This is the default constructor (do not remove)
     */
    public PerDocsVORowImpl() {
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

    /**Gets the attribute value for the calculated attribute AssignmentId
     */
    public Number getAssignmentId() {
        return (Number) getAttributeInternal(ASSIGNMENTID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute AssignmentId
     */
    public void setAssignmentId(Number value) {
        setAttributeInternal(ASSIGNMENTID, value);
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

    /**Gets the attribute value for the calculated attribute FechaContratacion
     */
    public Date getFechaContratacion() {
        return (Date) getAttributeInternal(FECHACONTRATACION);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute FechaContratacion
     */
    public void setFechaContratacion(Date value) {
        setAttributeInternal(FECHACONTRATACION, value);
    }

    /**Gets the attribute value for the calculated attribute FechaBaja
     */
    public Date getFechaBaja() {
        return (Date) getAttributeInternal(FECHABAJA);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute FechaBaja
     */
    public void setFechaBaja(Date value) {
        setAttributeInternal(FECHABAJA, value);
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

    /**Gets the attribute value for the calculated attribute Name
     */
    public String getName() {
        return (String) getAttributeInternal(NAME);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Name
     */
    public void setName(String value) {
        setAttributeInternal(NAME, value);
    }

    /**Gets the attribute value for the calculated attribute PositionId
     */
    public Number getPositionId() {
        return (Number) getAttributeInternal(POSITIONID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PositionId
     */
    public void setPositionId(Number value) {
        setAttributeInternal(POSITIONID, value);
    }

    /**Gets the attribute value for the calculated attribute Id
     */
    public Number getId() {
        return (Number) getAttributeInternal(ID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Id
     */
    public void setId(Number value) {
        setAttributeInternal(ID, value);
    }

    /**Gets the attribute value for the calculated attribute CreationDate
     */
    public Date getCreationDate() {
        return (Date) getAttributeInternal(CREATIONDATE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute CreationDate
     */
    public void setCreationDate(Date value) {
        setAttributeInternal(CREATIONDATE, value);
    }

    /**Gets the attribute value for the calculated attribute EfectiveDate
     */
    public Date getEfectiveDate() {
        return (Date) getAttributeInternal(EFECTIVEDATE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute EfectiveDate
     */
    public void setEfectiveDate(Date value) {
        setAttributeInternal(EFECTIVEDATE, value);
    }

    /**Gets the attribute value for the calculated attribute Status
     */
    public String getStatus() {
        return (String) getAttributeInternal(STATUS);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Status
     */
    public void setStatus(String value) {
        setAttributeInternal(STATUS, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case PERSONID:
            return getPersonId();
        case ASSIGNMENTID:
            return getAssignmentId();
        case EMPLOYEENUMBER:
            return getEmployeeNumber();
        case FECHACONTRATACION:
            return getFechaContratacion();
        case FECHABAJA:
            return getFechaBaja();
        case FULLNAME:
            return getFullName();
        case NAME:
            return getName();
        case POSITIONID:
            return getPositionId();
        case ID:
            return getId();
        case CREATIONDATE:
            return getCreationDate();
        case EFECTIVEDATE:
            return getEfectiveDate();
        case STATUS:
            return getStatus();
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
