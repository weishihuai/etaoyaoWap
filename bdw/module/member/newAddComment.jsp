<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${sdk:findOrderDetailed(param.orderId)}" var="orderProxy"/> <%--获取订单项--%>
<c:set value="${sdk:isAllowShopComment(param.orderId)}" var="isAllowShopComment"/> <%--获取订单项--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-发表评论</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/newUserTalk.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}",orderId:'${orderProxy.orderId}'};
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/comment.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/ObjectToJsonUtil.js"></script>
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
<%--页头结束--%>

<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/">首页</a> >  <a href="${webRoot}/module/member/index.ac">会员专区</a> >  店铺评价</div></div>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
       <%-- <div id="userTalk">
            <div class="rBox">
                <div class="Put-B">
               <div class="t_Area">
                  <div class="tit">发表商品评论</div>
                  <div class="clear"></div>
               </div>
               <div class="box">
              <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" varStatus="status">
                  <c:set value="${orderItemProxy.productProxy.productId}" var="productId"/>
                  <c:set value="${loginUser.userId}" var="userId"/>
                  <c:set value="${sdk:isAllowComment(productId,userId)}" var="isAllowComment"/> &lt;%&ndash;判断是否可以评论&ndash;%&gt;
                  <c:choose>
                  <c:when test="${isAllowComment}">
                  <div class="m1 pro_comment">
                      <div class="lBox">
                          <div class="pic">
                              <a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html"><img src="${orderItemProxy.productProxy.defaultImage["150X150"]}" alt="${productProxy.name}"/></a>
                          </div>
                          <div class="title">商品名称：<a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html">${orderItemProxy.productProxy.name}</a></div>
                          <div class="price">销售价：<b>￥<fmt:formatNumber value="${orderItemProxy.productProxy.price.unitPrice}" type="number" pattern="#0.00#" /></b></div>
                          <p  class="commentNum">评论数：${orderItemProxy.productProxy.commentQuantity}</p>
                      </div>
                         <div class="t1">
                             &lt;%&ndash;给商品评分：&ndash;%&gt;
                                 <div class="stars pro_stars">
                                     <a href="javascript:void(0)" class="cur"   ></a>
                                     <a href="javascript:void(0)" class="cur"   ></a>
                                     <a href="javascript:void(0)" class="cur" ></a>
                                     <a href="javascript:void(0)" class="cur"  ></a>
                                     <a href="javascript:void(0)" class="cur"  ></a>
                                 </div>
                                 <span style="color: #000;font-weight: normal;font-size: 14px;">给商品评分：</span>
                                 <span class="showStar">5分 非常满意</span>
                                 <input type="hidden" class="pro_Level" productId="${productId}" value="5"/>
                         </div>
                         <div class="t2">
                            <label>您对此商品的评价：</label>
                            <div class="put"><textarea id="commentCont" class="commentCont" name="" cols="" rows="">欢迎您发表原创并对其它用户有参考价值的商品评价。</textarea></div>
                            <div class="clear"></div>
                         </div>
                  </div>
                  </c:when>
                  </c:choose>
               </c:forEach>
               </div>
           </div>
            </div>
            <div class="clear"></div>
        </div>--%>
        <div id="userTalk1">
            <div class="rBox">
                <div class="Put-B">
                    <div class="t_Area">
                        <div class="tit">店铺动态评价</div>
                        <div class="clear"></div>
                    </div>
                    <c:choose>
                        <c:when test="${isAllowShopComment}">
                            <div class="box">
                                <div class="m1">
                                    <div class="t3">
                                        <div style="float: left;  margin: 2px 10px;">宝贝相符</div>
                                        <div class="stars" id="shopstars">
                                            <a href="javascript:void(0)" class="cur" id="shopstars1"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstars2"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstars3"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstars4"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstars5"></a>
                                        </div>
                                        <span style="color: #000;font-weight: normal;font-size: 14px;">评分为：</span>
                                        <span class="showStar">5分 非常满意</span>
                                        <input type="hidden" class="pro_Level"  id="productDescrSame"  value="5"/>
                                    </div>
                                    <div class="t3">
                                        <div style="float: left; margin: 2px 10px;">服务态度</div>
                                        <div class="stars" id="shopstarsa">
                                            <a href="javascript:void(0)" class="cur" id="shopstarsa1"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsa2"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsa3"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsa4"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsa5" ></a>
                                        </div>
                                        <span style="color: #000;font-weight: normal;font-size: 14px;">评分为：</span>
                                        <span class="showStar">5分 非常满意</span>
                                        <input type="hidden" class="pro_Level"  id="sellerServiceAttitude" value="5"/>
                                    </div>
                                    <div class="t3">
                                        <div style="float: left; margin: 2px 10px;">发货速度</div>
                                        <div class="stars" id="shopstarsb">
                                            <a href="javascript:void(0)" class="cur" id="shopstarsb1"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsb2"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsb3"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsb4"></a>
                                            <a href="javascript:void(0)" class="cur" id="shopstarsb5"></a>
                                        </div>
                                        <span style="color: #000;font-weight: normal;font-size: 14px;">评分为：</span>
                                        <span class="showStar">5分 非常满意</span>
                                        <input type="hidden" class="pro_Level" id="sellerSendOutSpeed" value="5"/>
                                    </div>
                                    <c:choose>
                                        <c:when test="${orderProxy.orderRatingStat=='买家未评'}">
                                            <div class="btn"><a href="javascript:ajaxAddComment();">发表评论</a></div>
                                        </c:when>
                                        <c:when test="${orderProxy.orderRatingStat=='双方已评，追加评价' || orderProxy.orderRatingStat=='卖家未评，追加评价'}">
                                            <div class="btn"><a href="javascript:ajaxAddShopComment();">再次评论</a></div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>