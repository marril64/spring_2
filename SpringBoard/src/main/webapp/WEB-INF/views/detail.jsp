<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row text-center">
			<div class="col-md-3">
				글번호<br/>
				${board.bno}
			</div>
			<div class="col-md-3">
				글쓴이<br/>
				${board.writer}
			</div>
			<div class="col-md-3">
				작성일<br/>
				${board.regDate}
			</div>
			<div class="col-md-3">
				수정일<br/>
				${board.updateDate}
			</div>
		</div>
		<hr/>
		<div class="card row">
		  <div class="card-body text-center col-md-12">
		    <h5 class="card-title">${board.title}</h5>
		    <p class="card-text">${board.content}</p>
		  </div>
		</div>
	</div>
	<br/>
	<a href="/board/list"><button class="btn btn-primary">목록으로 돌아가기</button></a>
	<form action="/board/updateForm" method="post">
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="submit" value="수정하기">
	</form>
	<!-- 삭제용 폼을 만들어주면 됩니다.
	post방식으로 컨트롤러의 delete로직을 호출하면 되고,
	글번호를 bno라는 이름에 담아서 보내주도록 하면 됩니다. -->
	<form action="/board/delete" method="post">
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="submit" value="삭제하기">
	</form>
	<!-- <form action="/board/list" method="get">
		<input type="submit" value="목록으로 돌아가기">
	</form> -->
</body>
</html>