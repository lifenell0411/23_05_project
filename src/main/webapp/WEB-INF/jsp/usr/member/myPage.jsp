<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MYPAGE" />
<%@ include file="../common/head.jspf"%>
c
<hr />
<section class="mt-8 text-xl">
	<div class="container">
		<div class="table-box-type-1" style="max-width: 800px;">
			<table class="custom-table">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th>가입일</th>
						<td>${rq.loginedMember.regDate }</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${rq.loginedMember.loginId }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${rq.loginedMember.name }</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>${rq.loginedMember.nickname }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${rq.loginedMember.cellphoneNum }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${rq.loginedMember.email }</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<a href="../member/checkPw?replaceUri=${Ut.getEncodedUri('../member/modify') }" class="btn btn-active btn-ghost">회원정보
								수정</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

</section>
<div class="flex-grow"></div>

<div class ="likeList">찜한 게시글</div>
<div class="table-wrapper table1">
	<table class=" table-zebra">
		<colgroup>
			<col width="70" />
			<col width="70" />
			<col width="70" />
			<col width="70" />
			<col width="70" />
			<col width="70" />

		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
		 


			</tr>
		</thead>

 
		<tbody>
			<c:forEach var="article" items="${articles}">
				<tr class="hover">
					<td>
						<div class="badge">${article.id}</div>
					</td>
					<td>${article.regDate.substring(2,16)}</td>
					<td>
						<a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article) }">${article.title}</a>
					</td>
			 

				</tr>
			</c:forEach>
		</tbody>
 
	</table>
</div>
 

<style>
 .likeList{
 font-size:30px;
 
margin-left:  600px;
margin-top: 50px;}
 
 
 
.table-wrapper {
    margin-left: 400px;
    width: 600px;
}
 
.table1 {
 margin-top: 50px;
margin-left: 600px;
    
    }
.custom-table {
	border-spacing: 0;
	width: 100%;
	border: none;
	margin-left: 200px;
	margin-top: 200px;
}

.like {
	width: 100px;
	height: 100px;
	background-color: red;
	border: 3px solid black;
	margin-left: 300px;
}

th, td {
	border: none;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #5C5470;
	font-weight: bold;
	color: white;
}

tr:nth-child(even) {
	background-color: white;
}

tr:nth-child(odd) {
	background-color: white;
}
</style>
<%@ include file="../common/foot.jspf"%>