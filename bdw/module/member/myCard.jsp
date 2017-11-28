<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="sy"%>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${empty param.isBind ? 'N' : param.isBind}" var="isBind"/>
<c:set value="${sy:getCardPage(page,5,isBind)}" var="cardProxyPage"/>

<!DOCTYPE html>
<html>
<head>
	<meta name="renderer" content="webkit">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
	<title>礼品卡中心-${webName}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/myCard.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}"
        };
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myCard.js"></script>
</head>
<body>
<c:import url="/template/bdw/module/common/top.jsp?p=myCard"/>
<div id="position" class="m1-bg">
    <div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> > <a
            href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >礼品卡
    </div>
</div>
<div id="member">
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>

    <div class="ct-box center-box" style="float: right;">
        <div class="ct-mt">
            <span>礼品卡中心</span>
        </div>
        <div class="ct-mc">
            <div class="ct-dt">
                <div class="dt-top">
                    <span>卡账号</span>
                    <input type="text" id="cardNum">
                    <span>卡密码</span>
                    <input type="password" id="cardPsw">
                    <a href="javascript:void(0);" class="dt-btn" id="bindCard">绑定礼品卡</a>
                </div>
                <p><span>温馨提示：</span>绑定礼品卡金额会直接充值到易淘药平台预存款。</p>
            </div>
            <div class="ct-dc">
                <div class="dc-nav">
                    <a href="javascript:void(0);" class="<c:if test="${isBind == 'N'}">cur</c:if> cardTab" isBind="N">未绑定电子礼品卡</a>
                    <a href="javascript:void(0);" class="<c:if test="${isBind == 'Y'}">cur</c:if> cardTab" isBind="Y">已绑定礼品卡</a>
                </div>
                <div class="dc-tabpain">
                    <div class="pain-item">
                        <c:choose>
                            <c:when test="${isBind == 'N'}">
                                <div class="pain-cont">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th style="text-align: left; padding-left: 19px; width: 211px;">礼品卡名称</th>
                                            <th style="width: 177px;">电子卡号</th>
                                            <th style="width: 174px;">电子卡密</th>
                                            <th style="width: 110px">卡性质</th>
                                            <th style="width: 109px;">单价</th>
                                            <th style="width: 129px; border-right: 1px solid #e8e8e8;">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cardProxyPage.result}" var="card" varStatus="s">
                                                <tr>
                                                    <c:choose>
                                                        <c:when test="${card.cardSource == '普通卡'}">
                                                            <c:set value="ptk" var="cardSource"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set value="flk" var="cardSource"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td><a href="javascript:void(0);" class="title">${card.cardBatchNm}</a></td>
                                                    <td><span>${card.cardNum}</span></td>
                                                    <td><span>${card.cardPsw}</span></td>
                                                    <td><em class="${cardSource}">${card.cardSource}</em></td>
                                                    <td><span>￥${card.cardAmount}</span></td>
                                                    <td><a href="javascript:void(0);" class="bd-btn bindNow" cardId="${card.cardId}">立即绑定</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="pain-cont">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th style="text-align: left; padding-left: 19px; width: 210px;">礼品卡名称</th>
                                            <th style="width: 189px;">卡号</th>
                                            <th style="width: 109px;">卡类型</th>
                                            <th style="width: 109px">卡性质</th>
                                            <th style="width: 109px;">面值</th>
                                            <th style="width: 183px; border-right: 1px solid #e8e8e8;">绑定时间</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cardProxyPage.result}" var="card" varStatus="s">
                                                <c:choose>
                                                    <c:when test="${card.cardSource == '普通卡'}">
                                                        <c:set value="ptk" var="cardSource"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set value="flk" var="cardSource"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${card.cardType == '电子卡'}">
                                                        <c:set value="dzk" var="cardType"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set value="swk" var="cardType"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <tr>
                                                    <td><a href="javascript:void(0);" class="title">${card.cardBatchNm}</a></td>
                                                    <td><span>${card.cardNum}</span></td>
                                                    <td><em class="${cardType}">${card.cardType}</em></td>
                                                    <td><em class="${cardSource}">${card.cardSource}</em></td>
                                                    <td><span>￥${card.cardAmount}</span></td>
                                                    <td><em class="time">${card.bindTimeString}</em></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <%--<div class="pager">
                            <div id="infoPage">
                                <ul>
                                    <li><a title="上一页" class="upPage" href="">上一页</a></li>
                                    <li><a class="everyPage" href="">1</a></li>
                                    <li><span class="nowPage">2</span></li>
                                    <li><a class="everyPage" href="">3</a></li>
                                    <li><a class="everyPage" href="">4</a></li>
                                    <li><a class="everyPage" href="">5</a></li>
                                    <li><a class="everyPage" href="">6</a></li>
                                    <li><a title="下一页" class="downPage" href="">下一页</a></li>
                                    <li><div id="page-skip">&nbsp;&nbsp;第&nbsp;<input value="3" id="inputPage">&nbsp;页/128页<button class="goToPage" onclick="" href="javascript:;">确定</button><div></div></div></li>
                                </ul>
                            </div>
                        </div>--%>
                        <c:if test="${cardProxyPage.totalCount>5}">
                            <div class="pager">
                                <div id="infoPage">
                                    <p:PageTag
                                            isDisplayGoToPage="true"
                                            isDisplaySelect="false"
                                            ajaxUrl="${webRoot}/template/bdw/module/member/myCard.jsp"
                                            totalPages='${cardProxyPage.lastPageNumber}'
                                            currentPage='${page}'
                                            totalRecords='${cardProxyPage.totalCount}'
                                            frontPath='${webRoot}'
                                            displayNum='6'/>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>

