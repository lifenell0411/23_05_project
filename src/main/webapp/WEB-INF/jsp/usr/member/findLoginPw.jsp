<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Find LoginPw" />
<%@ include file="../common/head.jspf"%>
<hr />

<script type="text/javascript">
let MemberFindLoginPw__submitFormDone = false;
function MemberFindLoginPw__submit(form) {
	if (MemberFindLoginPw__submitFormDone) {
		return;
	}
	form.name.value = form.name.value.trim();
	form.email.value = form.email.value.trim();
	if (form.name.value.length == 0) {
		alert('이름 써라');
		form.name.focus();
		return;
	}
	if (form.email.value.length == 0) {
		alert('email 써라');
		form.email.focus();
		return;
	}
	MemberFindLoginPw__submitFormDone = true;
	form.submit();
}
</script>
 


<div class="container">
	<div class="login-box">
		<h2>FindLoginId</h2>
<form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this); return false;">
	<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri }" />
			<div class="user-box">
					<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="아이디를 입력해주세요"
									name="loginId" />
				<label>LoginId</label>
			</div>
			<div class="user-box">
			<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="이메일을 입력해주세요"
									name="email" />
				<label>Email</label>
			</div>
			<button type="submit">비밀번호 찾기</button>
				 
		</form>
	</div>
</div>

<style>
.container {
margin-top: 200px}


.button-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 10px;
}

body {
	height: 100%;
	margin: 0;
	font-family: "Fira Sans", sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	background-attachment: fixed;
}

.container {
	max-width: 960px;
	margin: auto;
	position: relative;
	top: calc(50vh - 150px);
	/* 로그인박스 높이의 절반인 150px만큼 상위 요소 중앙 위치에서 아래로 이동 */
}

.login-box {
	width: 400px;
	padding: 40px;
	background: rgba(0, 0, 0, 0.5);
	box-sizing: border-box;
	box-shadow: 0 15px 25px rgba(0, 0, 0, 0.6);
	border-radius: 10px;
	position: relative;
	margin: 0 auto; /* 로그인박스 가운데 정렬 */
	margin-top: 100px;
	transform: translate(-10%, -30%);
}

.login-box h2 {
	margin: 0 0 30px;
	padding: 0;
	color: #fff;
	text-align: center;
}

.login-box .user-box {
	position: relative;
}

.login-box .user-box input {
	width: 100%;
	padding: 10px 0;
	font-size: 16px;
	color: #fff;
	margin-bottom: 30px;
	border: none;
	border-bottom: 1px solid #fff;
	outline: none;
	background: transparent;
}

.login-box .user-box label {
	position: absolute;
	top: 0;
	left: 0;
	padding: 10px 0;
	font-size: 16px;
	color: #DBD8E3;
	pointer-events: none;
	transition: 0.5s;
}

.login-box .user-box input:focus ~ label, .login-box .user-box input:valid 
	 ~ label {
	top: -20px;
	left: 0;
	color: #DBD8E3;
	font-size: 12px;
}

.login-box button {
	position: relative;
	display: inline-block;
	padding: 10px 20px;
	color: #DBD8E3;
	font-size: 16px;
	text-decoration: none;
	text-transform: uppercase;
	overflow: hidden;
	transition: 0.5s;
	margin-top: 40px;
	letter-spacing: 4px;
	background: transparent;
	border: 2px solid #DBD8E3;
	border-radius: 5px;
	box-shadow: 0 0 5px #DBD8E3;
	cursor: pointer;
}

.login-box button:hover {
	background: #DBD8E3;
	color: #fff;
	box-shadow: 0 0 5px #DBD8E3, 0 0 25px #DBD8E3, 0 0 50px #DBD8E3, 0 0
		100px #DBD8E3;

}

</style>
<%@ include file="../common/foot.jspf"%>