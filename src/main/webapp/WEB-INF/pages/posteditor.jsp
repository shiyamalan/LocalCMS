<%--
  Created by IntelliJ IDEA.
  User: brusoth
  Date: 4/23/16
  Time: 12:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Add New Post</title>

<link rel="stylesheet" href="resources/css/theme.css">
<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script>
	tinymce.init({
		selector : 'textarea'
	});
</script>
</head>
<body>
	<form:form class="w3-center" method="post"
		action="${pageContext.request.contextPath}/post/edit"
		enctype="multipart/form-data" modelAttribute="post">
		<h1>Enter New Post Information in given field</h1>
		<table class="w3-table w3-striped" style="width: 80%;">
			<tr>
				<td><h3>Enter Post Title</h3></td>
			</tr>
			<tr>
				<td><form:hidden path="blog_post_id" /> <form:input
						style="width: 80%;" id="post-title" path="title"
						placeHolder="Enter Post Title" name="post-title"
						value='${post.title}'></form:input> <br /></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>

			<tr>
				<td><h3>Please select cover image to upload</h3></td>
			</tr>
			<tr>
				<td><input id="post-file" type="file" name="image" /></td>
			</tr>

			<tr>
				<td><br /></td>
			</tr>
			<tr>

				<td>
					<div style="width: 100%;">
						<textarea class="ckeditor" name="content" id="post-content"
							cols="35" rows="10"><c:out value="{$post.content}"/>
						</textarea>

					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="rich-text-btn-group" class="btn-group btn-group-sm">
						<button id="preview-button" type="submit" name="action"
							value="preview" class="btn btn-primary btn-sm">Preview</button>
						<button id="drafts-button" type="submit" name="action"
							value="draft" class="btn btn-primary btn-sm">Save as
							Drafts</button>
						<button id="rp-button" type="submit" name="action"
							class="btn btn-primary btn-sm" value="publish">Ready to
							Publish?</button>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>
