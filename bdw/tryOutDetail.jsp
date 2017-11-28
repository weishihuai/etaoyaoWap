<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:if test="${empty param.id}">
    <c:redirect url="/index.jsp"/>
</c:if>
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set value="${sdk:getLoginUser()}" var="user"/>
<%-- 获取免费试用详情 --%>
<c:set value="${bdw:getFrialTrialProxy(param.id)}" var="frialTrialProxy"/>

<%-- 参数 --%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_reportPage"/>
<c:set value="${empty param.tabType ? 'dt' : param.tabType}" var="tabType"/>

<%-- 获取已经申请过的申请记录 --%>
<c:set value="${bdw:findFrialTrialApply(param.id,4)}" var="frialTrialApplyPage"/>
<%-- 获取报告--%>
<c:set value="${bdw:findSyeeTriaApplyProxyReportPage(4,param.id)}" var="findSyeeTriaApplyProxyReportPage"/>
<c:set value="${user.receiverAddress}" var="addrProxy"/>

<jsp:useBean id="systemTime" class="java.util.Date" />
<head>
    <meta property="qc:admins" content="3553273717624751446375" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}"/>
    <title>免费试用-${webName}</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/tryOutDetail.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/ObjectToJsonUtil.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tryOutDetail.js"></script>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}", endTimeLimit: "<fmt:formatDate value="${frialTrialProxy.endDate}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",isLogin:'${not empty user}'};
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<!--页头结束-->

<!--主体-->
<div class="t-main">
    <div class="past">
        <div class="first">
            <span><a href="${webRoot}/index.ac">首页</a></span>
            <i class="crumbs-arrow"></i>
        </div>
        <a href="${webRoot}/tryOutList.ac" class="cata">免费试用</a>
        <i class="crumbs-arrow"></i>
        <a href="javascript:void(0);" class="cata">${frialTrialProxy.productNm}</a>
    </div>
    <div class="w clearfix">
        <div class="fl">
            <div class="detail-meta clearfix">
                <div class="mt"><a href="javascript:void(0);"><img src="${frialTrialProxy.defaultImage['']}" width="380" height="380"></a></div>
                <div class="mc">
                    <a href="javascript:void(0);" class="title">${frialTrialProxy.productNm}  </a>
                    <div class="mc-main">
                        <div class="item">产品价值<span class="gl-price">¥<em>${frialTrialProxy.valueAmount}</em></span></div>
                        <div class="item">限量试用<span>${frialTrialProxy.stock}</span>份</div>
                        <div class="item">消耗积分<span>${frialTrialProxy.integralPrice}</span>分</div>
                        <div class="people"><span>${frialTrialProxy.applyTotal}</span>人已申请</div>
                    </div>
                    <div class="time" id="countdownTime"></div>
                    <c:choose>
                        <c:when test="${systemTime < frialTrialProxy.endDate && systemTime > frialTrialProxy.startDate}">
                            <c:choose>
                                <c:when  test="${frialTrialProxy.stock >frialTrialProxy.applyTotal}">
                                    <a href="javascript:void(0);" class="btn" id="apply" integal="${frialTrialProxy.integralPrice}">申请试用</a>

                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:void(0);" class="btn1" >申请数量已满</a>

                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="btn" integal="${frialTrialProxy.integralPrice}" >已结束申请</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <ul class="flow">
                <li>
                    <i>1</i>
                    <span>产品申请</span>
                    <p>点击立即申请试用按钮，即可参与活动</p>
                </li>
                <li>
                    <i>2</i>
                    <span>获得试用资格</span>
                    <p>根据您的会员活跃维度，获得试资格</p>
                </li>
                <li>
                    <i>3</i>
                    <span>收货体验</span>
                    <p>平台将试用寄送产品，供用户体验</p>
                </li>
                <li>
                    <i>4</i>
                    <span>报告提交</span>
                    <p>申请成功的会员需在规定时限内提交试用报告</p>
                </li>
            </ul>


            <ul class="minute-menu">
                <li <c:if test="${tabType == 'dt'}">class="cur"</c:if> tab="dt"><a href="${webRoot}/tryOutDetail.ac?id=${frialTrialProxy.freeTrialId}&tabType=dt">试用详情</a></li>
                <li <c:if test="${tabType == 'list'}">class="cur"</c:if> tab="list"><a href="${webRoot}/tryOutDetail.ac?id=${frialTrialProxy.freeTrialId}&tabType=list">申请名单</a></li>
                <li <c:if test="${tabType == 'report'}">class="cur"</c:if> tab="report"><a href="${webRoot}/tryOutDetail.ac?id=${frialTrialProxy.freeTrialId}&tabType=report">试用报告(${findSyeeTriaApplyProxyReportPage.totalCount})</a></li>
            </ul>


            <!--试用详情-->
            <div class="dt-cont tab_cont" <c:if test="${tabType == 'dt'}">style="display: block"</c:if>>
                ${frialTrialProxy.applyRule}
            </div>

            <!--申请名单-->
            <div class="list-cont tab_cont" <c:if test="${tabType == 'list'}">style="display: block"</c:if>>
                <table cellspacing="0" cellpadding="0">
                    <thead class="title">
                    <tr>
                        <th style="width: 218px;">申请用户</th>
                        <th style="width: 200px;">抵押积分</th>
                        <th style="width: 295px;">申请时间</th>
                        <th style="width: 225px;">试用报告</th>
                    </tr>
                    </thead>
                    <tbody class="cont">
                    <c:forEach items="${frialTrialApplyPage.result}" var="frial">
                        <tr>
                            <td>${fn:substring(frial.loginId,0,4)}****</td>
                            <td>${frial.costIntegral}</td>
                            <td><fmt:formatDate value="${frial.applyTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" /></td>
                            <c:choose>
                                <c:when test="${not empty frial.repTitle && frial.repIsPass eq 'Y'}">
                                    <td><a href="${webRoot}/tryDetail.ac?id=${frial.freeTrialApplyId}">查看试用报告</a></td>
                                </c:when>
                                <c:when test="${not empty frial.repTitle}">
                                    <td>报告未通过</td>
                                </c:when>
                                <c:otherwise>
                                    <td>未提交报告</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="pager">

                        <c:if test="${frialTrialApplyPage.lastPageNumber > 1}">
                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${frialTrialApplyPage.lastPageNumber}' currentPage='${_page}' totalRecords='${frialTrialApplyPage.totalCount}' ajaxUrl='${webRoot}/tryOutDetail.ac' frontPath='${webRoot}' displayNum='6'/>
                        </c:if>
                </div>
            </div>

            <%-- 试用报告 --%>
            <div class="report-cont tab_cont" <c:if test="${tabType == 'report'}">style="display: block"</c:if> >
                <div class="rc-main">

                    <c:forEach items="${findSyeeTriaApplyProxyReportPage.result}" var="report">
                        <div class="item">
                            <div class="mlt">
                                <div class="pic"><img src="${report.icon['']}" height="60" width="60"></div>
                                <span>${fn:substring(report.loginId,0,4)}****</span>
                            </div>
                            <div class="mmd">
                                <div class="title elli">${report.repTitle}  </div>
                                <p>${report.repCont}</p>
                                <div class="md-bot">
                                    <div class="time">发表于：<fmt:formatDate value="${report.repSubmitTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" /></div>
                                    <a href="${webRoot}/tryDetail.ac?id=${report.freeTrialApplyId}" class="ck-btn">查看详情</a>
                                    <%--<div class="zan "><!-- 点击加class:cur -->--%>
                                        <%--<span>+1</span>--%>
                                        <%--<em>86</em>--%>
                                    <%--</div>--%>
                                </div>
                            </div>
                            <div class="mrt"><a href="javascript:void(0);"><img src="${fn:split(report.repPict,',')[0]}" alt="${report.productNm}"></a></div>
                        </div>
                    </c:forEach>
                </div>
                <div class="pager">

                        <c:if test="${findSyeeTriaApplyProxyReportPage.lastPageNumber > 1}">
                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${findSyeeTriaApplyProxyReportPage.lastPageNumber}' currentPage='${_reportPage}' totalRecords='${findSyeeTriaApplyProxyReportPage.totalCount}' ajaxUrl='${webRoot}/tryOutDetail.ac' frontPath='${webRoot}' displayNum='6'/>
                        </c:if>
                </div>
            </div>

        </div>
        <div class="fr">
            <div class="item">
                <h4>免费试用流程</h4>
                <div class="flow">
                    <ul>
                        <li class="elli">具备试用资格</li>
                        <li class="elli">积分抵押参与免费试用商品申请</li>
                        <li class="elli">提交300字以上试用报告</li>
                        <li class="elli">返还申请时抵押积分</li>
                        <li class="elli">获得免费试用奖励</li>
                    </ul>
                </div>
            </div>
            <div class="item">
                <h4>什么是免费试用？</h4>
                <p>免费试用是专注于消费领域的试用平台，在这里网友们不仅能体验新品，更能通过输出真实客观的试用报告来分享使用心得。</p>
            </div>
        </div>
    </div>
