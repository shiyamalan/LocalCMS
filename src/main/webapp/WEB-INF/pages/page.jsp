<%@ include file="/common/include.jsp" %>
<head>
    <title>Preview</title>
</head>
<body>
<div style="height: 600px; overflow: auto;">
    <div id="wrapper" class="fill">
        <div class="fill" align="center">
            <br>
            <div class="cover">
                <h1>${post.title}</h1>
                <img id="ItemPreview" src="data:image/png;base64,<c:out value='${post.imageSrc}'/>" />
            </div>
            <div class="content well">
                <h3>${post.content}</h3>
            </div>
        </div>
    </div>
</div>
</body>

