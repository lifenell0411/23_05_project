<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MYPAGE" />
<%@ include file="../common/head.jspf"%>
 <%@ page import="com.KoreaIT.bjw._05_project.util.Ut"%>
<hr />
<section class="mt-8 text-xl">
 <div class ="title">My Page</div>
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
						<a href="../member/checkPw?replaceUri=${Ut.getEncodedUri('../member/modify')}" class="btn btn-active btn-ghost">회원정보 수정</a>

						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

</section>
<div class="flex-grow"></div>

<div class="likeList">찜한 게시글</div>
<div class="table-wrapper table1">
    <table class="table-zebra">
        <colgroup>
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
            <c:forEach var="article" items="${likeArticles}">
                <tr class="hover">
                    <td>
                        <div class="badge">${article.id}</div>
                    </td>
                    <td>${article.regDate.substring(2, 16)}</td>
                    <td>
                        <a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article)}">${article.title}</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination flex justify-center mt-3">
    <div class="btn-group">
        <c:set var="paginationLen" value="4" />
        <c:set var="startPage" value="${likePage - paginationLen >= 1 ? likePage - paginationLen : 1}" />
        <c:set var="endPage" value="${likePage + paginationLen <= likePagesCount ? likePage + paginationLen : likePagesCount}" />

        <c:if test="${startPage > 1}">
            <a class="btn" href="?boardId=${boardId}&likePage=1">1</a>
            <button class="btn btn-disabled">...</button>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
            <a class="btn ${likePage == pageNum ? 'btn btn-secondary' : ''}" href="?boardId=${boardId}&likePage=${pageNum}">${pageNum}</a>
        </c:forEach>

        <c:if test="${endPage < likePagesCount}">
            <button class="btn btn-disabled">...</button>
            <a class="btn" href="?boardId=${boardId}&likePage=${likePagesCount}">${likePagesCount}</a>
        </c:if>
    </div>
</div>


<div class="flex-grow"></div>

<div class="likeList">나의 게시글</div>
<div class="table-wrapper table1">
    <table class="table-zebra">
        <colgroup>
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
            <c:forEach var="article" items="${myArticles}">
                <tr class="hover">
                    <td>
                        <div class="badge">${article.id}</div>
                    </td>
                    <td>${article.regDate.substring(2, 16)}</td>
                    <td>
                        <a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article)}">${article.title}</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination flex justify-center mt-3">
    <div class="btn-group">
        <c:set var="paginationLen" value="4" />
        <c:set var="startPage" value="${myPage - paginationLen >= 1 ? myPage - paginationLen : 1}" />
        <c:set var="endPage" value="${myPage + paginationLen <= myPagesCount ? myPage + paginationLen : myPagesCount}" />

        <c:if test="${startPage > 1}">
            <a class="btn" href="?boardId=${boardId}&myPage=1">1</a>
            <button class="btn btn-disabled">...</button>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
            <a class="btn ${myPage == pageNum ? 'btn btn-secondary' : ''}" href="?boardId=${boardId}&myPage=${pageNum}">${pageNum}</a>
        </c:forEach>

        <c:if test="${endPage < myPagesCount}">
            <button class="btn btn-disabled">...</button>
            <a class="btn" href="?boardId=${boardId}&myPage=${myPagesCount}">${myPagesCount}</a>
        </c:if>
    </div>
</div>

<style>

@font-face {
	font-family: 'SUITE-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2')
		format('woff2');
	font-weight: 400;
	font-style: normal;
}
	.table-wrapper {
		width: 830px; /* 원하는 가로 길이로 조정하세요 */
	}

	.table-wrapper table {
		width: 830px; /* 테이블의 가로 길이 */
	}

	.table-wrapper td {
		width: 830px; /* 각 셀의 가로 길이 조정 (원하는 비율로 조정하세요) */
	}
.container, .likeList, .table1{

font-family: 'SUITE-Regular', sans-serif;

}

.title {
 font-size:30px;
 
margin-left:  600px;
margin-top: 150px;
 
}
 .likeList{
 font-size:30px;
 
margin-left:  600px;
margin-top: 50px;}
 
 
 
.table-wrapper {
    margin-left: 400px;
    width: 600px;
}
 
.table1 {
 margin-top: 20px;
margin-left: 600px;
    
    }
.custom-table {
	border-spacing: 0;
	width: 100%;
	border: none;
	margin-left: 200px;
	margin-top: 30px;
	 
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