<%@ page contentType = "text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.URL" %>
<%
 	//String resourcePath = "http://openapi.okdab.com/price/realtime/pricexml_class_action.jsp?key=4f52e6c2d4ffb5e17973b62d813b6d74d81d91b&date=20151024%20";
	String[] number = {"110001","110003","110005","110008"};
	//System.out.println(number.length);
	BufferedReader br = null;
	char[] buff = new char[512];
	int len = -1;
	
	for(int i=0; i <= number.length -1 ; i++) {
		
		String resourcePath ="http://data.mafra.go.kr:7080/openapi/sample/xml/Grid_20141221000000000123_1/1/5?WHSAL_MRKT_CD=" + number[i];
		System.out.println(resourcePath);
		try {
			URL url = new URL(resourcePath);
			
			br = new BufferedReader(
				new InputStreamReader(
					url.openStream() ));
			while ( (len = br.read(buff)) != -1) {
				out.print(new String(buff, 0, len));
			}
		} catch(IOException ex) {
			out.println("익셉션 발생: "+ex.getMessage());
		} finally {
			if (br != null) try { br.close(); } catch(IOException ex) {}
		}
	}
%>

