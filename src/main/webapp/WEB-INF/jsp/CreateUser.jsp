<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath}/css/forms.css" --%>
<!-- 	rel="stylesheet"> -->

<style type="text/css">
body, html {
	height: 100%;
}

body {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0;
	margin: 0;
}

.form-signin {
	width: 100%;
	max-width: 330px;
	padding: 15px;
	margin: auto;
}

.line-container {
	position: relative;
	width: 100%;
	text-align: center;
	margin-top: 20px; /* Adjust the margin top as needed */
}

.line {
	border-top: 1px solid #000; /* Change color and thickness as needed */
	width: 100%;
}

/* Style for the text */
.line-text {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: #fff; /* Match background color of your page */
	padding: 0 10px; /* Adjust padding as needed */
}

.register {
	margin-top: 20px;
}

#returnLogin {
	margin-top: 20px;
}
</style>


<title>Create an account</title>

</head>
<body>
	<main class="form-signin">
		<form action="create_user" method="post">

			<h1 class="h3 mb-3 fw-normal">Create an account</h1>
			<div class="form-floating">
				<input type="text" class="form-control" id="username"
					name="username" placeholder="Username" required> <label
					for="username">Username</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="floatingPassword"
					name="password" placeholder="Password" required> <label
					for="floatingPassword">Password</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="firstname"
					name="firstname" placeholder="First Name" required> <label
					for="firstname">First Name</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="lastname"
					name="lastname" placeholder="Last Name" required> <label
					for="lastname">Last Name</label>
			</div>
			<div class="form-floating">
				<input type="email" class="form-control" id="email" name="email"
					placeholder="Email" required> <label for="Email">Email</label>
			</div>
			<div class="form-floating">
				<input type="tel" class="form-control" id="phonenumber"
					pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" name="phonenumber"
					placeholder="Phone Number" required> <label
					for="phonenumber">Phone Number</label>
			</div>
			<div class="form-floating">
				<input type="date" class="form-control" id="dob" name="dob"
					placeholder="DoB" required> <label for="dob">Date
					of Birth</label>
			</div>
			<p>
				<span id="successMessage"><b>${messages.success}</b></span>
			</p>
			<p>
				<span id="successMessage"><b>${messages.error}</b></span>
			</p>
			<button class="btn btn-primary w-100 py-2" type="submit">Create
				account</button>
		</form>

		<a id="returnLogin" class="btn btn-primary w-100 py-2" href="login">Return
			to login</a>
	</main>
</body>
</html>