<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${article.title }" />
<%@ include file="../common/head.jspf"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 변수 생성 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
</script>

<!-- 조회수 관련 -->
<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);
		$.get('../article/doIncreaseHitCount', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
</script>

<!-- 변수 값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
<script>
	function checkAddRpBefore() {
		if (isAlreadyAddGoodRp == true) {
			$('#likeButton').removeClass('btn-outline').addClass('btn-danger');
		} else if (isAlreadyAddBadRp == true) {
			$('#DislikeButton').removeClass('btn-outline').addClass('btn-danger');
		} else {
			return;
		}
	};
</script>

<!-- 리액션 실행 코드 -->
<script>
	$(function() {
		ArticleDetail__increaseHitCount();
	});
	
	$(function() {
		checkAddRpBefore();
		});
</script>

<!-- 좋아요, 싫어요 관련 -->
<script>
	function doGoodReaction(articleId) {
		$.ajax({
            url: '/usr/reactionPoint/doGoodReaction',
            type: 'POST',
            data: {relTypeCode: 'article', relId: articleId},
            dataType: 'json',
            success: function(data) {
                if (data.resultCode.startsWith('S-')) {
                    var likeButton = $('#likeButton');
                    var likeCount = $('#likeCount');
                    var DislikeButton = $('#DislikeButton');
                    var DislikeCount = $('#DislikeCount');

                    if (data.resultCode == 'S-1') {
                        likeButton.removeClass('btn-danger').addClass('btn-outline');
                        likeCount.text(parseInt(likeCount.text()) - 1);
                    } 
                    else if (data.resultCode == 'S-2') {
                    	DislikeButton.removeClass('btn-danger').addClass('btn-outline');
                        DislikeCount.text(parseInt(DislikeCount.text()) - 1);
                        likeButton.removeClass('btn-outline').addClass('btn-danger');
                        likeCount.text(parseInt(likeCount.text()) + 1);
                    }
                    else {
                        likeButton.removeClass('btn-outline').addClass('btn-danger');
                        likeCount.text(parseInt(likeCount.text()) + 1);
                    }
                  
                } 
                else {
                    alert(data.msg);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('오류가 발생했습니다: ' + textStatus);
            }
        });
	}
	
	function doBadReaction(articleId) {
		$.ajax({
            url: '/usr/reactionPoint/doBadReaction',
            type: 'POST',
            data: {relTypeCode: 'article', relId: articleId},
            dataType: 'json',
            success: function(data) {
                if (data.resultCode.startsWith('S-')) {
                	var likeButton = $('#likeButton');
                    var likeCount = $('#likeCount');                	
                    var DislikeButton = $('#DislikeButton');
                    var DislikeCount = $('#DislikeCount');

                    if (data.resultCode == 'S-1') {
                    	DislikeButton.removeClass('btn-danger').addClass('btn-outline');
                    	DislikeCount.text(parseInt(DislikeCount.text()) - 1);
                    } else if (data.resultCode == 'S-2') {
                    	likeButton.removeClass('btn-danger').addClass('btn-outline');
                    	likeCount.text(parseInt(likeCount.text()) - 1);
                    	DislikeButton.removeClass('btn-outline').addClass('btn-danger');
                        DislikeCount.text(parseInt(DislikeCount.text()) + 1);
                    } else {
                    	DislikeButton.removeClass('btn-outline').addClass('btn-danger');
                        DislikeCount.text(parseInt(DislikeCount.text()) + 1);
                    }
                } 
                else {
                    alert(data.msg);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('오류가 발생했습니다: ' + textStatus);
            }
        });
	}
</script>

<section class="text-xl">
	<div class="container">
		<div class="table-box-type-1">
			<table border="1">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr >
						<th class="table-header">번호</th>
						<td class="table-cell">
							<div class="badge">${article.id}</div>
						</td>

					</tr>
					<tr>
						<th class="table-header">작성날짜</th>
						<td class="table-cell">${article.regDate }</td>
					</tr>
					<tr>
						<th class="table-header">수정날짜</th>
						<td class="table-cell">${article.updateDate }</td>
					</tr>
					<tr>
						<th class="table-header">작성자</th>
						<td class="table-cell">${article.extra__writer }</td>
					</tr>
					<tr>
						<th class="table-header">조회수</th>
						<td class="table-cell">
							<span class="article-detail__hit-count">${article.hitCount }</span>
						</td>
					</tr>

					<tr>
						<c:if test="${article.boardId eq 6 || article.boardId eq 7 || article.boardId eq 8}">
							<tr>
								<th class="table-header">추천</th>
								<td class="table-cell">
									 
									 
								 
										<div class="btn_box">
				<button id="likeButton" class="btn btn-outline" type="button" onclick="doGoodReaction(${param.id})">
				    좋아요 👍
				  <span id="likeCount">${article.goodReactionPoint}</span>
				</button>
				
				<button id="DislikeButton" class="btn btn-outline" type="button" onclick="doBadReaction(${param.id})">
				    싫어요 👎
					<span id="DislikeCount">${article.badReactionPoint}</span>
				</button>
			</div> 
									</c:if>
									<c:if test="${article.boardId eq 1 || article.boardId eq 2 || article.boardId eq 3 || article.boardId eq 4}">
							<tr>
								<th class="table-header">찜하기</th>
								<td class="table-cell">
									<span>&nbsp;찜하기 : ${article.likePoint }&nbsp;</span>
								 
									<c:if test="${actorCanMakeLike}">
										<div>
											<span>
												<span>&nbsp;</span>
												<a
													href="/usr/likePoint/doLikePoint?relTypeCode=article&relId=${param.id }&replaceUri=${rq.encodedCurrentUri}"
													class="btn btn-xs btn-error">찜하기❤</a>
											</span>
											 
										</div>
									</c:if>
									<c:if test="${actorCanCancelLike }">
										<div>
											<span>
												<span>&nbsp;</span>
												<a
													href="/usr/likePoint/doCancelLikePoint?relTypeCode=article&relId=${param.id }&replaceUri=${rq.encodedCurrentUri}"
													class="btn btn-xs btn-error">찜하기❤ 취소</a>
											</span>
											
										</div>
									</c:if>
									
								</td>
							</tr>
						</c:if>
						
						
						
					<tr>
						<th class="table-header">제목</th>
						<td class="table-cell">${article.title }</td>
					</tr>
					<tr>
						<th class="table-header">내용</th>
						<td class="table-cell">${article.body }</td>
					</tr>
				</tbody>

			</table>
		</div>
	 

		<br />
		 
			
				<c:if test="${rq.getLoginedMemberId()==article.memberId }">
						<a class="btn btn-outline" href="../article/modify?id=${article.id }">수정</a>
						<a class="btn btn-outline" onclick="if(confirm('정말 삭제하시겠습니까?')==false) return false;"
								href="doDelete?id=${article.id }">삭제</a>
				</c:if>
				<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
</div>

<%@ include file="../common/foot.jspf"%>