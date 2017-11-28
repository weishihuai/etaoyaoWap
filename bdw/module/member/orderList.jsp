<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<jsp:useBean id="systemTime" class="java.util.Date" />
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findOrdinaryOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-订单查询-${sdk:getSysParamValue('index_title')}</title><%--SEO title优化--%>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/news_html.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .timeColor{
            color:#ff0000;
        }
    </style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var webPath = {
            webRoot:'${webRoot}',
            systemTime:'<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />',
            pitchOnRow:'${param.pitchOnRow}',
            page:'${param.page}',
        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/orderList.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/memberAddComment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.ac">首页</a> >  <a href="${webRoot}/module/member/index.ac">会员专区</a> >  订单列表</div></div>


<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <div class="rBox">
        <div class="seachOb">
            <div class="m1">
                <h2 class="rightbox_h2_border">订单查询</h2>
                <div class="box">
                    <div style="padding-top: 28px;border: 1px solid #E4E4E4;border-bottom: none;">
                        <%--订单查询提交表单 start--%>
                        <form method="GET" name="serachForm" id="serachForm" action="${webRoot}/module/member/orderList.ac">
                            <div class="seachTo">
                                <div class="l_Sel">
                                    <select name="searchTimeType" onChange="selectOrder()">
                                        <option value="2" <c:if test="${param.searchTimeType==2}"> selected="true" </c:if>  onclick="selectOrder()">全部订单</option>
                                        <option value="0" <c:if test="${param.searchTimeType==0}"> selected="true" </c:if>  onclick="selectOrder()">近一个月订单</option>
                                        <option value="1" <c:if test="${param.searchTimeType==1}"> selected="true" </c:if> onClick="selectOrder()">一个月前订单</option>
                                    </select>
                                </div>
                                <div class="l_Sel1" style="width: 180px;padding-left:50px;float:left">
                                    <select name="status" onChange="selectOrder()">
                                        <option value="10" <c:if test="${param.status==10}"> selected="true" </c:if>  onclick="selectOrder()">全部订单</option>
                                        <option value="0" <c:if test="${param.status==0}"> selected="true" </c:if>  onclick="selectOrder()">未完成订单</option>
                                        <option value="1" <c:if test="${param.status==1}"> selected="true" </c:if> onClick="selectOrder()">已完成订单</option>
                                        <option value="5" <c:if test="${param.status==5}"> selected="true" </c:if> onClick="selectOrder()">已取消订单</option>
                                        <option value="6" <c:if test="${param.status==6}"> selected="true" </c:if> onClick="selectOrder()">已拒收订单</option>
                                    </select>
                                </div>
                                <div class="r_search">
                                    <div class="put"><input type="text" name="searchField" id="searchField" value="商品名称、商品编号、订单编号" onClick="getFocus(this,'商品名称、商品编号、订单编号')" onBlur="lostFocus(this,'商品名称、商品编号、订单编号')" /></div>
                                    <div class="btn"><a onClick="selectOrder()" href="javascript:">查询</a></div>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                                <input type="hidden" name="pitchOnRow" value="11">
                            </div>
                        </form>

                        <%--订单显示列表 start--%>
                        <table width="100%" border="0" cellspacing="0">
                            <tr class="tr1">
                                <td class="td1">订单商品</td>
                                <td class="td2">单价(元)</td>
                                <td class="td3">数量</td>
                                <td class="td3">退/换货状态</td>
                                <td class="td4">实付款(元)</td>
                                <td class="td5">订单状态</td>
                                <td class="td6">操作</td>
                            </tr>
                        </table>
                    </div>
                    <div id="orderInfo_div" style="margin-top: 15px">
                <%--        2014-07-14 全选功能暂时去掉--%>
                        <%--<div class="operator">--%>
                            <%--<span><input  class="selectAllNotPayOrder" type="checkbox"></span>--%>
                            <%--<span style="float: left;">全选</span>--%>
                            <%--&lt;%&ndash;<span><a href="javascript:;" onclick="mergerPayment()">合并付款</a></span>&ndash;%&gt;--%>
                        <%--</div>--%>
                        <c:choose>
                            <c:when test="${empty orderProxyPage.result}">
                                <div>
                                    <li class="e-none" style="padding-left:360px;width:502px;height: 160px;padding-top: 130px;">
                                        <p><i>没有订单？</i></p>
                                        <p><em>赶紧去首页购物吧！</em></p>
                                        <a href="${webRoot}/index.html">返回首页>></a>
                                    </li>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                                    <div class="item_div">
                                        <div class="item_div_info" style="padding-left: 10px;">
                                            <%--<input value="${orderProxy.orderId}"   type="checkbox"<c:if test="${not orderProxy.pay&&!orderProxy.isCod&&orderProxy.orderStat != '已取消'}"> name="select" class="select"</c:if> <c:if test="${orderProxy.pay ||orderProxy.isCod||orderProxy.orderStat == '已取消'}"> disabled="disabled" </c:if>>--%>
                                            订单编号：<span style="margin-right: 20px">${orderProxy.orderNum}</span>
                                            下单时间：<span style="margin-right: 20px"><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>

                                            <span>
                                                <%--<a style="color: #3399FF;" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${orderProxy.sysShopInf.shopInfId}"  title="点击进入${orderProxy.sysShopInf.shopNm}">${orderProxy.sysShopInf.shopNm}</a>--%>
                                                <c:set value="${sdk:getShopInfProxyById(orderProxy.sysShopInf.shopInfId)}" var="shopInf"/>
                                                <%--<c:choose>--%>
                                                    <%--<c:when test="${not empty shopInf.subDomain}">--%>
                                                        <%--<c:set var="shopUrl" value="http://${shopInf.subDomain}.bdwmall.com"></c:set>--%>
                                                        <%--<a href="${shopUrl}" title="${shopInf.shopNm}" target="_blank">--%>
                                                                <%--${fn:substring(shopInf.shopNm,0,16)}--%>
                                                        <%--</a>--%>
                                                    <%--</c:when>--%>
                                                    <%--<c:otherwise>--%>
                                                        <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" title="${shopInf.shopNm}" target="_blank">--%>
                                                                <%--${fn:substring(shopInf.shopNm,0,16)}--%>
                                                        <%--</a>--%>
                                                    <%--</c:otherwise>--%>
                                                <%--</c:choose>--%>

                                                    <c:choose>
                                                        <c:when test="${not empty shopInf.shopType && shopInf.shopType == '2'}">
                                                            <a href="${webRoot}/citySend/storeDetail.ac?orgId=${shopInf.sysOrgId}" title="${shopInf.shopNm}" target="_blank">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" title="${shopInf.shopNm}" target="_blank">
                                                        </c:otherwise>
                                                    </c:choose>
                                                            ${fn:substring(shopInf.shopNm,0,16)}
                                                    </a>
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

                                            <c:if test="${bdw:isShowPayEndTimeOnPage(orderProxy.orderId)}">
                                                <span class="countDown" id="orderId${orderProxy.orderId}" orderId="${orderProxy.orderId}" lastPayTime="${bdw:getPayEndTimeStr(orderProxy.orderId)}" style="float: right;margin-right: 35px;"></span>
                                            </c:if>

                                        </div>
                                        <div class="item_div_cont">
                                            <div class="proItem">
                                                <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                                                    <div class="proItem_item">
                                                        <div class="proItem_item_d">
                                                            <div class="proItem_item_d_d1" style="padding-left: 10px;"><a  href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html"><img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="48px" height="48px" alt=""/></a></div>
                                                            <div class="proItem_item_d_d2"><a  href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html" title="${orderItemProxy.productProxy.name}">${sdk:cutString(orderItemProxy.productProxy.name, 30, "...")}</a><c:if test="${orderItemProxy.promotionType eq '赠品商品'}"><span style="color:#a80000;">【赠品】</span></c:if></div>
                                                        </div>
                                                        <div class="proItem_item_price"><fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></div>
                                                        <div class="proItem_item_num" style="height: 54px; overflow: hidden;">
                                                            <span class="s1" style="vertical-align: top;">${orderItemProxy.num}</span>
                                                            <span class="s2" style="display: inline-block;">
                                                                <c:if test="${orderProxy.orderStat == '交易完成'}">
                                                                    <%--不是赠品才显示--%>
                                                                    <c:if test="${orderItemProxy.promotionType ne '赠品商品'}">
                                                                        <a onClick="memberAddCommentWithOrderId('${orderItemProxy.productProxy.productId}',${orderProxy.orderId})" href="javascript:void(0);" style="display: block; line-height: 18px;">商品评价</a>
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${orderProxy.orderStat == '交易完成'}">
                                                                    <c:if test="${orderItemProxy.promotionType ne '赠品商品'}">
                                                                        <c:if test="${orderItemProxy.isCanReturn == true and orderItemProxy.combinedProductId == null}">
                                                                            <a style="display: block; line-height: 18px;"  href="${webRoot}/module/member/selectPurchaseByOrderId.ac?orderId=${orderProxy.orderId}" >退货</a>
                                                                        </c:if>
                                                                        <c:if test="${orderItemProxy.isCanExchange == true}">
                                                                            <a style="display: block; line-height: 18px;"  href="${webRoot}/module/member/selectExchangeByOrderId.ac?orderId=${orderProxy.orderId}">换货</a>
                                                                        </c:if>
                                                                    </c:if>
                                                                </c:if>
                                                            </span>
                                                        </div>
                                                        <div class="proItem_item_status">${orderItemProxy.itemStatus}</div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div class="operator_d">
                                                <div class="infoItem1">
                                                    <div class="infoItem1_d"> <b style="color: #fb6600;">¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></b><br><c:choose><c:when test="${orderProxy.isCod}">货到付款</c:when><c:otherwise>在线支付</c:otherwise></c:choose></div>
                                                </div>
                                                <div class="infoItem2">
                                                    <div class="infoItem2_d">
                                                        <b style="color: #fb6600;">
                                                            <c:choose>
                                                                <c:when test="${orderProxy.orderStat=='待买家确认收货' && not empty orderProxy.pickedUpId}">
                                                                    待自提点提货
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${orderProxy.orderStat}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </b>
                                                    </div>
                                                </div>
                                                <div class="infoItem3">
                                                    <div class="cont">
                                                        <a class="infoItem3_detail" href="${webRoot}/module/member/orderDetail.ac?id=${orderProxy.orderId}" title="查看详细">查看详细</a>

                                                        <c:choose>
                                                            <c:when test="${orderProxy.orderRatingStat=='买家未评'}">
                                                                <p><a class="btn" href="${webRoot}/module/member/newAddComment.ac?orderId=${orderProxy.orderId}">店铺评价</a></p>
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


                                                       <c:if test="${orderProxy.orderStat=='未确认' && orderProxy.pay == false}">
                                                            <a class="infoItem3_detail" href="javascript:" onclick="cancelOrder('${orderProxy.orderId}','orderList')" title="取消订单">取消订单</a>
                                                        </c:if>


                                                        <%--2015-04-10,zch,应宝得要求添加确认收货，自提的订单确认收货是由自提点在自提的时候决定的--%>
                                                        <div class="cennl">
                                                            <c:if test="${orderProxy.orderStat=='待买家确认收货' && empty orderProxy.pickedUpId}">
                                                                <a href="javascript:" onclick="buyerSigned(this,'${orderProxy.orderId}')" title="确认收货">确认收货</a>
                                                            </c:if>
                                                        </div>

                                                        <div class="cennl">
                                                            <c:if test="${!orderProxy.pay && !orderProxy.isCod && orderProxy.orderStat!='已取消'}">
                                                               <%-- <a href="${webRoot}/shoppingcart/cashier.ac?orderIds=${orderProxy.orderId}" title="去支付">去支付</a>--%>
                                                                <a href="javascript:void(0);" title="去支付" onclick="confirmStatus('${orderProxy.orderId}');">去支付</a>
                                                            </c:if>
                                                        </div>


                                                        <c:if test="${orderProxy.orderStat == '交易完成' || orderProxy.orderStat == '已取消' || orderProxy.orderStat == '已拒收'}" >
                                                            <a href="javascript:;" class="deleteOrderBtn" orderId="${orderProxy.orderId}" >删除订单</a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                        <script type="text/javascript">
                            $(document).ready(function(){
                                $(".proItem").each(function(){
                                    $(this).parent().find(".infoItem1").css("height",$(this).height()-1);
                                    $(this).parent().find(".infoItem2").css("height",$(this).height()-2);
                                    $(this).parent().find(".infoItem3").css("height",$(this).height()-2);
                                });
                                $(".cont").each(function(){
                                    if($(this).height()<40){
                                        $(this).css("margin-top","14px");
                                        $(this).css("display","table-cell");
                                        $(this).css("vertical-align","middle");
                                    }
                                });
                            });
                        </script>
                    </div>
                </div>
                <%--分页 start--%>
                <c:if test="${orderProxyPage.lastPageNumber >1}">
                <div class="page">
                    <div style="float:right">

                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/orderList.ac" totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${orderProxyPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>

                    </div>
                </div>
                </c:if>
                <%--分页 end--%>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--申请漏发弹出窗口提示--%>
<div class="tccbg" id="missingApplyBtn" style="display: none;">
    <div class="tcc">
        <div class="l-title">
            <h2>申请漏发</h2>
            <h3><a href="javascript:" id="missingCancle"></a></h3>
        </div>

        <div class="l_rows">
            <label for="name">漏发个数：</label>
            <input type="text" class="text" id="missingNum">
            <input type="hidden" id="missingOrderitemId">
            <input type="hidden" id="missingNumReal">
            <div class="btn" id="missingBtn"><a href="javascript:">提交</a></div>
            <div class="clear"></div>
        </div>
    </div>
</div>

<%--申请漏发弹出窗口提示--%>
<div class="tccbg" id="mistakeApplyBtn" style="display: none;">
    <div class="tcc">
        <div class="l-title">
            <h2>申请发错</h2>
            <h3><a href="javascript:" id="mistakeCancle"></a></h3>
        </div>

        <div class="l_rows">
            <label for="name">发错个数：</label>
            <input type="text" class="text" id="mistakeNum">
            <input type="hidden" id="mistakeOrderitemId">
            <input type="hidden" id="mistakeNumReal">
            <div class="btn" id="mistakeBtn"><a href="javascript:">提交</a></div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<%--<div id="zoomloader">--%>
    <%--<div align="center"><span><img src="${webRoot}/template/bdw/statics/images/zoomloader.gif"/></span><span style="font-size: 18px">正在删除...</span></div>--%>
<%--</div>--%>

<div class="overlay" style="display: none" >
    <div class="lightbox fill-dt">
        <div align="center"><span><img src="${webRoot}/template/bdw/statics/images/zoomloader.gif"/></span><span class="lightdelete">订单删除中...</span></div>
    </div>
</div>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>


</body>
</html>
