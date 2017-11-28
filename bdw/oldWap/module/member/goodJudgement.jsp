<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>商品评价</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/comment.js"></script>

    <style type="text/css">
        .stars{ /*height:50px; */overflow:hidden;}
        .stars a{ display:block; float:left; background:url(${webRoot}/template/bdw/oldWap/statics/images/xingxing4.png) no-repeat; width:22px; height:22px; overflow:hidden;}
        .stars a.cur,#layer1 .box2 .area .fixBox .stars a:hover{ background:url(${webRoot}/template/bdw/oldWap/statics/images/xingxing3.png) no-repeat;}
    </style>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}"};
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=商品评价"/>
<%--页头结束--%>
<div class="container container3">
    <div class="row d_rows5">
        <div class="col-xs-12">
            <div class="rows5_title">商品信息</div>
        </div>

        <div class="col-xs-3 rows5_left"><img src="${productProxy.defaultImage['60X60']}" width="60" height="60"></div>
        <div class="col-xs-9 rows5_right">
            <div class="rows5_title2">
                <c:choose>
                    <c:when test="${productProxy.shopType eq '2'}">
                        <a href="${webRoot}/wap/citySend/product.ac?id=${productProxy.productId}">${productProxy.name}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-xs-6">
                <div class="rows5_title3"></div>
            </div>
            <div class="col-xs-6">
                <div class="rows5_title3"></div>
            </div>
            <div class="col-xs-12">
                <div class="rows5_price">￥${productProxy.price.unitPrice}</div>
            </div>
        </div>

        <form id="commentForm" action="${webRoot}/wap/commentSuccess.ac?id=${param.id}" method="POST" enctype="application/x-www-form-urlencoded">
            <div class="col-xs-5 rows5_left2" style="text-align:right;">商品评分：</div>
            <div class="col-xs-7 rows5_right2 stars"  id="stars">
                <a href="javascript:void(0)" class="cur" id="star1" ></a>

                <a href="javascript:void(0)" class="cur" id="star2" ></a>
                <a href="javascript:void(0)" class="cur" id="star3" ></a>
                <a href="javascript:void(0)" class="cur" id="star4" ></a>
                <a href="javascript:void(0)" class="cur" id="star5" ></a>
            </div>
            <div class="row" style="padding:0 20px;">
                <div class="col-xs-12">
                    <input type="hidden" id="gradeLevel" name="gradeLevel" value="5"/>
                    <div class="col-xs-5 rows5_left2" style="text-align:right;">商品评价：</div>
                    <div class="col-xs-7 rows5_right3"><textarea id="commentCont" name="commentCont"  class="form-control form-control3" rows="3"></textarea></div >
                </div>

            </div>
        </form>

        <div class="row"style="padding:0 20px;">
            <div class="col-xs-12" ><a class="btn btn-danger btn-danger2" style="margin:10px 0;" href="javascript:void(0);" id="addComment">发表商品评价</a></div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12" id="box_bottom"></div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>