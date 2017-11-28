<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="yz"%>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>

<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${bdw:searchOrder(pageNum,6,loginUser.userId)}" var="orderPage"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>O2O订单查询-${webName}-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/otoo/statics/css/order-list.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .stars{float:left; height:32px; overflow:hidden;}
        .stars a{ display:block; float:left; background:url(${webRoot}/template/bdw/statics/images/detail_starIco03.gif) no-repeat; width:32px; height:32px; overflow:hidden;}
        .stars .grayStar{margin-top: 4px;}
        .stars a.cur,#layer1 .box2 .area .fixBox .stars a:hover{ background:url(${webRoot}/template/bdw/statics/images/userTalk_star01.gif) no-repeat;}
    </style>

    <script type="text/javascript" language="javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/otoo/statics/js/myOrderList.js"></script>
</head>
<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.ac">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > O2O订单列表</div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
        <div class="right">
            <div class="tit">
                <a <c:if test="${param.isPayed == 'N' && param.orderStatus == '0'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=N&orderStatus=0" title="未付款">未付款<i></i></a>
                <a <c:if test="${param.isPayed == 'Y' && param.used == 'N'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&used=N" title="未使用">未使用<i></i></a>
                <a <c:if test="${param.isPayed == 'Y' && param.used == 'Y'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&used=Y" title="已使用">已使用<i></i></a>
                <a <c:if test="${param.orderStatus == '2'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&orderStatus=2" title="已取消">已取消<i></i></a>
                <a <c:if test="${param.isDeleted == 'Y'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isDeleted=Y" title="已删除">已删除<i></i></a>
                <a <c:if test="${param.isPayed == 'Y' && param.isRefunded == 'Y'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&isRefunded=Y" title="已退款">已退款</a>
            </div>
            <!--tit end-->
            <div class="s-tit">
                <span class="tit01">商品名称</span>
                <span class="tit02">单价（元）</span>
                <span class="tit03">数量</span>
                <span class="tit04">实付款（元）</span>
                <span class="tit05">订单状态</span>
                <span class="tit06">操作</span>
            </div>

            <%--未付款--%>
            <c:if test="${param.isPayed == 'N' && param.orderStatus == '0'}">
                <c:forEach items="${orderPage.result}" var="orderProxy">
                    <div class="item item-nopay">
                            <div class="i-tit">
                                <strong>订单编号：${orderProxy.otooOrderNum}</strong>下单时间:${orderProxy.otooOrderCreateTime}<i></i>
                                <a href="javascript:void(0);" onclick="cancelOrder(${orderProxy.otooOrderId})">取消订单</a>
                            </div>
                            <div class="i-con">
                                <div class="con01">
                                    <a class="img" href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank" title="${orderProxy.otooProductName}"><img src="${orderProxy.productImages}" alt="${orderProxy.otooProductName}"></a>
                                    <em><a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="">${orderProxy.otooProductName}</a></em>
                                </div>
                                <div class="con02">&yen;${orderProxy.unitPrice}</div>
                                <div class="con03">${orderProxy.otooOrderAmount}</div>
                                <div class="con04">&yen;${orderProxy.totalPrice}</div>
                                <div class="con05 no-pay">未付款</div>
                                <div class="con06">
                                    <a href="${webRoot}/module/member/otoo/myOrderDetail.ac?id=${orderProxy.otooOrderId}&isPayed=N" title="查看详情">查看详情</a>
                                    <a class="btn" href="${webRoot}/shoppingcart/cashier.ac?orderType=otooOrder&orderIds=${orderProxy.otooOrderId}">立即支付</a>
                                </div>
                            </div>
                    </div>
                </c:forEach>
            </c:if>

            <%--未使用--%>
            <c:if test="${param.isPayed == 'Y' && param.used == 'N'}">
                <c:forEach items="${orderPage.result}" var="orderProxy">
                    <div class="item">
                        <div class="i-tit">
                            <strong>订单编号：${orderProxy.otooOrderNum}</strong>下单时间:${orderProxy.otooOrderCreateTime}<i></i>
                        </div>
                        <div class="i-con">
                            <div class="con01">
                                <a class="img" href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title=""><img src="${fn:replace(orderProxy.productImages,'_50X50','')}"  alt="${orderProxy.otooProductName}"></a>
                                <em><a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="">${orderProxy.otooProductName}</a></em>
                            </div>
                            <div class="con02">&yen;${orderProxy.unitPrice}</div>
                            <div class="con03">${orderProxy.otooOrderAmount}</div>
                            <div class="con04">&yen;${orderProxy.totalPrice}</div>
                            <div class="con05 no-use">未使用</div>
                            <div class="con06"><a href="${webRoot}/module/member/otoo/myOrderDetail.ac?id=${orderProxy.otooOrderId}&isUsed=N" title="查看详情">查看详情</a></div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <%--已使用--%>
            <c:if test="${param.isPayed == 'Y' && param.used == 'Y'}">
                <c:forEach items="${orderPage.result}" var="orderProxy">
                    <div class="item item-used">
                        <div class="i-tit">
                            <strong>订单编号：${orderProxy.otooOrderNum}</strong>下单时间:${orderProxy.otooOrderCreateTime}<i style="cursor:pointer" onclick="deleteOrder(${orderProxy.otooOrderId})"></i>
                        </div>
                        <div class="i-con">
                            <div class="con01">
                                <a class="img" href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title=""><img src="${fn:replace(orderProxy.productImages,'_50X50','')}" alt="${orderProxy.otooProductName}"></a>
                                <em><a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="">${orderProxy.otooProductName}</a></em>
                            </div>
                            <div class="con02">&yen;${orderProxy.unitPrice}</div>
                            <div class="con03">${orderProxy.otooOrderAmount}</div>
                            <div class="con04">&yen;${orderProxy.totalPrice}</div>
                            <div class="con05">已使用</div>
                            <div class="con06">
                                <a href="${webRoot}/module/member/otoo/myOrderDetail.ac?id=${orderProxy.otooOrderId}&isUsed=Y" title="查看详情">查看详情</a>
                                <c:if test="${orderProxy.isComment == 'N' && orderProxy.otooIsAllRefund == 'N'}">
                                    <a href="javascript:void(0);" id="comment" onclick="comment(${orderProxy.otooOrderId})">评价</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <%--已取消--%>
            <c:if test="${param.orderStatus == '2'}">
                <c:forEach items="${orderPage.result}" var="orderProxy">
                    <div class="item item-cancel">
                        <div class="i-tit">
                            <strong>订单编号：${orderProxy.otooOrderNum}</strong>下单时间:${orderProxy.otooOrderCreateTime}<i style="cursor:pointer" onclick="deleteOrder(${orderProxy.otooOrderId})"></i>
                        </div>
                        <div class="i-con">
                            <div class="con01">
                                <a class="img" href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title=""><img src="${fn:replace(orderProxy.productImages,'_50X50','')}"  alt="${orderProxy.otooProductName}"></a>
                                <em><a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="">${orderProxy.otooProductName}</a></em>
                            </div>
                            <div class="con02">&yen;${orderProxy.unitPrice}</div>
                            <div class="con03">${orderProxy.otooOrderAmount}</div>
                            <div class="con04">&yen;${orderProxy.totalPrice}</div>
                            <div class="con05">已取消</div>
                            <div class="con06"><a href="${webRoot}/module/member/otoo/myOrderDetail.ac?id=${orderProxy.otooOrderId}&isCanceld=Y" title="查看详情">查看详情</a></div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <%--已删除--%>
            <c:if test="${param.isDeleted == 'Y'}">
                <c:forEach items="${orderPage.result}" var="orderProxy">
                    <div class="item item-del">
                        <div class="i-tit">
                            <strong>订单编号：${orderProxy.otooOrderNum}</strong>下单时间:${orderProxy.otooOrderCreateTime}<i></i>
                        </div>
                        <div class="i-con">
                            <div class="con01">
                                <a class="img" href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title=""><img src="${fn:replace(orderProxy.productImages,'_50X50','')}"  alt="${orderProxy.otooProductName}"></a>
                                <em><a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="">${orderProxy.otooProductName}</a></em>
                            </div>
                            <div class="con02">&yen;${orderProxy.unitPrice}</div>
                            <div class="con03">${orderProxy.otooOrderAmount}</div>
                            <div class="con04">&yen;${orderProxy.totalPrice}</div>
                            <div class="con05">已删除</div>
                            <div class="con06"><a href="${webRoot}/module/member/otoo/myOrderDetail.ac?id=${orderProxy.otooOrderId}&isDeleted=Y" title="查看详情">查看详情</a></div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <%--已退款--%>
            <c:if test="${param.isPayed == 'Y' && param.isRefunded == 'Y'}">
                <c:forEach items="${orderPage.result}" var="orderProxy">
                    <div class="item item-tui">
                        <div class="i-tit">
                            <strong>订单编号：${orderProxy.otooOrderNum}</strong>下单时间:${orderProxy.otooOrderCreateTime}
                        </div>
                        <div class="i-con">
                            <div class="con01">
                                <a class="img" href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="${orderProxy.otooProductName}"><img src="${fn:replace(orderProxy.productImages,'_50X50','')}"  alt="${orderProxy.otooProductName}"></a>
                                <em><a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank"  title="">${orderProxy.otooProductName}</a></em>
                            </div>
                            <div class="con02">&yen;${orderProxy.unitPrice}</div>
                            <div class="con03">${orderProxy.otooOrderAmount}</div>
                            <div class="con04">&yen;${orderProxy.totalPrice}</div>
                            <div class="con05">已退款</div>
                            <div class="con06"><a href="${webRoot}/module/member/otoo/myOrderDetail.ac?id=${orderProxy.otooOrderId}&isRefund=Y" title="查看详情">查看详情</a></div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <c:if test="${orderPage.lastPageNumber >1}">
            <div class="page">
                <div style="float:right">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/otoo/myOrderList.ac" totalPages='${orderPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${orderPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
                </div>
            </div>
        </c:if>
    <div class="clear"></div>
