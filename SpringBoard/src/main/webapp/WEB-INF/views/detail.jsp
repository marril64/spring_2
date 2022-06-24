<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/resttest/modal.css">
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
	<a href="/board/list?page=${param.page}&searchType=${param.searchType}&keyword=${param.keyword}"><button class="btn btn-primary">목록으로 돌아가기</button></a>
	<form action="/board/updateForm" method="post">
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="hidden" name="page" value="${param.page}">
		<input type="hidden" name="searchType" value="${param.searchType}">
		<input type="hidden" name="keyword" value="${param.keyword}">
		<input type="submit" value="수정하기">
	</form>
	<!-- 삭제용 폼을 만들어주면 됩니다.
	post방식으로 컨트롤러의 delete로직을 호출하면 되고,
	글번호를 bno라는 이름에 담아서 보내주도록 하면 됩니다. -->
	<form action="/board/delete" method="post">
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="hidden" name="page" value="${param.page}">
		<input type="hidden" name="searchType" value="${param.searchType}">
		<input type="hidden" name="keyword" value="${param.keyword}">
		<input type="submit" value="삭제하기">
	</form>
	<!-- <form action="/board/list" method="get">
		<input type="submit" value="목록으로 돌아가기">
	</form> -->
	
	<div class="row box-box-success text-center">
		<div class="box-header col-md-12">
			<h2 class="text-primary">댓글 작성</h2>
		</div>
		<div class="box-body col-md-12">
			<strong>Writer</strong>
			<input type="text" name="replyer" id="newReplyWriter" class="form-control">
			<strong>ReplyText</strong>
			<input type="text" name="reply" id="newReplyText" class="form-control">
		</div>
		<div class="box-footer col-md-12">
			<button type="button" class="btn btn-success" id="replyAddBtn">Add Reply</button>
		</div>
	</div>
	
	<!-- <ul id="replies"></ul> -->
	
		<div class="row">
			<h3 class="text-primary">댓글</h3>
			<div id="replies">
				<!-- 댓글이 들어갈 위치 -->
			</div>
		</div><!-- /.row -->
	
	<!-- 댓글쓰기 shift + tab = 뒤로가기 -->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="replyText">
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">Delete</button>
			<button type="button" id="closeBtn">Close</button>
		</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		let bno = ${board.bno};
		
		function getAllList() {
			$.getJSON("/replies/all/" + bno, function(data) {
				
				let str = "";
				
				console.log(data.length);
				
				$(data).each(
					function() {
						
						let timestamp = this.updateDate; // UNIX시간을 우리가 알고있는 형식으로 바꿔보겠습니다.
						let date = new Date(timestamp); // UNIX시간이 저장된 timestamp를 Date 생성자로 변환합니다.
						
						
						let formattedTime = `게시일 : \${date.getFullYear()}년
													\${(date.getMonth() + 1)}월
													\${date.getDate()}일`;
						
						str += `<div class='replyLi' data-rno='\${this.rno}'>
									<strong>@\${this.replyer}</strong> - \${formattedTime}<br>
									<div class='replytext'>\${this.reply}</div>
									<button type='button' class='btn btn-info'>수정/삭제</button>
								</div>`
						
						// console.log(this);
						// str += `<li data-rno='\${this.rno}' class='replyLi'>\${this.rno} \${this.replyer} \${this.reply}<button>수정/삭제</button></li>`;
					});
				$("#replies").html(str);
			});
		}
		
		getAllList();
		
		$("#replies").on("click", ".replyLi button", function() {
			// 선택 요소와 연관된 태그 고르기
			// 1. prev().prev... 등과 같이 연쇄적으로 prev, next를 걸어서 고르기
			// 2. prev("태그선택자") 를 써서 뒤쪽이나 앞쪽 형제 중 조건에 맞는것만 선택
			// 3. siblings("태그선택자")는 next, prev 모두를 범위로 조회합니다.
			//let reply = $(this).parent();
			let rno = $(this).parent().attr("data-rno");
			let reply = $(this).siblings(".replytext");
			let replytext = reply.text(); // $(this).prev().html() 도 된다.
			
			$(".modal-title").html(rno);
			$("#replyText").val(replytext);
			$("#modDiv").show("slow");
			
		});
		
		// 글 등록 로직
		$("#replyAddBtn").on("click", function() {
			
			let replyer = $("#newReplyWriter").val();
			let reply = $("#newReplyText").val();
			
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					reply : reply
				}),
				success : function(result) {
					if (result === "Success") {
						alert("등록되었습니다.");
						getAllList();
						$("#newReplyWriter").val('');
						$("#newReplyText").val('');
					}
				},
				error : function(result) {
					if (result.statusText === "error") {
						alert("등록에 실패하였습니다.");
					}
				}
			});
		});
	
	</script>
	<script src="/resources/resttest/delete.js"></script>
	<script src="/resources/resttest/modify.js"></script>
	<script src="/resources/resttest/modalclose.js"></script>
</body>
</html>