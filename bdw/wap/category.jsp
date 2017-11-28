<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--查询所有的商品分类--%>
<c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>

<!DOCTYPE html>
<html style="font-size: 11.71875px;">
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">
    <title>分类-${webName}</title>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header2.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/category.css" type="text/css" rel="stylesheet"/>

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/category.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            var $li = $("input[value=${param.categoryId}]").parent();
            $li.css("border", "2px solid red");
            $li.css("text-shadow", "0 1px 0 #FFFFFF");
            $li.css("box-shadow", "0 0 5px #FF4848");
            $li.find("img").attr("src", "${param.imgUrl}");
            $('html, body').animate({
                scrollTop: $li.offset().top
            }, 2000);
            $("a").attr("href", "javascript:;");
            var body = $("body");
            body.css("max-width", "640px");
            body.css("margin-left", "auto");
            body.css("margin-top", "0");
            body.css("margin-right", "auto");
            body.css("margin-bottom", "0");
            var footer_links = $(".footer-links");
            footer_links.css("width", "32rem");
            footer_links.css("left", "50%");
            footer_links.css("margin-left", "-16rem");
            resizeFontSize();
        });
    </script>
</head>

<body>
    <header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">所有分类</div>
    </header>
    <div class="main">
        <ul style="padding-top: 4.40625rem; ">
            <c:if test="${not empty allProductCategory}">
                <c:forEach items="${allProductCategory}" var="category" varStatus="s">
                    <li>
                        <input type="hidden" value="${category.categoryId}"/>
                        <a href="${webRoot}/wap/reclassify.ac?categoryId=${category.categoryId}&count=${s.count}" title="${category.name}">
                            <c:set value="${category.categoryAdvtsUrlMap['160X160']}" var="categoryPic"/>
                            <c:set value="${webRoot}/template/bdw/wap/statics/images/noPic_160X160.jpg" var="noCategoryPicImageUrl"/>
                            <img src="${not empty categoryPic ? categoryPic : noCategoryPicImageUrl}" ><br/>${category.name}
                        </a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
</body>
</html>