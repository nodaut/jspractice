<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>

<html>
	<body>
		<% String inputData=request.getParameter("q");%>
		<%System.out.println(inputData); %>
		<div>
			<p>This is ajaxJspFile paragraph</p>
			<p><%=inputData%></p>
		</div>
	</body>
</html>