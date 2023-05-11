<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>

<script>
	let submitJoinFormDone = false;
	let validLoginId = "";

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value == 0) {
			alert('아이디를 입력해주세요');
			return;
		}

		if (form.loginId.value != validLoginId) {
			alert('사용할 수 없는 아이디입니다');
			form.loginId.focus();
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요');
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			return;
		}
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해주세요');
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			return;
		}
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요');
			return;
		}
		submitJoinFormDone = true;
		form.submit();
	}

	function checkLoginIdDup(el) {
	    $('.checkDup-msg').empty();
	    const form = $(el).closest('form').get(0);

	    const regExp = /^[a-zA-Z0-9]+$/; // 영어와 숫자로만 이루어져 있는지 확인하는 정규식

	    if (form.loginId.value.length < 5) {
	        $('.checkDup-msg').html('<div class="mt-2">아이디를 5글자 이상 입력해주세요.</div>');
	        validLoginId = '';
	        return;
	    } else if (!regExp.test(form.loginId.value)) { // 입력된 아이디가 영어와 숫자로만 이루어져 있는지 확인
	        $('.checkDup-msg').html('<div class="mt-2">아이디는 영어와 숫자로만 구성될 수 있습니다.</div>');
	        validLoginId = '';
	        return;
	    }

	    $.get('../member/getLoginIdDup', {
	        isAjax : 'Y',
	        loginId : form.loginId.value
	    }, function(data) {
	        $('.checkDup-msg').html('<div class="mt-2">' + data.msg + '</div>')
	        if (data.success) {
	            validLoginId = data.data1;
	        } else {
	            validLoginId = '';
	        }
	    }, 'json');
	}

</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../member/doJoin" onsubmit="submitJoinForm(this); return false;">
			<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
			<table class="table table-zebra w-full">
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th style="background-color: #917FB3;">아이디</th>
						<td style="background-color: white;">
							<input name="loginId" class="w-full input input-bordered max-w-xs"
								placeholder="아이디를 입력해주세요" autocomplete="off" onblur="checkLoginIdDup(this)" />
							<div class="checkDup-msg"></div>
						</td>
					</tr>
					<tr>
						<th style="background-color: #917FB3;">비밀번호</th>
						<td style="background-color: white;">
							<input name="loginPw" class="w-full input input-bordered max-w-xs"
								placeholder="비밀번호를 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th style="background-color: #917FB3;">비밀번호 확인</th>
						<td style="background-color: white;">
							<input name="loginPwConfirm" class="w-full input input-bordered max-w-xs"
								placeholder="비밀번호 확인을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th style="background-color: #917FB3;">이름</th>
						<td style="background-color: white;">
							<input name="name" class="w-full input input-bordered max-w-xs"
								placeholder="이름을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th style="background-color: #917FB3;">닉네임</th>
						<td>
							<input name="nickname" class="w-full input input-bordered max-w-xs"
								placeholder="닉네임을 입력해주세요" />
						</td>
					</tr>
					<tr >
						<th style="background-color: #917FB3;">전화번호</th>
						<td style="background-color: white;" >
							<input name="cellphoneNum" class="w-full input input-bordered max-w-xs"
								placeholder="전화번호를 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th style="background-color: #917FB3;">이메일</th>
						<td>
							<input name="email" class="w-full input input-bordered max-w-xs"
								placeholder="이메일을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th style="background-color: #917FB3;"></th>
						<td style="background-color: white;">
							<button class="btn btn-active btn-ghost" type="submit" value="회원가입">회원가입</button>
						</td>
					</tr>
				</tbody>
			</table>
	 
		</form>
	</div>

 

<style>

 body {
  background-color: #FDE2F3;
  height: 705px; /* 높이 */
}

.table-box-type-1 {
  width: 100%;
  max-width: 800px;
  margin: 0 auto;
}

.table-box-type-1 table {
  border-collapse: collapse;
  width: 100%;
  top: 100px;
}

.table-box-type-1 th,
.table-box-type-1 td {
  border: none;
  padding: 0.5rem;
  text-align: left;
}

th {
  background-color: #917FB3;
  color: #fff;
  font-weight: bold;
  text-align: center;
}

.table-box-type-1 input {
  display: block;
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 0.25rem;
  margin-bottom: 0.5rem;
}

.checkDup-msg {
  margin-top: 0.5rem;
  font-size: 0.875rem;
  color: #d64040;
}

.btn {
  display: inline-block;
  border: 1px solid #ccc;
  padding: 0.5rem 1rem;
  border-radius: 0.25rem;
  text-align: center;
  font-size: 1rem;
  line-height: 1.5;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn:hover {
  background-color: #f2f2f2;
}

.btn-active {
  background-color: #917FB3;
  color: #fff;
  border-color: #917FB3;
}

.btn-ghost {
  background-color: transparent;
  color: #917FB3;
}

.btn-ghost:hover {
  background-color: #f2f2f2;
}
 

</style>
</section>
<%@ include file="../common/foot.jspf"%>