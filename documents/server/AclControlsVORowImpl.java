package xxazor.oracle.apps.per.documents.server;

import oracle.apps.fnd.framework.server.OAViewRowImpl;

import oracle.jbo.server.AttributeDefImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class AclControlsVORowImpl extends OAViewRowImpl {
    public static final int PADRE = 0;
    public static final int HIJO = 1;
    public static final int NIETO = 2;
    public static final int OBSERVACIONES = 3;
    public static final int PADRER = 4;
    public static final int HIJOR = 5;
    public static final int NIETOR = 6;
    public static final int OBSERVACIONESR = 7;

    /**This is the default constructor (do not remove)
     */
    public AclControlsVORowImpl() {
    }

    /**Gets the attribute value for the calculated attribute Padre
     */
    public String getPadre() {
        return (String) getAttributeInternal(PADRE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Padre
     */
    public void setPadre(String value) {
       System.out.println("setPadre value:"+value);
        setAttributeInternal(PADRE, value);
        if("N".equals(value)){
            setPadreR(false);
        }else{
            setPadreR(true);
        }
    }

    /**Gets the attribute value for the calculated attribute Hijo
     */
    public String getHijo() {
        return (String) getAttributeInternal(HIJO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Hijo
     */
    public void setHijo(String value) {
        setAttributeInternal(HIJO, value);
        if("N".equals(value)){
            setHijoR(false);
        }else{
            setHijoR(true);
        }
    }

    /**Gets the attribute value for the calculated attribute Nieto
     */
    public String getNieto() {
        return (String) getAttributeInternal(NIETO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Nieto
     */
    public void setNieto(String value) {
        setAttributeInternal(NIETO, value);
        if("N".equals(value)){
            setNietoR(false);
        }else{
            setNietoR(true);
        }
    }

    /**Gets the attribute value for the calculated attribute Observaciones
     */
    public String getObservaciones() {
        return (String) getAttributeInternal(OBSERVACIONES);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Observaciones
     */
    public void setObservaciones(String value) {
        setAttributeInternal(OBSERVACIONES, value);
        if("N".equals(value)){
            setObservacionesR(false);
        }else{
            setObservacionesR(true);
        }
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index, 
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case PADRE:
            return getPadre();
        case HIJO:
            return getHijo();
        case NIETO:
            return getNieto();
        case OBSERVACIONES:
            return getObservaciones();
        case PADRER:
            return getPadreR();
        case HIJOR:
            return getHijoR();
        case NIETOR:
            return getNietoR();
        case OBSERVACIONESR:
            return getObservacionesR();
        default:
            return super.getAttrInvokeAccessor(index, attrDef);
        }
    }

    /**setAttrInvokeAccessor: generated method. Do not modify.
     */
    protected void setAttrInvokeAccessor(int index, Object value, 
                                         AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case PADRE:
            setPadre((String)value);
            return;
        case HIJO:
            setHijo((String)value);
            return;
        case NIETO:
            setNieto((String)value);
            return;
        case OBSERVACIONES:
            setObservaciones((String)value);
            return;
        case PADRER:
            setPadreR((Boolean)value);
            return;
        case HIJOR:
            setHijoR((Boolean)value);
            return;
        case NIETOR:
            setNietoR((Boolean)value);
            return;
        case OBSERVACIONESR:
            setObservacionesR((Boolean)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the attribute value for the calculated attribute PadreR
     */
    public Boolean getPadreR() {
        return (Boolean) getAttributeInternal(PADRER);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PadreR
     */
    public void setPadreR(Boolean value) {
        setAttributeInternal(PADRER, value);
    }

    /**Gets the attribute value for the calculated attribute HijoR
     */
    public Boolean getHijoR() {
        return (Boolean) getAttributeInternal(HIJOR);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute HijoR
     */
    public void setHijoR(Boolean value) {
        setAttributeInternal(HIJOR, value);
    }

    /**Gets the attribute value for the calculated attribute NietoR
     */
    public Boolean getNietoR() {
        return (Boolean) getAttributeInternal(NIETOR);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute NietoR
     */
    public void setNietoR(Boolean value) {
        setAttributeInternal(NIETOR, value);
    }

    /**Gets the attribute value for the calculated attribute ObservacionesR
     */
    public Boolean getObservacionesR() {
        return (Boolean) getAttributeInternal(OBSERVACIONESR);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute ObservacionesR
     */
    public void setObservacionesR(Boolean value) {
        setAttributeInternal(OBSERVACIONESR, value);
    }
}
