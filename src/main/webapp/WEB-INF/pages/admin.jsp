<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title><fmt:message key="web.app.admin" /></title>
<link rel="stylesheet" href="resources/css/theme.css" type="text/css" />
</head>

<body>
	<div class="container">
		<div id="wrapper">
			<h3>Admin Panel</h3>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li class="active"><a href="/LocalCMS/WEB-INF/pages/home.jsp"
					role="tab" data-toggle="tab"> <icon class="fa fa-home"></icon>
						Home
				</a></li>
				<li><a href="/editors" role="tab" data-toggle="tab"> <i
						class="fa fa-user"></i> Editors
				</a></li>
				<li><a href="logout" role="tab" data-toggle="tab"> <i
						class="fa fa-user"></i> Logout
				</a></li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane fade active in" id="home">
					<h2>Create Editor</h2>
					<c:if test="${not empty msg}">
						<div id="success-alert"
							class="alert alert-success alert-dismissible">
							<button type="button" class="close" data-dismiss="alert"
								aria-hidden="true">x</button>
							<h4>
								<i class="icon fa fa-check"></i> User Created!
							</h4>
							User created successfully.
						</div>
					</c:if>
					<c:if test="${not empty error}">
						<div id="success-alert"
							class="alert alert-error alert-dismissible">
							<button type="button" class="close" data-dismiss="alert"
								aria-hidden="true">x</button>
							<h4>
								<i class="icon fa fa-check"></i> Error While Creating User!
							</h4>
							${error}
						</div>
					</c:if>
					<form:form class="well" method="post" modelAttribute="userForm"
						action="${pageContext.request.contextPath}/user/create">
						<spring:bind path="username">
							<div class="form-group row  ${status.error ? 'has-error' : ''}">
								<label for="example-text-input" class="col-xs-2 col-form-label">Username</label>
								<div class="col-xs-10">
									<form:input path="username" class="form-control" type="text"
										value="" id="username" />
									<form:errors path="username" class="control-label" />
								</div>
							</div>
						</spring:bind>
						<div class="form-group row ${status.error ? 'has-error' : ''}">
							<label for="example-password-input"
								class="col-xs-2 col-form-label">Password</label>
							<div class="col-xs-10">
								<form:input path="password" class="form-control" type="password"
									value="" id="password" />
								<form:errors path="password" class="control-label" />
							</div>
						</div>
						<button type="submit" id="c-editor" class="btn btn-primary">Create
							Editor</button>
					</form:form>
				</div>
				<div class="tab-pane fade" id="editors">
					<h2>Editors</h2>
					<table class="w3-table w3-striped">
						<thead>
							<tr>
								<th>Name</th>
								<th>Action</th>
							</tr>
							<c:forEach var="user" items="${userList}">
								<tr>
									<td>${user.username}</td>
									<td><c:choose>
											<c:when test="${user.enabled}">
												<button name="suspend" value="${user.username}"
													class="btn btn-info"
													onclick="location.href='${pageContext.request.contextPath}/user/suspend?suspend=${user.username}&enabled=${user.enabled}'">Suspend</button>
											</c:when>
											<c:otherwise>
												<button name="suspend" value="${user.username}"
													class="btn btn-info"
													onclick="location.href='${pageContext.request.contextPath}/user/suspend?suspend=${user.username}&enabled=${user.enabled}'">Enable</button>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</thead>
					</table>
				</div>
				<div class="tab-pane fade" id="approvals">
					<h2>Approvals</h2>
				</div>
				<div class="tab-pane fade" id="posts">
					<a href="${pageContext.request.contextPath}/post/view">View
						Posts</a>
				</div>
			</div>
		</div>

	</div>
	</div>
	<script>
		jQuery(document).ready(function($) {
			//        if($('#username').val() == '' || $('#password').val() == ''){
			//            $('#c-editor').prop("disabled",true);
			//        } else {
			//            $('#c-editor').prop("disabled",false);
			//        }

			//        $(document.body).on('input', '#username,#password' ,function(){
			//            if($('#username').val() == '' || $('#password').val() == ''){
			//                $('#c-editor').prop("disabled",true);
			//            } else {
			//                $('#c-editor').prop("disabled",false);
			//            }
			//        });

			$("#success-alert").fadeTo(2000, 500).slideUp(500, function() {
				$("#success-alert").alert('close');
			});

		});
	</script>
</body>
</html>
