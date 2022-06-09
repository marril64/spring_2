<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- detail페이지에서 폼 양식을 가져온 다음
	얻어온 글에 대한 정보를 끼워넣어주세요. -->
	<form action="/board/update" method="post">
		<input type="text" name="title" value="${board.title}"><br/>
		<input type="text" name="writer" value="${board.writer}"><br/>
		<textarea name="content">${board.content}</textarea><br/>
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="submit" value="수정하기">
	</form>
</body>
</html>