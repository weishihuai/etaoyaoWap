<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${sdk:findAllOrder(loginUser.userId,1,5)}" var="orderProxyPage"/> <%--获取当前用户的前5条订单--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-会员专区-${sdk:getSysParamValue('index_title')}</title>  <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <%--<script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>--%>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/sendEmailValidateEmail.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/memberAddComment.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/orderList.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/userIndex.js"></script>


</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员专区">会员专区</a> </div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="m_index">
        <input type="button" id="btn" value="getScript请求" style="display: none;"/>
        <%--会员专区 头部用户信息 start--%>
        <div class="m1">
            <h2 class="rightbox_h2_border">
                <div class="f">您好：${loginUser.loginId} ，欢迎您回来！</div>
                <div class="clear"></div>
            </h2>
            <div class="box right_box_border">
                <div class="l">
                    <p>用户帐号：<i>${loginUser.loginId}</i> <c:if test="${!loginUser.isEmailValidate}"><a id="sendEmailValidateEmail" href="javascript:void(0);" style="color: red;margin-left: 5px;">[邮箱验证]</a></c:if></p>
                    <p>会员级别：<b>${loginUser.level}</b></p>
                    <p class="userLevel" >
                        您现在的会员升降级综合评分为<b>${loginUser.score}</b>分
                        <c:if test="${loginUser.nextLevelDifferenceScore!=null}">，
                            还差<b>${loginUser.nextLevelDifferenceMap.score}</b>分可升级到<b>${loginUser.nextLevelDifferenceMap.level}</b>
                        </c:if>，了解会员升降级规则详情，请点击<a href="${webRoot}/help.html" target="_blank">《帮助中心》</a>
                    </p>
                    <p>帐户余额：<em>￥<fmt:formatNumber value="${loginUser.prestore}" type="number" pattern="#0.00#" /> <a href="${webRoot}/module/member/myPrestore.ac?pitchOnRow=15">查看我的账号记录</a></p>
                    <p></em> 我的积分：<em><fmt:formatNumber value="${loginUser.integral}" type="number" pattern="##" /></em>分 <a href="${webRoot}/module/member/myIntegral.ac?pitchOnRow=16">查看我的积分记录</a> </p>
                    <p>客服中心：系统信息(<span><a href="${webRoot}/module/member/mySystemMsg.ac?pitchOnRow=7">${loginUser.sysMsgCount}</a></span>)</p>
                    <p><a href="${webRoot}/module/member/myInvite.ac?menuId=51554">推荐好友注册${webName}</a></p>
                </div>
                <div class="r">
                    <p>提示信息</p>
                    <p>会员专区：有 <b><a href="${webRoot}/module/member/orderList.ac?searchTimeType=0&status=0&searchField=">${loginUser.pendingOrderCount}</a></b> 个等待处理的订单</p>
                    <p>商品收藏：共添加了 <b><a href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3">${loginUser.productCollectCount}</a></b> 件商品</p>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <%--会员专区 头部用户信息 end--%>

        <%--会员专区 用户最近的订单 start--%>
        <div class="m2">
            <h3><div class="tit">我最近的订单</div></h3>
            <c:choose>
                <c:when test="${empty orderProxyPage.result}">
                    <div class="box" style="border-bottom: 1px solid #CCCCCC;">
                        <li class="e-none" style="padding-left:388px;width:502px;/*height: 317px;*/padding-top: 150px;"><!--，没有搜到商品-->
                            <p><i>没有订单？</i></p>
                            <p><em>赶紧去首页购物吧！</em></p>
                            <a href="${webRoot}/index.html">返回首页>></a>
                        </li>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="box">
                        <table width="100%" border="0" cellspacing="0">
                            <tr class="tr1">
                                <td class="td1">订单商品</td>
                                <td class="td2">单价(元)</td>
                                <td class="td3">数量</td>
                                <td class="td4">实付款(元)</td>
                                <td class="td5">订单状态</td>
                                <td class="td6">操作</td>
                            </tr>
                        </table>
                        <div id="orderInfo_div">
                            <%--<div class="operator">--%>
                                <%--&lt;%&ndash;<span><input  class="selectAllNotPayOrder" type="checkbox"></span>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<span style="float: left;">全选</span>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<span><a href="javascript:;" onclick="mergerPayment()">合并付款</a></span>&ndash;%&gt;--%>
                            <%--</div>--%>
                            <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                                <div class="item_div">
                                    <div class="item_div_info">
                                        <input value="${orderProxy.orderId}"   type="checkbox"<c:if test="${not orderProxy.pay&&!orderProxy.isCod&&orderProxy.orderStat != '已取消'}"> name="select" class="select"</c:if> <c:if test="${orderProxy.pay ||orderProxy.isCod||orderProxy.orderStat == '已取消'}"> disabled="disabled" </c:if>>
                                        订单编号：<span style="margin-right: 20px">${orderProxy.orderNum}</span>
                                        下单时间：<span style="margin-right: 20px"><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                             <span>
                                <%--<a style="color: #3399FF;" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${orderProxy.sysShopInf.shopInfId}"  title="点击进入${orderProxy.sysShopInf.shopNm}">${orderProxy.sysShopInf.shopNm}</a>--%>
                                 <%--<c:choose>--%>
                                     <%--<c:when test="${not empty orderProxy.sysShopInf.subDomain}">--%>
                                         <%--<c:set var="shopUrl" value="http://${orderProxy.sysShopInf.subDomain}.bdwmall.com"></c:set>--%>
                                         <%--<a href="${shopUrl}" title="点击进入${orderProxy.sysShopInf.shopNm}" target="_blank">--%>
                                                 <%--${fn:substring(orderProxy.sysShopInf.shopNm,0,16)}--%>
                                         <%--</a>--%>
                                     <%--</c:when>--%>
                                     <%--<c:otherwise>--%>
                                         <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${orderProxy.sysShopInf.shopInfId}" title="${orderProxy.sysShopInf.shopNm}" target="_blank">--%>
                                                 <%--${fn:substring(orderProxy.sysShopInf.shopNm,0,16)}--%>
                                         <%--</a>--%>
                                     <%--</c:otherwise>--%>
                                 <%--</c:choose>--%>
                                     <c:choose>
                                         <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                                             <a href="${webRoot}/citySend/storeDetail.ac?orgId=${orderProxy.sysShopInf.sysOrgId}" title="${orderProxy.sysShopInf.shopNm}" target="_blank">
                                         </c:when>
                                         <c:otherwise>
                                             <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${orderProxy.sysShopInf.shopInfId}" title="${orderProxy.sysShopInf.shopNm}" target="_blank">
                                         </c:otherwise>
                                     </c:choose>
                                             ${fn:substring(orderProxy.sysShopInf.shopNm,0,16)}
                                     </a>
                                 <c:set value="${sdk:getShopInfProxyById(orderProxy.sysShopInf.shopInfId)}" var="shopInf"/>


                                <%--<c:forEach items="${csadInfList}" var="caadInf" end="2">--%>
                                    <%--<a  href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank"><img style="vertical-align:middle;margin-bottom: 5px;" src="http://wpa.qq.com/pa?p=1:${caadInf}:7" /></a>--%>
                                <%--</c:forEach>--%>
                                 <c:choose>
                                     <c:when test="${not empty shopInf.companyQqUrl}">
                                         <a href="${shopInf.companyQqUrl}" target="_blank">
                                             <img src="${webRoot}/template/bdw/statics/images/qq.png"/>
                                         </a>
                                     </c:when>
                                     <c:otherwise>
                                         <c:forEach items="${shopInf.csadInfList}" var="caadInf" end="0">
                                             <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank">
                                                 <img src="http://wpa.qq.com/pa?p=1:${caadInf}:7" />
                                             </a>
                                         </c:forEach>
                                     </c:otherwise>
                                 </c:choose>
                            </span>
                                    </div>
                                    <div class="item_div_cont">
                                        <div class="proItem">
                                            <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                                                <div class="proItem_item">
                                                    <div class="proItem_item_d">
                                                        <div class="proItem_item_d_d1">
                                                            <a  href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html" target="_blank">
                                                                <c:choose>
                                                                    <c:when test="${orderItemProxy.productProxy.jdProductCode != null && orderItemProxy.productProxy.jdProductCode != ''}">
                                                                        <img src="${orderItemProxy.productProxy.defaultImage["jdUrl"]}" width="48px" height="48px" alt="${orderItemProxy.productProxy.name}"/>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="48px" height="48px" alt="${orderItemProxy.productProxy.name}"/>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                            </a>
                                                        </div>
                                                        <div class="proItem_item_d_d2"><a  href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html" target="_blank" title="${orderItemProxy.productProxy.name}">${sdk:cutString(orderItemProxy.productProxy.name, 30, "...")}</a></div>
                                                    </div>
                                                    <div class="proItem_item_price"><fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></div>
                                                    <div class="proItem_item_num">
                                                        <span class="s1">${orderItemProxy.num}</span>
                                                        <%--<span class="s2"><a onclick="memberAddComment('${orderItemProxy.productProxy.productId}')" href="javascript:void(0);">评价</a></span>--%>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="operator_d">
                                            <div class="infoItem1">
                                                <div class="infoItem1_d"> <b style="color: #a80000;">¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></b><br><c:choose><c:when test="${orderProxy.isCod}">货到付款</c:when><c:otherwise>在线支付</c:otherwise></c:choose></div>
                                            </div>
                                            <div class="infoItem2"><div class="infoItem2_d"><b style="color: #a80000;">${orderProxy.orderStat}</b></div></div>
                                            <div class="infoItem3">
                                                <div class="cont">
                                                    <a class="infoItem3_detail" href="${webRoot}/module/member/orderDetail.ac?id=${orderProxy.orderId}" title="查看详细">查看详细</a>
                                                    <%--<c:choose>
                                                        <c:when test="${orderProxy.orderRatingStat=='买家未评'}">
                                                            <p><a class="btn" href="${webRoot}/module/member/newAddComment.ac?orderId=${orderProxy.orderId}">评价</a></p>
                                                        </c:when>
                                                        <c:when test="${orderProxy.orderRatingStat=='双方已评，追加评价'}">
                                                            <p>双方已评</p><p><a class="btn" href="${webRoot}/module/member/newAddComment.ac?orderId=${orderProxy.orderId}">重新评价</a></p>
                                                        </c:when>
                                                        <c:when test="${orderProxy.orderRatingStat=='双方已评'}">
                                                            <p>双方已评</p>
                                                        </c:when>
                                                        <c:when test="${orderProxy.orderRatingStat=='卖家未评，追加评价'}">
                                                            <p>卖家未评</p><p><a class="btn" href="${webRoot}/module/member/newAddComment.ac?orderId=${orderProxy.orderId}">重新评价</a></p>
                                                        </c:when>
                                                        <c:when test="${orderProxy.orderRatingStat=='买家已评'}">
                                                            <p>买家已评</p>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:if test="${!orderProxy.isCod && orderProxy.pay && orderProxy.isPicking=='N' && orderProxy.orderStat=='待发货'}">
                                                        <a class="infoItem3_detail" href="javascript:;" onclick="cancelOrder('${orderProxy.orderId}','index')" title="取消订单">取消订单</a>
                                                    </c:if>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <script type="text/javascript">
                                $(document).ready(function(){
                                    $(".proItem").each(function(){
                                        $(this).parent().find(".infoItem1").css("height",$(this).height()-1);
                                        $(this).parent().find(".infoItem2").css("height",$(this).height()-2);
                                        $(this).parent().find(".infoItem3").css("height",$(this).height()-2);
                                    });
                                    $(".cont").each(function(){
                                        if($(this).height()<40){
                                            $(this).css("margin-top","20px");
                                        }
                                    });
                                });
                            </script>
                        </div>
                        <h5><a href="${webRoot}/module/member/orderList.ac" style="font-size: 16px;">查看更多订单>></a></h5>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
        <%--会员专区 用户最近的订单 end--%>
    </div>
    <div class="clear"></div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
