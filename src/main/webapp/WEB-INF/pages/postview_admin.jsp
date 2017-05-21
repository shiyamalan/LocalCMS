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

	<div>
		<c:if test="${!empty posts}">
			<table class="w3-table w3-striped " style="" align="center">
				<thead>
					<tr>
						<th width="100">Post ID</th>
						<th width="200">Post Title</th>
						<th width="100">Post Created At</th>
						<th width="100">Page Status</th>
						<th width="100">Post Author</th>
						<th width="80">Post PreView</th>
						<th width="80">Post Status</th>
					</tr>
				</thead>
				<c:forEach items="${posts}" var="post">
					<tbody>
						<tr>
							<td id="post_id">${post.blog_post_id}</td>
							<td>${post.title}</td>
							<td>${post.created}</td>
							<td>${post.username}</td>
							<td>${post.status}</td>
							<td><a
								href="<c:url value='/post/preview/${post.blog_post_id}'/>">Preview</a></td>
							<%-- 	<td><a href="<c:url value='/post/edit/${post.blog_post_id}' />">Preview</a></td> --%>
							<form:form>
								<td>
									<form class="" action="post/state" method="post">
										<input type="hidden" name="id" value="${post.blog_post_id}"
											readonly="readonly" /> <input type="hidden" name="date"
											id="date" value="${post.publish}">
										<button type="submit" name="action"
											class="btn btn-primary btn-sm" value="change">Move
											To Next Status{Draft->Ready->Publish->Archive}</button>
									</form>
									<form action="/LocalCMS/post/edit/${post.blog_post_id}" method="GET">
										<button type="submit" name="action"
											class="btn btn-primary btn-sm">Edit Post</button>
									</form>
								</td>
							</form:form>
						</tr>
					</tbody>
				</c:forEach>


			</table>
		</c:if>
	</div>
	<script>
		function changeStatus(postId) {
			var selectBox = document.getElementById("statusCombo");
			var selectedValue = selectBox.options[selectBox.selectedIndex].value;

			var answer = confirm("Are you going to change status?")
			if (answer) {
				var data = {};
				data["status"] = selectedValue;
				data["id"] = postId;

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
			} else {

			}
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
