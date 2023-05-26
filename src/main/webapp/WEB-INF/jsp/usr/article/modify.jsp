<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE MODIFY" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<hr />

<!-- Article modify 관련 -->
<script type="text/javascript">
	let ArticleModify__submitFormDone = false;

	function ArticleModify__submit(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}

		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}

		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();

		if (markdown.length == 0) {
			alert('내용 써라');
			editor.focus();
			return;
		}

		form.body.value = markdown;

		ArticleModify__submitFormDone = true;
		form.submit();

	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<form action="../article/doModify" method="POST" onsubmit="ArticleModify__submit(this); return false;">
				<input type="hidden" name="body">
				<input type="hidden" name="id" value="${article.id }" />
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<th>번호</th>
							<td>
								<div class="badge">${article.id}</div>
							</td>
						</tr>
						<tr>
							<th>작성날짜</th>
							<td>${article.regDate }</td>
						</tr>
						<tr>
							<th>수정날짜</th>
							<td>${article.updateDate }</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${article.extra__writer }</td>
						</tr>
								<th>게시판</th>
						
						<td>
								<select class="select select-ghost w-full max-w-xs" name="boardId">
									<c:if test="${rq.loginedMember.authLevel >= 7}">
										<option value="1">레터링</option>
										<option value="2">미니타투</option>
										<option value="3">블랙워크</option>
										<option value="4">ETC</option>
									</c:if>
									<c:if test="${rq.loginedMember.authLevel >= 3}">
										<option value="5">타투문의</option>
										<option value="6">자유</option>
										<option value="7">QNA</option>
										<option value="8">타투후기</option>
									</c:if>
								</select>
							</td>
						<tr>
							<th>제목</th>
							<td>
								<input class="input input-bordered w-full max-w-xs" type="text" name="title" placeholder="제목을 입력해주세요"
									value="${article.title }" />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<%-- 								<textarea class="input input-bordered w-full max-w-xs" type="text" name="body" placeholder="내용을 입력해주세요" />${article.body }</textarea> --%>
								<div class="toast-ui-editor">
									<script type="text/x-template">${article.body }
      </script>
								</div>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
									<button class="custom-btn btn-7" type="submit">수정</button>
							</td>
						</tr>
					</tbody>

				</table>
			</form>
		</div>
		<div class="btns">
		<button class="custom-btn btn-7" type="button" onclick="history.back();">뒤로가기</button>

	</div>
</section>

<style>

.container {
margin-top: 200px;
font-family: 'SUITE-Regular', sans-serif;}

.btns {
	margin-top: 50px;
	margin-left: 1000px;
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

.btn-7:before, .btn-7:after {
	position: absolute;
	content: "";
	left: 0;
	width: 100%;
	height: 50%;
	right: 0;
	z-index: -1;
	background: #5C5470;
	transition: all 0.3s ease;
	border-radius: 10px;
}

.btn-7:before {
	top: 0;
}

.btn-7:after {
	bottom: 0;
}

.btn-7:hover:before, .btn-7:hover:after {
	height: 0;
	background-color: #000;
}

</style>

<%@ include file="../common/foot.jspf"%>