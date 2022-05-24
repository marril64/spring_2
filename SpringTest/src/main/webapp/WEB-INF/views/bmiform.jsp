<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/bmi" method="post">
		<input type="number" name="cm" required>cm<br/>
		<input type="number" name="weight" required>kg<br/>
		<input type="submit" value="bmi 측정">
	</form>
</body>
</html>