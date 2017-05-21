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
</head>
<body>
	<ul class="nav nav-tabs" role="tablist">
		<li class="active"><a href="/" role="tab" data-toggle="tab">
				<icon class="fa fa-home"></icon> Home
		</a></li>
		<li><a href="post/create" role="tab" data-toggle="tab"> <i
				class="fa fa-user"></i> New Post
		</a></li>
		<li><a href="logout" role="tab" data-toggle="tab"> <i
				class="fa fa-user"></i> Logout
		</a></li>
	</ul>
	<div>
		<c:if test="${!empty posts}">
			<table class="w3-table w3-striped " style="">
				<thead>
					<tr>
						<th width="100">Post ID</th>
						<th width="200">Post Title</th>
						<th width="100">Post Created At</th>
						<th width="100">Post Author</th>
						<th width="80">Post Status</th>
						<th width="80">Post Preview</th>
						<th width="80">Edit Post</th>
					</tr>
				</thead>
				<c:forEach items="${posts}" var="post">
					<tbody>
						<tr>
							<td>${post.blog_post_id}</td>
							<td>${post.title}</td>
							<td>${post.created}</td>
							<td>${post.username}</td>
							<td>${post.status}</td>
							<td><a href="<c:url value='/post/preview/${post.blog_post_id}' />">Preview</a></td>
							<td><a href="<c:url value='/post/edit/${post.blog_post_id}' />">Edit</a></td>
							
						</tr>
					</tbody>
				</c:forEach>


			</table>
		</c:if>
	</div>
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
