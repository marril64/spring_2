<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- .css, .js, 그림파일 등은 src/main/webapp/resources폴더 아래에 저장한 다음
	/resources/경로 형식으로 적으면 가져올 수 있습니다.
	이렇게 경로가 자동으로 잡히는 이유는 servlet-context.xml에 설정이 잡혀있기 때문입니다. -->
	<link rel="stylesheet" href="/resources/resttest/modal.css">
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
	
	<ul id="replies">
	
	</ul>
	<!-- <button id="ajaxRequestBtn">비동기 요청</button> -->
	
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
						str += `<li data-rno='\${this.rno}' class='replyLi'>\${this.rno}:\${this.reply}<button>수정/삭제</button></li>`;
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
						str += `<li data-rno='\${this.rno}' class='replyLi'>\${this.rno} \${this.replyer} \${this.reply}<button>수정/삭제</button></li>`;
					});
				$("#replies").html(str);
			});
		}
		
		getAllList();
		
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
			}); // 전체가 javascript의 객체, JSON의 형식과 비슷하다.
		}); // 글 등록 로직 종료
		
		// 이벤트 위임                 replyLi를 걸쳐서 넣을수도, 다이렉트로 넣을수도 있다.
		
		// 1. ul#replies가 이벤트를 걸고 싶은 버튼 전체의 집합이므로 먼저 집합 전체에 이벤트를 겁니다.
		// 2. #replies의 하위 항목중 최종 목표 태그를 기입해줍니다.
		// 3. 단, 여기서 #replies와 button 사이에 다른 태그가 끼어있다면 경유하는 형식으로 호출해도 됩니다.
		$("#replies").on("click", ".replyLi button", function() {
			// 4. 콜백함수 내부의 this는 내가 클릭한 button이 됩니다.
			
			// .attr("태그 내 속성명") => 해당 속성에 부여된 값을 가져옵니다.
			// ex) <li data-rno="33"> => rno에 33을 저장해줍니다.
			let reply = $(this).parent(); // this 키워드를 쓸 생각이라면 화살표함수를 쓰면 안된다.
			           // this 키워드가 속한 곳은 button이며 즉, this(button)의 부모는 li태그이다.
			let rno = reply.attr("data-rno"); // attr는 괄호 안의 자료("data-rno")를 받아올 수 있다.
			let replytext = reply.text(); // text()는 위 reply 안의 모든 문자열을 불러온다는 의미이다.
			
			// alert(rno + " : " + replytext);
			$(".modal-title").html(rno);
			$("#replyText").val(replytext);
			$("#modDiv").show("slow");
		});
	</script>
	
</body>
</html>