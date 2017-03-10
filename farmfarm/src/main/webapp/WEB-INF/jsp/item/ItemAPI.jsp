<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.net.*,org.w3c.dom.*,javax.xml.parsers.*" %>
<%
String str_URL = "http://openapi.okdab.com/price/realtime/pricexml_class_action.jsp?key=4f52e6c2d4ffb5e17973b62d813b6d74d81d91b&date=20161024";
URL url = new URL(str_URL);
DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
Document doc = docBuilder.parse(url.openStream());
Element elem = doc.getDocumentElement();

NodeList node_list = elem.getElementsByTagName("result");
int len = node_list.getLength();
out.write("<select size=10>");
for(int i=0;i<len ;i++){   
node_list = elem.getElementsByTagName("code");
String code = node_list.item(i).getFirstChild().getNodeValue();
node_list = elem.getElementsByTagName("name");
String name = node_list.item(i).getFirstChild().getNodeValue();
out.write("<option value='" + code + "'>"+name);
}
out.write("</select>");
%>

