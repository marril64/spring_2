<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table table-primary table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="board" items="${list}">
				<tr>
					<td>${board.bno}</td>
					<td><a href="/board/detail?bno=${board.bno}&page=${pageMaker.cri.page}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">${board.title}<span class="badge badge-danger">[5]</span></a></td>
					<td>${board.writer}</td>
					<td>${board.regDate}</td>
					<td>${board.updateDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="/board/insert"><button class="btn btn-primary">글쓰기</button></a>
	
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.prev}">
			<li class="page-item">
				<a class="page-link" href="http://localhost:8181/board/list?page=${pageMaker.startPage - 1}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}" aria-label="Previous">
			    	<span aria-hidden="true">&laquo;</span>
			    </a>
			</li>
		</c:if>
		<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="page-item ${pageMaker.cri.getPage() eq pageNum ? 'active' : ''}">
				<a class="page-link" href="http://localhost:8181/board/list?page=${pageNum}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}" aria-label="Previous">
			    	<span aria-hidden="true">${pageNum}</span>
			    </a>
		    </li>
		</c:forEach>
		<c:if test="${pageMaker.next}">
			<li class="page-item">
				<a class="page-link" href="http://localhost:8181/board/list?page=${pageMaker.endPage + 1}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}" aria-label="Previous">
			    	<span aria-hidden="true">&raquo;</span>
			    </a>
			</li>
		</c:if>
	</ul>
	
	<!-- 검색창 위치 -->
	<select name="searchType">
		<option value="n" ${pageMaker.cri.searchType == null ? 'selected' : ''}>
			none
		</option>
		<option value="t" ${pageMaker.cri.searchType == 't' ? 'selected' : ''}>
			제목
		</option>
		<option value="c" ${pageMaker.cri.searchType == 'c' ? 'selected' : ''}>
			본문
		</option>
		<option value="w" ${pageMaker.cri.searchType == 'w' ? 'selected' : ''}>
			작성자
		</option>
		<option value="tc" ${pageMaker.cri.searchType == 'tc' ? 'selected' : ''}>
			제목 + 본문
		</option>
		<option value="cw" ${pageMaker.cri.searchType == 'cw' ? 'selected' : ''}>
			본문 + 글쓴이
		</option>
		<option value="tcw" ${pageMaker.cri.searchType == 'tcw' ? 'selected' : ''}>
			제목 + 본문 + 글쓴이
		</option>
	</select>
	
	<input type="text" name="keyword" id="keywordInput" value="${pageMaker.cri.keyword}">
	<button id="searchBtn">검색</button>
	${pageMaker}
	
	<script>
		$('#searchBtn').on('click', function(event){
			self.location = 'list'
				+ '?page=1'
				+ '&searchType='
				+ $('select option:selected').val()
				+ '&keyword=' + $('#keywordInput').val();
		})
	</script>
	
</body>
</html>