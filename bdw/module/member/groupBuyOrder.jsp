<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findGroupBuyOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/> <%--获取当前用户的团购订单--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-团购订单-${sdk:getSysParamValue('index_title')}</title><%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/orderList.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/memberAddComment.js"></script>
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
		     <h2 class="rightbox_h2_border">团购订单查询</h2>
			 <div class="box">
                 <div style="padding-top: 28px;border: 1px solid #E4E4E4;border-bottom: none;">
                 <%--订单查询提交表单 start--%>
                 <form method="GET" name="serachForm" id="serachForm" action="${webRoot}/module/member/groupBuyOrder.ac">
                     <div class="seachTo">
                         <div class="l_Sel">
                             <select name="searchTimeType" onchange="selectOrder()">
                                 <option value="2" <c:if test="${param.searchTimeType==2}"> selected="true" </c:if>  onclick="selectOrder()">全部订单</option>
                                 <option value="0" <c:if test="${param.searchTimeType==0}"> selected="true" </c:if>  onclick="selectOrder()">近一个月订单</option>
                                 <option value="1" <c:if test="${param.searchTimeType==1}"> selected="true" </c:if> onclick="selectOrder()">一个月前订单</option>
                             </select>
                         </div>
                         <div class="r_search">
                             <div class="put"><input type="text" name="searchField" id="searchField" value="商品名称、商品编号、订单编号" onclick="getFocus(this,'商品名称、商品编号、订单编号')" onblur="lostFocus(this,'商品名称、商品编号、订单编号')" /></div>
                             <div class="btn"><a onclick="selectOrder()" href="javascript:">查询</a></div>
                             <div class="clear"></div>
                         </div>

                         <input type="hidden" name="pitchOnRow" value="12">
                         <div class="clear"></div>
                     </div>
                 </form>
                 <%--订单查询提交表单 end--%>

                 <%--订单显示列表 start--%>
                 <table width="100%" border="0" cellspacing="0">
                     <tr class="tr1">
                         <td class="td1">订单编号</td>
                         <td class="td2">订单商品</td>
                         <td class="td3">单价X数量</td>
                         <td class="td4">收货人</td>
                         <td class="td4">订单金额</td>
                         <td class="td6">下单时间</td>
                         <td class="td7">订单状态</td>
                         <td class="td8">操作</td>
                     </tr>

                     <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                         <tr <c:if test="${status.count mod 2 !=0}"> class="bg"</c:if>>
                             <td class="td1"><span>${orderProxy.orderNum}</span></td>
                             <td class="td2">
                                 <ul>
                                     <%--获取订单项 start--%>
                                     <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                                         <li style="height: 60px;">
                                             <a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html"><img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="48px;" height="48px;" alt="${orderItemProxy.productProxy.name}"/></a>
                                             <a style="border: none;height: 15px;color: #3366CC;" onclick="memberAddComment('${orderItemProxy.productProxy.productId}')" href="javascript:void(0);">发表评论</a>
                                         </li>
                                     </c:forEach>
                                      <%--获取订单项 end--%>
                                 </ul>
                             </td>
                             <td class="td3">
                                 <ul>
                                     <%--获取订单项 start--%>
                                     <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                                         <li style="height: 60px;">
                                             <div style="padding-top: 22px;">
                                                 <span style="color:#c00;margin-right:10px;">${orderItemProxy.productUnitPrice}</span>X<span style="color: #c00;">${orderItemProxy.num}</span>
                                             </div>
                                         </li>
                                     </c:forEach>
                                      <%--获取订单项 end--%>
                                 </ul>
                             </td>
                             <td class="td4">${orderProxy.receiverName}</td>
                             <td class="td4"><b>¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></b><br />${orderProxy.payWay}</td>
                             <td class="td6"><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                             <td class="td7 def_color"><b>${orderProxy.orderStat}</b></td>
                             <td class="td8">
                                 <p><a href="${webRoot}/module/member/orderDetail.ac?id=${orderProxy.orderId}" title="查看详细" style="color: #e8340c;font-weight: bold;font-size: 14px;">查看详细</a></p>
                                 <%--<div class="btn"><a href="${webRoot}/module/member/orderDetail.ac?id=${orderProxy.orderId}" title="支付订单">支付订单</a></div>--%>
                             </td>
                         </tr>
                     </c:forEach>
                 </table>
                 <%--订单显示列表 end--%>
                 </div>
			 </div>
              <%--分页 start--%>
			 <div class="page">
                 <div style="float:right">
                     <c:if test="${orderProxyPage.totalCount >1}">
                         <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/groupBuyOrder.ac" totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${orderProxyPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
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
