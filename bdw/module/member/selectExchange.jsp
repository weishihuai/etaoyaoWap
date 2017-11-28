<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findReturnOrderPage(loginUser.userId,pageNum,8,false)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-选择换货-${sdk:getSysParamValue('index_title')}</title><%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #member .rBox .seachOb .m1 h3 .btn{margin-top: 6px;margin-right:6px;}
        #member .rBox .seachOb .m1 h3 .btn a{font-size: 12px;background: url("${webRoot}/template/bdw/module/member/statics/images/member_BG.png") no-repeat scroll -182px -72px transparent;color: #FFFFFF;display: block;height: 22px;line-height: 22px;margin: 0 auto;text-align: center;width: 78px;}
    </style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/selectPurchase.js"></script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/">首页</a> >  <a href="${webRoot}/module/member/index.ac">会员专区</a> >  订单列表</div></div>


<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

   <div class="rBox">
       <div class="seachOb">
	      <div class="m1">
              <c:set value="${sdk:getSysParamValue('exchange_date')}" var="exchange_date" />
		     <h3>选择换货商品<span style="font-size:12px;font-weight:normal;"> -- 你在${exchange_date}天内购买的商品享受换货服务</span><div class="btn" style="float: right;"><a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">返回</a></div></h3>
              <div class="clear"></div>
			 <div class="box return">
                 <%--订单显示列表 start--%>
                 <table width="100%" border="0" cellspacing="0">
                     <tr class="tr1">
                         <td class="td1">编号</td>
                         <td class="td2">商&nbsp;&nbsp;品</td>
                         <td class="td4">订单金额</td>
                         <td class="td5">支付方式</td>
                         <td class="td7">操作</td>
                     </tr>

                     <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                         <tr <c:if test="${status.count mod 2 !=0}"> class="bg"</c:if>>
                             <td class="td1"><span><a href="${webRoot}/module/member/orderDetail.ac?id=${orderProxy.orderId}" title="查看详细">${orderProxy.orderNum}</a></span></td>
                             <td class="td2">
                                 <ul>
                                     <%--获取订单项 start--%>
                                     <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                                         <c:if test="${orderItemProxy.promotionType != '赠品商品'}">
                                         <li>
                                            <div class="returnItem">
                                                <c:choose>
                                                    <c:when test="${orderItemProxy.isReturnedOrExchange == true}">
                                                        <span style="float: left;margin-left:30px;">&nbsp;</span>
                                                        <a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html" title="${orderItemProxy.productProxy.name}"><img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="48px;" height="48px;" alt="${orderItemProxy.productProxy.name}"/></a>
                                                        ${fn:substring(orderItemProxy.productProxy.name,0,15)}(<span class="price">已经申请退换货</span>)
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="checkbox" value="${orderItemProxy.orderItemId}" name="${orderProxy.orderId}" <c:if test="${orderItemProxy.isCanExchange == false}">disabled</c:if> />
                                                        <a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html" title="${orderItemProxy.productProxy.name}"><img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="48px;" height="48px;" alt="${orderItemProxy.productProxy.name}"/></a>
                                                        <span>
                                                            ${fn:substring(orderItemProxy.productProxy.name,0,8)}(<span class="price">¥${orderItemProxy.productUnitPrice}</span>) X ${orderItemProxy.num}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                         </li>
                                         </c:if>
                                     </c:forEach>
                                     <%--获取订单项 end--%>
                                 </ul>
                             </td>
                             <td class="td4"><b>¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></b><br />${orderProxy.payWay}</td>
                             <td class="td5"><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                             <td class="td7">
                                 <div class="btn"><a href="javascript:" onclick="selectPurchase('${orderProxy.orderId}','${orderProxy.orderNum}',false);">换货</a></div>
                             </td>
                         </tr>
                     </c:forEach>
                 </table>
                 <%--订单显示列表 end--%>
			 </div>
              <%--分页 start--%>
			 <div class="page" style="_padding-left: 633px;">
                 <div style="float:right">
                     <c:if test="${orderProxyPage.lastPageNumber >1}">
                         <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/selectPurchase.ac" totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${orderProxyPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
                     </c:if>
                 </div>
             </div>
              <%--分页 end--%>
		  </div>
	   </div>
   </div>
   <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
