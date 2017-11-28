<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="yz"%>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="${sdk:getArticleCategoryById(60049)}" var="articleCategoryProxy"/><%--获取优惠券使用常见问题--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  <%--获取页码--%>
<c:set value="${empty param.is ? 'N' : param.is}" var="is"/>  <%--获取优惠卷类型--%>
<c:set value="${yz:getCouponPage(_page,10,is)}" var="couponProxys"/><%--当前优惠卷--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-我的购物劵 - ${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript">
        var dataValue={
            //myCoupon.js URL前路径引用
            webRoot:"${webRoot}"
        };
        var myValue={
            //优惠卷类型
            is:"${is}"
        };
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myCoupon.js"></script><%--我的购物劵页面js--%>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.ac">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 我的购物劵</div></div>
<%--面包屑导航 end--%>


<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <div class="myCoupons">
            <h2 class="rightbox_h2_border">购物券</h2>
            <div class="box right_box_border">
                <div class="m1">
                    <label>购物券编号：</label>
                    <div class="put"><input id="cardNum" type="text" /></div>
                    <label>购物券密码：</label>
                    <div class="put"><input type="password" id="cardPwd" /></div>
                    <div class="btn"><a href="javascript:" id="bindCoupon">激活</a></div><%--myCoupon.js对bindCoupon绑定事件--%>
                </div>
                <div class="m2">
                    <div class="t_Menu">
                        <ul>
                            <li><a id="unUseTab" class="coupontab cur" href="javascript:void(0);">未使用的购物券</a></li>
                            <li><a id="usedTab" class="coupontab" href="javascript:void(0);">已使用的购物券</a></li>
                            <li><a id="canceledTab" class="coupontab" href="javascript:void(0);">已过期的购物券</a></li>
                        </ul>
                    </div>
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td0">编号</td>
                            <td class="td1">批次名称</td>
                            <td class="td2">面值</td>
                            <td class="td4">有效期</td>
                            <td class="td6">状态</td>
                            <c:if test="${empty param.is || param.is eq 'N' || param.is eq 'Y'}">
                                <td class="td7">使用规则说明</td>
                            </c:if>
                        </tr>
                        <%--未使用的购物券 start--%>
                        <c:choose>
                            <c:when test="${empty couponProxys}">
                                <tr class="unUse">
                                    <td colspan="6" class="col">没有购物券记录</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${couponProxys.result}" var="couponProxy" varStatus="s">
                                    <tr class="unUse thead-tbl-coupon" num="${s.count}">
                                        <td class="td0">${couponProxy.couponNum}</td>
                                        <td class="td1">${couponProxy.batchNm}</td>
                                        <td class="td2"><span>￥<fmt:formatNumber value="${couponProxy.amount}" type="number" pattern="#0.00#" /></span></td>
                                        <td class="td4">${couponProxy.endTimeString}</td>
                                        <td class="td6">${couponProxy.couponStat}</td>
                                        <c:if test="${empty param.is || param.is eq 'N' || param.is eq 'Y'}">
                                            <td class="td7"><a href="javascript:" num="${s.count}" class="defaultBtn useRuleState" couponId ="${couponProxy.couponId}">查看使用规则</a></td>
                                        </c:if>
                                        <%--显示使用规则信息--%>
                                        <div class="ruleMsg" id="rule${s.count}" style="display:none;background:#f8f8f8;width: 450px;overflow-y: scroll; padding-top:10px; ">
                                            <div style="text-align: center">
                                                    ${couponProxy.ruleUseMessage}
                                            </div>
                                        </div>
                                    </tr>
                                </c:forEach>

                            </c:otherwise>
                        </c:choose>
                        <%--未使用的购物券 end--%>
                    </table>
                    <c:if test="${couponProxys.totalCount>1}">
                        <div style="width: 770px;height:30px;padding-top:10px;text-align: right;">
                            <p:PageTag
                                    isDisplayGoToPage="true"
                                    isDisplaySelect="false"
                                    ajaxUrl="${webRoot}/template/bdw/module/member/myCoupon.jsp"
                                    totalPages='${couponProxys.lastPageNumber}'
                                    currentPage='${_page}'
                                    totalRecords='${couponProxys.totalCount}'
                                    frontPath='${webRoot}'
                                    displayNum='6'/>
                        </div>
                    </c:if>
                </div>
                <div class="m3">
                    <h1>优惠券使用常见问题：</h1>
                    <p>
                        <c:forEach items="${articleCategoryProxy.top5}" var="articleProxy" varStatus="s" begin="0" end="3">
                            ${s.count}.<a href="${webRoot}/mallNotice-${articleProxy.infArticleId}-${articleProxy.categoryId}.html" target="_blank" title="${articleProxy.title}">${articleProxy.title}</a>
                        </c:forEach>
                    </p>
                </div>
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