</div>

<%--商品评价弹出层--%>
<div class="evaluate" style="display: none;" id="productComment">
    <input type="hidden" id="orderId"/>
    <div class="e-tit">
        <h3>评价商品</h3>
        <a href="javascript:void(0)" title="关闭" onclick="hideLayer()">关闭</a>
    </div>
    <div class="e-con">
        <div class="li li01">
            <span class="label">总体评分</span>
            <span class="stars">
              <a href="javascript:void(0)" class="cur" id="star1"></a>
              <a href="javascript:void(0)" class="cur" id="star2"></a>
              <a href="javascript:void(0)" class="cur" id="star3"></a>
              <a href="javascript:void(0)" class="cur" id="star4"></a>
              <a href="javascript:void(0)" class="cur" id="star5"></a>
            </span>
            <span class="margin-left:20px;"><label style="vertical-align: middle">是否匿名:</label><label><input type="checkbox" style="vertical-align: middle" id="isAnonymousComment"/></label></span>
        </div>
        <div class="li li02">
            <span class="label">点评内容</span>
            <textarea placeholder="字节长度请在5～200字范围之间。" id="commentCont"></textarea>
        </div>
        <a class="btn" href="javascript:void(0)" id="addComment" onclick="addComment()">发表评论</a>
    </div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>

</body>
</html>
