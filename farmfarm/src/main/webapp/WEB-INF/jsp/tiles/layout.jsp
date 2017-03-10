<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>

div.container {	width: 100%; position: relative;
	/* 맨처음 배경 */
	background-image: url("https://t3.ftcdn.net/jpg/00/63/32/40/240_F_63324036_xdL5dIBN3zGGyprnacLVQ9N9xzSwJCx6.jpg"); 
	
	/* background-image: url(""); */
	/* 나뭇잎 이미지 */
	/* background-image: url("http://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory&fname=http%3A%2F%2Fcfile23.uf.tistory.com%2Fimage%2F222FCF3F523674C6019778"); */
	
	/* 마리오 배경 */
	/* background-image: url("http://blogfiles.naver.net/20120508_195/sjk3142_1336488324742tc4yi_JPEG/supermario.jpg"); */
	
	/* 부엉이집 일러스트 */
	/* background-image: url("http://cfs5.tistory.com/upload_control/download.blog?fhandle=YmxvZzEyODI1MEBmczUudGlzdG9yeS5jb206L2F0dGFjaC8wLzA1MDAwMDAwMDAwMi5qcGc%3D"); */ 
	
	/* 일러스트1*/
	/*  background-image: url("http://cfs4.tistory.com/upload_control/download.blog?fhandle=YmxvZzEyODI1MEBmczQudGlzdG9yeS5jb206L2F0dGFjaC8wLzA1MDAwMDAwMDAxNy5qcGc%3D"); */  
	
	/* 나뭇잎 이미지 2 */
	/* background-image: url("http://www.kunggu.com/resize/resize-img.php?src=http://www.kunggu.com/images/Rendering/foliage-autumn-sprig-shines-bubbles1235.jpg&h=600&w=800"); */  
	
	/* 나비 일러스트*/
	/* background-image: url("http://cfile8.uf.tistory.com/image/261A053E518AFA2F2743B0"); */  
	
	/* 가을 허수아비 일러스트*/
	/* background-image: url("http://cfile22.uf.tistory.com/image/265AEA345267544D06028A"); */  
	

	background-repeat: no-repeat; 
 	background-size: 100% 150%;
	/* background-size: cover; */
	}
header {	padding: 1em; clear: left;	text-align: center;}
footer {	padding: 1em; text-align: center; margin: 0 auto; }
nav { width: 1000px;	margin: 0 auto;	padding: 1em;}
nav ul { margin: 0;	list-style-type: none;	padding: 0;}
nav ul a { margin: 0;	text-decoration: none;}
article { 
	width: 100%; min-height: 705px;  padding: 1em; overflow: hidden;

}
#header1 {
    width: 100%;
    height: 58px;
    text-align: center;
	}
a { color:black; }
a { text-decoration: none; }
a:hover { text-decoration: none;}

</style>
</head> 
<body style="overflow: scroll; ">
	<div class="container">
		<header>
			<div id="wrap">
			<div id="header1" >
				<a href="${pageContext.request.contextPath}/crops/farmMap.do" class="link"><img src="<c:url value='/images/makeImage/logo/fnfarmlogo.png' />" width="250" height="70" alt="egovframe"></a>
				 
				<span style="margin-left:30px; font-size:12px; ">
					<c:if test="${sessionScope.loginInfo != null}">
					${loginInfo.mbrId }님 환영합니다. <a href="${pageContext.request.contextPath }/mbr/logout.do"><b>로그아웃</b></a>
					</c:if>
					<c:if test="${loginInfo == null }">
						<span id="loginLink"><a href="${pageContext.request.contextPath}/mbr/loginView.do" class="link">로그인</a></span>
						<span><a href="${pageContext.request.contextPath}/mbr/addMbrView.do" class="link">회원가입</a></span>
					</c:if>
					
					
				</span>
				
			</div>
			</div>
		</header>
		<nav>
			<tiles:insertAttribute name="header" />
		</nav>
		<article>
			<tiles:insertAttribute name="content" />
		</article>
		<footer>
			<tiles:insertAttribute name="footer" />
		</footer>
	</div>
</body>
</html>