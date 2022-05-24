<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- form을 만들어주세요.
	목적지는 /cToF이며 전송메서드는 post입니다.
	cel이라는 number 타입의 input을 이용해 온도를 입력받으며
	제출버튼을 누르면 해당 주소에 post방식으로 접근해 폼 내부의 온도를 전달하고
	그 결과를 화면에 뿌려줍니다. -->
	<form action="/cToF" method="post">
		섭씨온도 : <input type="number" name="cel" required>
		<input type="submit" value="화씨온도 구하기">
	</form>
</body>
</html>