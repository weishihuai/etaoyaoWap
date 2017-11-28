<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="articleProxy" value="${sdk:getArticleById(param.infArticleId)}"/>

<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-文章内容</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/newsDetail.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <style>
        img{max-width:100%;height: auto; }
        table{max-width:100%; height: auto;}
        p{font-size: 16px;}
        .item{font-size: 16px;}
    </style>
</head>
<body>

<div class="m-top">
    <a class="back" href="javascript:void(0);" onclick="history.go(-1);"></a>
    <div class="toggle-box" style=" width: 7rem; height: 1rem; margin: auto; overflow: hidden; text-overflow: ellipsis;  white-space: nowrap; font-size:14px">${articleProxy.title}</div>
</div>

<div class="item" style="background: #fff;margin-top: 1.40875rem;">
    <div class="title" style="text-align: center;">${articleProxy.title}</div>

    <div style="padding: 0.1375rem;background: #fff;">${articleProxy.articleCont}</div>
</div>
</body>
</html>