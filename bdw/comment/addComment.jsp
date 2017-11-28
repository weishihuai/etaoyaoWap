<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-发表评论</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userTalk.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.productId}",orderId:${param.orderId}};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
    <style type="text/css">
        .stars{float:left; height:32px; overflow:hidden;}
        .stars a{ display:block; float:left; background:url(${webRoot}/template/bdw/statics/images/detail_starIco03.gif) no-repeat; width:32px; height:32px; overflow:hidden;}
        .stars .grayStar{margin-top: 4px;}
        .stars a.cur,#layer1 .box2 .area .fixBox .stars a:hover{ background:url(${webRoot}/template/bdw/statics/images/userTalk_star01.gif) no-repeat;}
    </style>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=product"/>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.productId)}"/>

<div id="position" class = "m1-bg">
    <div class="m1"><a href="${webRoot}/index.html">首页</a>
        <c:forEach items="${productProxy.category.categoryTree}" var="node" begin="1">
            > <a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a>
        </c:forEach>
        > <a href="${webRoot}/product-${param.productId}.html" title="${productProxy.name}">${productProxy.name}</a>
    </div>
</div>

<div id="userTalk">
    <%--商品详细--%>
        <div class="lBox">
            <c:import url="/template/bdw/comment/includeProduct.jsp?id=${param.productId}"/>
        </div>
    <%--商品详细--%>
    <div class="rBox">
        <div class="Put-B">
            <div class="t_Area">
                <div class="tit">发表商品评论</div>
                <div class="clear"></div>
            </div>
            <div class="box">
                <div class="m1">
                    <div class="t1"><%--给商品评分：--%>
                        <div class="stars" id="stars">
                            <a href="javascript:void(0)" class="cur" id="star1"  ></a>
                            <a href="javascript:void(0)" class="cur" id="star2"  ></a>
                            <a href="javascript:void(0)" class="cur" id="star3"  ></a>
                            <a href="javascript:void(0)" class="cur" id="star4"  ></a>
                            <a href="javascript:void(0)" class="cur" id="star5" ></a>
                        </div>
                        <span style="color: #000;font-weight: normal;font-size: 14px;">给商品评分：</span>
                        <span id="showStar">5分 非常满意</span></div>
                    <form id="commentForm" action="${webRoot}/comment/commentSuccess.ac?id=${param.productId}" method="POST" enctype="application/x-www-form-urlencoded">
                        <input id="repPict" name="repPict" type="hidden" value=""/>
                        <div class="t2">
                            <label>您对此商品的评价：</label>
                            <input type="hidden" id="gradeLevel" name="gradeLevel" value="5"/>
                            <div class="put"><textarea id="commentCont" name="commentCont" cols="" rows="" >欢迎您发表原创并对其它用户有参考价值的商品评价。</textarea></div>
                            <div class="clear"></div>
                        </div>
                        <div class="form-group">
                            <span class="lab share">晒图：</span>
                            <div class="pic-cont">
                              <div class="up_ld"><a class="btn-up" id="upload" href="javascript:;" title="上传图片">上传图片</a></div>
                            </div>
                        </div>
                    </form>
                    <div class="btn"><a href="javascript:void(0);" id="addComment">发表商品评论</a></div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>


<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
