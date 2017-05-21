<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Title</title>
<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script>
	tinymce.init({
		selector : 'textarea'
	});
</script>
<link rel="stylesheet" href="resources/css/theme.css">

<style>
.button {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	margin: 4px 2px;
	cursor: pointer;
}



.addButton {
	font-size: 24px;
}
</style>
</head>
<body>
	<div class="container">
		<div id="wrapper">

			<!-- Page Content -->
			<!-- <div id="page-content-wrapper"> -->
			<%-- 			<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<c:forEach var="post" items="${posts}">
								<div class="panel panel-default project-list">
									<div class="panel-heading">
										<h3>
											<c:out value="${post.title}" />
										</h3>
										<span class="tag tag-default"><h6>
												<c:out value="${post.status}" />
											</h6></span>
										<p>
											Publish Date: <input type="text" id="datepicker">
										</p>
									</div>
									</div>
									<div class="panel-body">
										<p>
											<c:out value="${post.content}" />
										</p>
										<br>
									</div>
									<div class="panel-footer">
										<div class="row">
											<form class="col-md-2"
												action="${pageContext.request.contextPath}/post/state"
												method="post">
												<input type="hidden" name="id" value="${post.blog_post_id}"
													readonly="readonly" /> <input type="hidden" name="date"
													id="date" value="${post.publish}">
												<button type="submit" name="action"
													class="btn btn-primary btn-sm" value="change">change
													status</button>
											</form>
											<form class="col-md-2"
												action="${pageContext.request.contextPath}/post/previews"
												method="post">
												<input type="hidden" name="id" value="${post.blog_post_id}"
													readonly="readonly" />
												<button type="submit" name="action"
													class="btn btn-primary btn-sm" value="change">Preview</button>
											</form>
											<form class="col-md-2"
												action="${pageContext.request.contextPath}/post/edit"
												method="post">
												<input type="hidden" name="id" value="${post.blog_post_id}"
													readonly="readonly" />
												<button type="submit" name="action"
													class="btn btn-primary btn-sm" value="change">Edit</button>
											</form>
										</div>
									</div>
								</div>
							</c:forEach>
							<div id="cover-image" style="background-image: url(${post.image_path})">

						</div>
					</div>
				</div>
			</div>
			<!-- /#page-content-wrapper -->
		</div> --%>

			<div>
				<c:if test="${!empty posts}">
					<table class="w3-table w3-striped " style="" >
						<thead>
							<tr>
								<th width="100">Post ID</th>
								<th width="200">Post Title</th>
								<th width="100">Post Created At</th>
								<th width="100">Post Author</th>
								<th width="80">Post PreView</th>
								<th width="80">Post Status</th>
							</tr>
						</thead>
						<c:forEach items="${posts}" var="post">
							<tbody >
								<tr>
									<td>${post.blog_post_id}</td>
									<td>${post.title}</td>
									<td>${post.created}</td>
									<td>${post.username}</td>
									<td><a href="<c:url value='/post/preview/${post}' />">Edit</a></td>
									<td><a href="<c:url value='/post/edit/${person.id}' />">Delete</a></td>
									<td><select>
											<option value="1">Draft</option>
											<option value="3">Ready to publish</option>
									</select></td>
								</tr>
							</tbody>
						</c:forEach>


					</table>
				</c:if>
			</div>
		</div>
		
		<div>
			<button class="button addButton">25px</button>
		</div>
		<script>
			jQuery(document).ready(function($) {
				$("#drafts-button").click(function(event) {
					savePost();
				});

				$("#preview-button").click(function(event) {
					openPreview();
				});
			});

			$(function() {
				var $datepicker = $('#datepicker');
				$datepicker.datepicker();
				$datepicker.datepicker('setDate', new Date());
			});

			$("#datepicker").datepicker({
				onSelect : function(dateText) {
					$('input[name="date"]').val($("#datepicker").datepicker({
						dateFormat : 'yy-mm-dd'
					}).val());

				}
			});

			function openPreview() {

			}

			function savePost() {
				var data = {};
				data["title"] = $("#post-title").val();
				data["content"] = $("#post-content").val();

				$.ajax({
					type : "POST",
					contentType : "application/json",
					url : "post/add",
					data : JSON.stringify(data),
					dataType : 'json',
					timeout : 100000,
					success : function(data) {
						console.log("SUCCESS: ", data);
						display(data);
					},
					error : function(e) {
						console.log("ERROR: ", e);
						display(e);
					},
					done : function(e) {
						console.log("DONE");
					}
				});
			}
		</script>
</body>
</html>
