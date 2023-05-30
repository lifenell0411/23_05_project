<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.code}" />
<%@ include file="../common/head.jspf"%>
<hr />
  
<section class="text-xl">
	<div class="container ">
		<div class="table-box-type-1">
			<div class="flex mb-4">
				<div>
					게시물 갯수 :
					<span class="badge">${articlesCount }</span>
					개
				</div>
				<div class="flex-grow"></div>
				<form action="">
					<input type="hidden" name="boardId" value="${param.boardId }" />
					<select data-value="${param.searchKeywordTypeCode }" name="searchKeywordTypeCode" class="select select-ghost">
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="title,body">제목 + 내용</option>
					</select>
					<input value="${param.searchKeyword }" maxlength="20" name="searchKeyword" class="input input-bordered" type="text"
						placeholder="검색어를 입력해주세요" />
					<button class="btn-text-link btn btn-active btn-ghost" type=submit>검색</button>
				</form>
			</div>
		<div class="table-wrapper">
   <c:choose>
    <c:when test="${boardId >= 1 && boardId <= 4}">
        <!-- 그리드 형식 -->
        <div class="grid grid-cols-3 gap-4">
            <c:forEach var="article" items="${articles}">
                <div class="grid-item">
                    <div class="badge">${article.id}</div>
                    <div class="image-preview">
                        <img src="${rq.getImgUri(article.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
                    </div>
                    <div class="back">
                        <div>
                       
                                    <a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article)}">${article.title}</a>
                               
                        </div>
                        <div>작성자: ${article.extra__writer}</div>
                        <div>조회수: ${article.hitCount}</div>
                        <div>찜: ${article.likePoint}</div>
                        <div>작성날짜: ${article.regDate.substring(2, 16)}</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <!-- 리스트 형식 -->
        <table class="table table-zebra">
            <colgroup>
                <col width="140" />
                <col width="140" />
                <col width="140" />
                <col width="140" />
                <col width="140" />
                <col width="140" />
                <col width="140" />
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>날짜</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>싫어요</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="article" items="${articles}">
                    <tr class="hover">
                        <td>
                            <div class="badge">${article.id}</div>
                        </td>
                        <td>${article.regDate.substring(2, 16)}</td>
                        <td>
                            
                                    <a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article)}">${article.title}</a>
                          
                        </td>
                        <td>${article.extra__writer}</td>
                        <td>${article.hitCount}</td>
                        <td>${article.goodReactionPoint}</td>
                        <td>${article.badReactionPoint}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

</div>

		</div>
	</div>
</section>

		<div class="pagination flex justify-center mt-3">
		<div class="btn-group">

			<c:set var="paginationLen" value="4" />
				<c:set var="startPage" value="${page - paginationLen >= 1 ? page - paginationLen : 1}" />
				<c:set var="endPage" value="${page + paginationLen <= pagesCount ? page + paginationLen : pagesCount}" />

				<c:if test="${startPage > 1 }">
					<a class="btn" href="?page=1&boardId=${boardId }">1</a>
					<button class="btn btn-disabled">...</button>
				</c:if>

				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="btn ${page == i ? 'btn btn-secondary' : '' }" href="?page=${i }&boardId=${boardId }">${i }</a>
				</c:forEach>

				<c:if test="${endPage < pagesCount }">
					<button class="btn btn-disabled">...</button>
					<a class="btn" href="?page=${pagesCount }&boardId=${boardId }">${pagesCount }</a>
				</c:if>
			</div>
		</div>
 
	
 
		<a class="custom-btn btn-7" href="../article/write">글쓰기</a>
 
 


<style>
.container{
margin-top: 300px;
		color: #2A2438;
		  font-family: 'SUITE-Regular', sans-serif;
}

 
    btn{
    color: white;}
 
    }
 body {
      margin: 0;
      padding: 0;
       overflow: hidden;
 	
       background-color: #FDE2F3;
       height: 100%; 
    }
  button {
    margin: 20px;
    outline: none;
      border-radius: 10px;
      
       
  }
  
  .custom-btn {
    width: 130px;
    height: 40px;
    padding: 10px 25px;
    border: 2px solid #000;
    font-family: 'SUITE-Regular', sans-serif;
    font-weight: 500;
    background: transparent;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    display: inline-block;
    text-align: center; /* 가운데 정렬을 위한 속성 추가 */
        text-decoration: none; /* 밑줄 제거 */
        border-radius: 10px;
        left: 1350px;
  }
  
  .btn-7 {
    background: #5C5470;
    color: #fff;
    line-height: 42px;
    padding: 0;
    border: none;
    z-index: 1;
    -webkit-transition: all 0.3s linear;
    transition: all 0.3s linear;
      border-radius: 10px;
  }
  
  .btn-7:hover {
    background: transparent;
    color: #000;
        text-decoration: none; /* 밑줄 제거 */
          border-radius: 10px;
  }
  
  .btn-7:before,
  .btn-7:after {
    position: absolute;
    content: "";
    left: 0;
    width: 100%;
    height: 50%;
    right: 0;
    z-index: -1;
    background:  #5C5470;
    transition: all 0.3s ease;
      border-radius: 10px;
  }
  
  .btn-7:before {
    top: 0;
  }
  
  .btn-7:after {
    bottom: 0;
  }
  
  .btn-7:hover:before,
  .btn-7:hover:after {
    height: 0;
    background-color: #000;
 
 
  }

     .image-preview img {
        width: 100%;
        height: 400px; /* 원하는 높이로 설정하세요 */
        object-fit: cover;
    }

 .back {
		background-color: rgba(255, 255, 255, 0.5); 
 }
</style>
 
<%@ include file="../common/foot.jspf"%>