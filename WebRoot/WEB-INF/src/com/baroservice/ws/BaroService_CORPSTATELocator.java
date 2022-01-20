/**
 * BaroService_CORPSTATELocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.baroservice.ws;

public class BaroService_CORPSTATELocator extends org.apache.axis.client.Service implements com.baroservice.ws.BaroService_CORPSTATE {

/**
 * 바로빌 휴폐업조회 서비스
 */

    public BaroService_CORPSTATELocator() {
    }


    public BaroService_CORPSTATELocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public BaroService_CORPSTATELocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for BaroService_CORPSTATESoap
    private java.lang.String BaroService_CORPSTATESoap_address = "http://testws.baroservice.com/CORPSTATE.asmx";

    public java.lang.String getBaroService_CORPSTATESoapAddress() {
        return BaroService_CORPSTATESoap_address;
    }
    // The WSDD service name defaults to the port name.
    private java.lang.String BaroService_CORPSTATESoapWSDDServiceName = "BaroService_CORPSTATESoap";

    public java.lang.String getBaroService_CORPSTATESoapWSDDServiceName() {
        return BaroService_CORPSTATESoapWSDDServiceName;
    }

    public void setBaroService_CORPSTATESoapWSDDServiceName(java.lang.String name) {
        BaroService_CORPSTATESoapWSDDServiceName = name;
    }

    public com.baroservice.ws.BaroService_CORPSTATESoap getBaroService_CORPSTATESoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(BaroService_CORPSTATESoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getBaroService_CORPSTATESoap(endpoint);
    }

    public com.baroservice.ws.BaroService_CORPSTATESoap getBaroService_CORPSTATESoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.baroservice.ws.BaroService_CORPSTATESoapStub _stub = new com.baroservice.ws.BaroService_CORPSTATESoapStub(portAddress, this);
            _stub.setPortName(getBaroService_CORPSTATESoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setBaroService_CORPSTATESoapEndpointAddress(java.lang.String address) {
        BaroService_CORPSTATESoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.baroservice.ws.BaroService_CORPSTATESoap.class.isAssignableFrom(serviceEndpointInterface)) {
                com.baroservice.ws.BaroService_CORPSTATESoapStub _stub = new com.baroservice.ws.BaroService_CORPSTATESoapStub(new java.net.URL(BaroService_CORPSTATESoap_address), this);
                _stub.setPortName(getBaroService_CORPSTATESoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("BaroService_CORPSTATESoap".equals(inputPortName)) {
            return getBaroService_CORPSTATESoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://ws.baroservice.com/", "BaroService_CORPSTATE");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://ws.baroservice.com/", "BaroService_CORPSTATESoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("BaroService_CORPSTATESoap".equals(portName)) {
            setBaroService_CORPSTATESoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
