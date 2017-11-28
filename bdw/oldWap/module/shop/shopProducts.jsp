<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:search(10)}" var="productProxys"/>

<script type="text/javascript">
    $(document).ready(function(){
        $('.productPic').css('height',$('.productPic').css('width'));
    });

    function collectProduct(object){
        var obj = $(object);
        var productId = obj.attr("productId");
        if (productId == '' || productId == undefined) {
            return;
        }
        if(obj.attr("isCollect") == 'false'){
            $.get(paramData.webRoot + "/member/collectionProduct.json?productId=" + productId, function (data) {
                if (data.success == "false") {
                    if (data.errorCode == "errors.login.noexist") {
                        window.location.href = paramData.webRoot + "/wap/login.ac";
                    }
                    if (data.errorCode == "errors.collection.has") {
                        breadDialog("您已收藏此商品","ok",1000,false);
                    }
                } else if (data.success == true) {
                    $(obj).addClass("cur");
                    obj.attr("isCollect","true");
                    breadDialog("商品收藏成功","ok",1000,false);
                }
            });
        }
        else{
            $.ajax({
                type:"POST",url:paramData.webRoot+"/member/delUserProductCollect.json",
                data:{items:productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        breadDialog("成功取消收藏","ok",1000,false);
                        obj.removeClass("cur");
                        obj.attr("isCollect","false");
                    }else{
                        breadDialog("系统错误,请刷新重新操作","alert",1000,false);
                    }
                }
            });
        }
    }
</script>

<c:forEach items="${productProxys.result}" var="product" varStatus="status" end="9">
    <li>
        <c:if test="${product.isJoinActivity && not empty product.activityPlateImageUrl}">
            <div class="ac_image"><img src="${webRoot}/upload/${product.activityPlateImageUrl}" alt=""/></div>
        </c:if>
        <a href="${webRoot}/wap/product.ac?id=${product.productId}">
            <div class="g-pic">
                <img class="productPic" src="${product.defaultImage["320X320"]}" alt="${product.name}">
            </div>
            <div class="g-title">${product.name}</div>
        </a>
        <div class="g-price">¥ <span>${product.price.unitPrice}</span></div>
        <div class="old-price"><del>¥ <span>${product.marketPrice}</span></del></div>
        <div style="clear: both;"></div>
        <c:if test="${not empty loginUser}">
            <a class="star ${product.collect ? 'cur' : ''}" productId="${product.productId}" isCollect="${product.collect}" href="javascript:void(0);" onclick="collectProduct(this);"></a>
        </c:if>
        <c:if test="${empty loginUser}">
            <a href="javascript:void(0);" class="star" onclick="window.location.href='${webRoot}/wap/login.ac';"></a>
        </c:if>
    </li>
</c:forEach>




