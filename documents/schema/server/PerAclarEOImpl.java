package xxazor.oracle.apps.per.documents.schema.server;

import oracle.apps.fnd.framework.server.OAEntityDefImpl;
import oracle.apps.fnd.framework.server.OAEntityImpl;

import oracle.jbo.AttributeList;
import oracle.jbo.Key;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
import oracle.jbo.server.EntityDefImpl;
import oracle.jbo.server.TransactionEvent;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class PerAclarEOImpl extends OAEntityImpl {
    public static final int ID = 0;
    public static final int PERSONID = 1;
    public static final int ASSIGNMENTID = 2;
    public static final int EFECTIVEDATE = 3;
    public static final int STATUS = 4;
    public static final int PADRE = 5;
    public static final int HIJO = 6;
    public static final int NIETO = 7;
    public static final int APPROVERID = 8;
    public static final int CREATEDBY = 9;
    public static final int CREATIONDATE = 10;
    public static final int LASTUPDATEDBY = 11;
    public static final int LASTUPDATEDATE = 12;
    public static final int LASTUPDATELOGIN = 13;
    public static final int DESCACLARACION = 14;
    public static final int NOTAAPPROVER = 15;


    private static OAEntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public PerAclarEOImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = 
                    (OAEntityDefImpl)EntityDefImpl.findDefObject("xxazor.oracle.apps.per.documents.schema.server.PerAclarEO");
        }
        return mDefinitionObject;
    }

    /**Add attribute defaulting logic in this method.
     */
    public void create(AttributeList attributeList) {
        super.create(attributeList);
    }

    /**Add entity remove logic in this method.
     */
    public void remove() {
        super.remove();
    }

    /**Add Entity validation code in this method.
     */
    protected void validateEntity() {
        super.validateEntity();
    }

    /**Add locking logic here.
     */
    public void lock() {
        super.lock();
    }

    /**Custom DML update/insert/delete logic here.
     */
    protected void doDML(int operation, TransactionEvent e) {
        super.doDML(operation, e);
    }

    /**Gets the attribute value for Id, using the alias name Id
     */
    public Number getId() {
        return (Number)getAttributeInternal(ID);
    }

    /**Sets <code>value</code> as the attribute value for Id
     */
    public void setId(Number value) {
        setAttributeInternal(ID, value);
    }

    /**Gets the attribute value for PersonId, using the alias name PersonId
     */
    public Number getPersonId() {
        return (Number)getAttributeInternal(PERSONID);
    }

    /**Sets <code>value</code> as the attribute value for PersonId
     */
    public void setPersonId(Number value) {
        setAttributeInternal(PERSONID, value);
    }

    /**Gets the attribute value for AssignmentId, using the alias name AssignmentId
     */
    public Number getAssignmentId() {
        return (Number)getAttributeInternal(ASSIGNMENTID);
    }

    /**Sets <code>value</code> as the attribute value for AssignmentId
     */
    public void setAssignmentId(Number value) {
        setAttributeInternal(ASSIGNMENTID, value);
    }

    /**Gets the attribute value for EfectiveDate, using the alias name EfectiveDate
     */
    public Date getEfectiveDate() {
        return (Date)getAttributeInternal(EFECTIVEDATE);
    }

    /**Sets <code>value</code> as the attribute value for EfectiveDate
     */
    public void setEfectiveDate(Date value) {
        setAttributeInternal(EFECTIVEDATE, value);
    }

    /**Gets the attribute value for Status, using the alias name Status
     */
    public String getStatus() {
        return (String)getAttributeInternal(STATUS);
    }

    /**Sets <code>value</code> as the attribute value for Status
     */
    public void setStatus(String value) {
        setAttributeInternal(STATUS, value);
    }

    /**Gets the attribute value for Padre, using the alias name Padre
     */
    public String getPadre() {
        return (String)getAttributeInternal(PADRE);
    }

    /**Sets <code>value</code> as the attribute value for Padre
     */
    public void setPadre(String value) {
        setAttributeInternal(PADRE, value);
    }

    /**Gets the attribute value for Hijo, using the alias name Hijo
     */
    public String getHijo() {
        return (String)getAttributeInternal(HIJO);
    }

    /**Sets <code>value</code> as the attribute value for Hijo
     */
    public void setHijo(String value) {
        setAttributeInternal(HIJO, value);
    }

    /**Gets the attribute value for Nieto, using the alias name Nieto
     */
    public String getNieto() {
        return (String)getAttributeInternal(NIETO);
    }

    /**Sets <code>value</code> as the attribute value for Nieto
     */
    public void setNieto(String value) {
        setAttributeInternal(NIETO, value);
    }

    /**Gets the attribute value for ApproverId, using the alias name ApproverId
     */
    public Number getApproverId() {
        return (Number)getAttributeInternal(APPROVERID);
    }

    /**Sets <code>value</code> as the attribute value for ApproverId
     */
    public void setApproverId(Number value) {
        setAttributeInternal(APPROVERID, value);
    }

    /**Gets the attribute value for CreatedBy, using the alias name CreatedBy
     */
    public Number getCreatedBy() {
        return (Number)getAttributeInternal(CREATEDBY);
    }

    /**Sets <code>value</code> as the attribute value for CreatedBy
     */
    public void setCreatedBy(Number value) {
        setAttributeInternal(CREATEDBY, value);
    }

    /**Gets the attribute value for CreationDate, using the alias name CreationDate
     */
    public Date getCreationDate() {
        return (Date)getAttributeInternal(CREATIONDATE);
    }

    /**Sets <code>value</code> as the attribute value for CreationDate
     */
    public void setCreationDate(Date value) {
        setAttributeInternal(CREATIONDATE, value);
    }

    /**Gets the attribute value for LastUpdatedBy, using the alias name LastUpdatedBy
     */
    public Number getLastUpdatedBy() {
        return (Number)getAttributeInternal(LASTUPDATEDBY);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdatedBy
     */
    public void setLastUpdatedBy(Number value) {
        setAttributeInternal(LASTUPDATEDBY, value);
    }

    /**Gets the attribute value for LastUpdateDate, using the alias name LastUpdateDate
     */
    public Date getLastUpdateDate() {
        return (Date)getAttributeInternal(LASTUPDATEDATE);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdateDate
     */
    public void setLastUpdateDate(Date value) {
        setAttributeInternal(LASTUPDATEDATE, value);
    }

    /**Gets the attribute value for LastUpdateLogin, using the alias name LastUpdateLogin
     */
    public Number getLastUpdateLogin() {
        return (Number)getAttributeInternal(LASTUPDATELOGIN);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdateLogin
     */
    public void setLastUpdateLogin(Number value) {
        setAttributeInternal(LASTUPDATELOGIN, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ID:
            return getId();
        case PERSONID:
            return getPersonId();
        case ASSIGNMENTID:
            return getAssignmentId();
        case EFECTIVEDATE:
            return getEfectiveDate();
        case STATUS:
            return getStatus();
        case PADRE:
            return getPadre();
        case HIJO:
            return getHijo();
        case NIETO:
            return getNieto();
        case APPROVERID:
            return getApproverId();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case LASTUPDATELOGIN:
            return getLastUpdateLogin();
        case DESCACLARACION:
            return getDescAclaracion();
        case NOTAAPPROVER:
            return getNotaApprover();
        default:
            return super.getAttrInvokeAccessor(index, attrDef);
        }
    }

    /**setAttrInvokeAccessor: generated method. Do not modify.
     */
    protected void setAttrInvokeAccessor(int index, Object value, 
                                         AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ID:
            setId((Number)value);
            return;
        case PERSONID:
            setPersonId((Number)value);
            return;
        case ASSIGNMENTID:
            setAssignmentId((Number)value);
            return;
        case EFECTIVEDATE:
            setEfectiveDate((Date)value);
            return;
        case STATUS:
            setStatus((String)value);
            return;
        case PADRE:
            setPadre((String)value);
            return;
        case HIJO:
            setHijo((String)value);
            return;
        case NIETO:
            setNieto((String)value);
            return;
        case APPROVERID:
            setApproverId((Number)value);
            return;
        case CREATEDBY:
            setCreatedBy((Number)value);
            return;
        case CREATIONDATE:
            setCreationDate((Date)value);
            return;
        case LASTUPDATEDBY:
            setLastUpdatedBy((Number)value);
            return;
        case LASTUPDATEDATE:
            setLastUpdateDate((Date)value);
            return;
        case LASTUPDATELOGIN:
            setLastUpdateLogin((Number)value);
            return;
        case DESCACLARACION:
            setDescAclaracion((String)value);
            return;
        case NOTAAPPROVER:
            setNotaApprover((String)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the attribute value for DescAclaracion, using the alias name DescAclaracion
     */
    public String getDescAclaracion() {
        return (String)getAttributeInternal(DESCACLARACION);
    }

    /**Sets <code>value</code> as the attribute value for DescAclaracion
     */
    public void setDescAclaracion(String value) {
        setAttributeInternal(DESCACLARACION, value);
    }

    /**Gets the attribute value for NotaApprover, using the alias name NotaApprover
     */
    public String getNotaApprover() {
        return (String)getAttributeInternal(NOTAAPPROVER);
    }

    /**Sets <code>value</code> as the attribute value for NotaApprover
     */
    public void setNotaApprover(String value) {
        setAttributeInternal(NOTAAPPROVER, value);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(Number id) {
        return new Key(new Object[]{id});
    }
}
