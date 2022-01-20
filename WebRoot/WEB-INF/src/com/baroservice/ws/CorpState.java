/**
 * CorpState.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.baroservice.ws;

/*
 * 단일건의 휴폐업 조회를 했을 경우
 */
public class CorpState  implements java.io.Serializable {
    private java.lang.String corpNum;

    private int taxType;

    private int state;

    private java.lang.String stateDate;

    private java.lang.String baseDate;

    public CorpState() {
    }

    public CorpState(
		   java.lang.String corpNum, /* 사업자 번호 */
		   int taxType,				 /* 과세구분 */ 
		   int state,				 /* 휴폐업상태 */
		   java.lang.String stateDate, /* 휴폐업 일자 */
		   java.lang.String baseDate) { /* 기준일자 */
    	
           this.corpNum = corpNum;
           this.taxType = taxType;
           this.state = state;
           this.stateDate = stateDate;
           this.baseDate = baseDate;
    }


    /**
     * Gets the corpNum value for this CorpState.
     * 
     * @return corpNum
     */
    public java.lang.String getCorpNum() {
        return corpNum;
    }


    /**
     * Sets the corpNum value for this CorpState.
     * 
     * @param corpNum
     */
    public void setCorpNum(java.lang.String corpNum) {
        this.corpNum = corpNum;
    }


    /**
     * Gets the taxType value for this CorpState.
     * 
     * @return taxType
     */
    public int getTaxType() {
        return taxType;
    }


    /**
     * Sets the taxType value for this CorpState.
     * 
     * @param taxType
     */
    public void setTaxType(int taxType) {
        this.taxType = taxType;
    }


    /**
     * Gets the state value for this CorpState.
     * 
     * @return state
     */
    public int getState() {
        return state;
    }


    /**
     * Sets the state value for this CorpState.
     * 
     * @param state
     */
    public void setState(int state) {
        this.state = state;
    }


    /**
     * Gets the stateDate value for this CorpState.
     * 
     * @return stateDate
     */
    public java.lang.String getStateDate() {
        return stateDate;
    }


    /**
     * Sets the stateDate value for this CorpState.
     * 
     * @param stateDate
     */
    public void setStateDate(java.lang.String stateDate) {
        this.stateDate = stateDate;
    }


    /**
     * Gets the baseDate value for this CorpState.
     * 
     * @return baseDate
     */
    public java.lang.String getBaseDate() {
        return baseDate;
    }


    /**
     * Sets the baseDate value for this CorpState.
     * 
     * @param baseDate
     */
    public void setBaseDate(java.lang.String baseDate) {
        this.baseDate = baseDate;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof CorpState)) return false;
        CorpState other = (CorpState) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.corpNum==null && other.getCorpNum()==null) || 
             (this.corpNum!=null &&
              this.corpNum.equals(other.getCorpNum()))) &&
            this.taxType == other.getTaxType() &&
            this.state == other.getState() &&
            ((this.stateDate==null && other.getStateDate()==null) || 
             (this.stateDate!=null &&
              this.stateDate.equals(other.getStateDate()))) &&
            ((this.baseDate==null && other.getBaseDate()==null) || 
             (this.baseDate!=null &&
              this.baseDate.equals(other.getBaseDate())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getCorpNum() != null) {
            _hashCode += getCorpNum().hashCode();
        }
        _hashCode += getTaxType();
        _hashCode += getState();
        if (getStateDate() != null) {
            _hashCode += getStateDate().hashCode();
        }
        if (getBaseDate() != null) {
            _hashCode += getBaseDate().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(CorpState.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ws.baroservice.com/", "CorpState"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("corpNum");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "CorpNum"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("taxType");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "TaxType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("state");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "State"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("stateDate");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "StateDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("baseDate");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "BaseDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