</div>


<form method="post" id="addFrom">
    <input id="freeTrialId" name="freeTrialId" type="hidden" value="${param.id}">
    <input id="applyReason" name="applyReason" type="hidden" value="">
    <input id="receiverId" name="receiverId" type="hidden">
    <input id="couponBatchId" name="couponBatchId" type="hidden" value="${frialTrialProxy.couponBatchId}">
    <input id="integralPrice" name="integralPrice" type="hidden" value="${frialTrialProxy.integralPrice}">
    <input id="joinWayCode" name="joinWayCode" type="hidden" value="">
</form>
<!--弹窗-->
<div class="overlay" style="display: none;">
    <div class="lightbox reason">
        <div class="mt">
            <span>填写申请理由</span>
            <a href="javascript:void(0)" class="close applyClose">&times;</a>
        </div>
        <div class="mc">
            <h5>您的账户将抵押<span id="userIntegal"></span>积分，用于免费体验资格</h5>
            <p>若申请成功，需要提交真实原创的300字以上的试用报告，锁定积分自动返还，并有神秘奖励！</p>
            <div class="rs-box">
                <div class="rs-th">申请理由</div>
                <div class="rs-td">
                    <input type="hidden" id="selReceiverId" value="${addrProxy[0].receiveAddrId}"/>
                    <textarea placeholder="请输入你要申请的内容" id="integralText"></textarea>
                </div>
            </div>
            <div class="sp-addr">
                <div class="sp-th">收货地址</div>
                <div class="sp-td">
                    <c:forEach items="${addrProxy}" var="vo" varStatus="s">
                        <div class="sp-item <c:if test='${s.first}'>cur</c:if> " >
                            <i class="receiver" receiverId="${vo.receiveAddrId}"></i>
                            <span>${vo.name}</span>
                            <span>${vo.mobile}</span>
                            <span>${vo.addressPath}-${vo.addr}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="form-agreen">
                <i class="accept cur"></i>
                <a href="javascript:void(0);">我同意并遵守《免费体验协议》</a>
            </div>
        </div>
        <div class="md">
            <a href="javascript:void(0);" onclick="sendPayIntegral()" class="btn01">确认</a>
            <a href="javascript:void(0);" class="btn02 applyClose">取消</a>
        </div>
    </div>
</div>

<!--底部-->
<c:import url="/template/bdw/module/common/bottom.jsp"/>


</body>
</html>
