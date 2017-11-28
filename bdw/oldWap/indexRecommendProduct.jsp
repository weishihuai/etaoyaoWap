<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>

<script type="text/javascript">
    $(function(){
        $(".star").click(function(){
            var obj = $(this);
            var productId = obj.attr("productId");
            if (productId == '' || productId == undefined) {
                return;
            }
            if(obj.attr("isCollect") == 'false'){
                $.get(webPath.webRoot + "/member/collectionProduct.json?productId=" + productId, function (data) {
                    if (data.success == "false") {
                        if (data.errorCode == "errors.login.noexist") {
                            window.location.href = webPath.webRoot + "/wap/login.ac";
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
                    type:"POST",url:webPath.webRoot+"/member/delUserProductCollect.json",
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
        });
    });
</script>


<c:forEach items="${sdk:findPageModuleProxy('weixin_content_F4_new').recommendPageProductes.result}" var="prd" varStatus="s" end="9">
    <li class="floor04-item">
        <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
            <div class="ac_image"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}" alt=""/></div>
        </c:if>
        <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}">
            <div class="g-pic">
                <img alt="${prd.name}" class="lazy" src="${empty prd.images ? prd.defaultImage['320X320'] : prd.images[0]['320X320']}" />
            </div>
            <div class="g-title">
                <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"> ${fn:substring(prd.name,0,40)}</a>
            </div>
        </a>
        <div class="g-price">￥<span>${prd.price.unitPrice}</span></div>
        <div class="g-old-price"><del>¥<span>${prd.marketPrice}</span></del></div>
        <div style="clear: both;"></div>
        <a class="star ${prd.collect ? 'cur' : ''}" href="javascript:" productId="${prd.productId}" isCollect="${prd.collect}"></a>
    </li>
</c:forEach>
