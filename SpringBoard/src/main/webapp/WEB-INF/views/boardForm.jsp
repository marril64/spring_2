<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 글쓸때, 제목 글쓴이, 본문을 채우고 submit을 눌러야 합니다.
	vo에 적힌 명칭을 감안해서 제목, 글쓴이, 본문을 쓸 수 있도록 폼태그를 완성시켜주세요. -->
	<form action="/board/insert" method="post">
		글쓴이 : <input type="text" name="writer" required><br/>
		제목 : <input type="text" name="title" required><br/>
		본문 : <textarea name="content" required></textarea><br/>
		<input type="submit" value="제출">
	</form>
</body>
</html>