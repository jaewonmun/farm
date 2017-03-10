<%@page import="java.io.*,java.net.*" contentType="text/xml; charset=UTF-8" %><%

String urlOkdap = request.getParameter("queryString");

StringBuffer sbf = new StringBuffer();
try{
	System.out.println(urlOkdap);
    URL url = new URL(urlOkdap);
    BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
    String inputLine;
    while( (inputLine = in.readLine() ) != null ) sbf.append(inputLine);
} catch( Exception e ) {   
	e.printStackTrace();
}
%><%= sbf.toString() %>