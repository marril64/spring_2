<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>Ajax 테스트</h2>
	
	
	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			REPLY TEXT <input type="text" name="reply" id="newReplyText">
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
	
	<!-- <ul id="replies">
	
	</ul> -->
	<!-- <button id="ajaxRequestBtn">비동기 요청</button> -->
	
	<!-- jquery는 이곳에 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		let bno = 262157;
		// let str = "";
		
		// 버튼 클릭시
		$("#ajaxRequestBtn").on("click", function() {
			// json 데이터를 얻어오는 로직 실행
			$.getJSON("/replies/all/" + bno, function(data){
				let str = "";
				$(data).each(
					function() {
						console.log(this);
						// 백틱 문자열 사이에 변수를 넣고 싶다면 \${변수명} 을 적습니다.
						// 원래는 \를 왼쪽에 붙일 필요는 없지만
						// jsp에서는 el표기문법이랑 겹치기 때문에 el이 아님을 보여주기 위해
						// 추가로 왼쪽에 \를 붙입니다.
						// str += `이게 문자열임 '\${this.rno}' 진짜임.</br>`;
						/*str += "<li data-rno='" + this.rno + "' class='replyLi'>"
							+ this.rno + ":" + this.reply + "</li>";*/
						// 필요한 데이터만 주고받을 수 있다. (데이터 경량화)
						str += `<li data-rno='\${this.rno}' class='replyLi'>\${this.rno}:\${this.reply}</li>`;
				});
				// 필요없을 수도 있는 데이터를 필요시에만 가져온다.
				console.log(str);
				$("#replies").html(str);
				
			});
			
		});
		
		// 댓글 전체 불러오기
		function getAllList() {
			$.getJSON("/replies/all/" + bno, function(data) {
				
				let str = "";
				console.log(data.length);
				
				$(data).each(
					function() {
						str += `<li data-rno='\${this.rno}' class='replyLi'>\${this.rno}:\${this.reply}</li>`;
					});
				$("#replies").html(str);
			});
		}
		
		// getAllList();
		
		// 글 등록 로직
		$("#replyAddBtn").on("click", function() {
			
			let replyer = $("#newReplyWriter").val();
			let reply = $("#newReplyText").val();
			
			$.ajax({ // 원래 기본형은 $.ajax() 이나 상세설명을 위해 아래의 정보를 추가해준다.
				type : 'post',
				url : '/replies',
				headers : { // header 로 적으면 415 뜬다.
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
					}
				},
				error : function(result) {
					if (result.statusText === "error") {
						alert("등록에 실패하였습니다.");	
					}
				}
			}); // 전체가 javascript의 객체, JSON의 형식과 비슷하다.
		}); // 글 등록 로직 종료
	</script>
	
</body>
</html>