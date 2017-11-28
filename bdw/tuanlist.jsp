<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%--<c:set value="${param.category}" var="categoryId"/>
<c:set value="${empty param.tSelect ? 'process' : param.tSelect}" var="tSelect"/>
<c:set value="${sdk:queryGroupBuyCategoryById(15)}" var="category"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  &lt;%&ndash;获取页码&ndash;%&gt;

<c:set value="${bdw:getpreviewGroupBuyList(_page,9,categoryId)}" var="previewGroupBuyProduct"/>  &lt;%&ndash;团购预告分页&ndash;%&gt;--%>

<c:set var="loginUser" value="${sdk:getLoginUser()}" />
<jsp:useBean id="systemTime" class="java.util.Date" />
<c:set value="${sdk:queryGroupBuyCategoryById(15)}" var="category"/>
<c:set value="${empty param.categoryId? 15:param.categoryId}" var="categoryId"/>
<c:set value="${empty param.type? 'groupBuyIN':param.type}" var="type"/>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<%--<c:set value="${sdk:findGroupBuyPage(page,6,categoryId,type)}" var="group"/>  &lt;%&ndash;团购&ndash;%&gt;--%>
<c:set value="${sdk:findGroupBuyPage(page,6,categoryId,type)}" var="group"/>  <%--团购--%>
<%--<c:set value="${bdw:getTodayGroupBuyList(page,9,categoryId)}" var="group"/>     &lt;%&ndash;今日团购分页&ndash;%&gt;--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-团购-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/teamBuy.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/tuanlist.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <!--[if IE 6]>

    <script>DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');</script><![endif]-->
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script  type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.lazyload.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tuanlist.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common-func.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/DD_belatedPNG_0.0.8a-min.js"></script>

    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=tuan"/>
<%--页头结束--%>

<%--<div id="main">
    <div class="layer">
        <div class="now"><a class="cur tab" href="${webRoot}/tuanlist.ac?tSelect=process">进行中的团购</a></div>
        <div class="ready"><a class="tab" href="${webRoot}/tuanlist.ac?tSelect=already">即将开团</a></div>
    </div>

    &lt;%&ndash;团购分类 开始&ndash;%&gt;
    <div class="group">
        <div class="group-bg" style="padding-top:7px;_padding-top:7px;padding-bottom:10px;_padding-bottom:0px;overflow: hidden;">
            <c:forEach  items="${category.children}" var="node" varStatus="s">
                <div style="height: 25px;overflow: hidden;">
                    <span>${node.name}</span>
                    <img src="${webRoot}/template/bdw/statics/images/02-01.png" />
                    <a id="${node.categoryId}" class="cur" href="${webRoot}/tuanlist.ac?category=${node.categoryId}&tSelect=${tSelect}">全部</a>
                    <c:set var="secondLength" value="${fn:length(node.children)}"></c:set>
                    <c:choose>
                        <c:when test="${secondLength <= 4}">
                            <c:forEach items="${node.children}" var="subnode" varStatus="sub">
                                <a id="${subnode.categoryId}" href="${webRoot}/tuanlist.ac?category=${subnode.categoryId}&tSelect=${tSelect}">${subnode.name}</a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${node.children}" var="subnode" varStatus="sub">
                                <a id="${subnode.categoryId}" href="${webRoot}/tuanlist.ac?category=${subnode.categoryId}&tSelect=${tSelect}" <c:if test="${sub.count > 4 }">style="display:none;" class="node" </c:if>>${subnode.name}</a>
                            </c:forEach>
                            <a id="more" href="javascript:" style="color: #3399ff; font-family: '微软雅黑'; font-size: 14px;">更多>></a>
                            <a id="hide" href="javascript:" style="display: none; color: #3399ff; font-family: '微软雅黑'; font-size: 14px;">隐藏<<</a>
                        </c:otherwise>
                    </c:choose>

                </div>
            </c:forEach>
        </div>
    </div>
    &lt;%&ndash;团购分类 结束&ndash;%&gt;

    &lt;%&ndash;进行中的团购  开始&ndash;%&gt;
    <div class="list process">
        <ul style="overflow: hidden;">
            <c:forEach items="${groupBuyProduct.result}" var="today" >
                <li>
                    <div style="height: 258px;width:386px; overflow: hidden;"><a href="${webRoot}/tuan.ac?id=${today.groupBuyId}" target="_blank"><img src="${today.pic}" height="100%" width="100%"/></a></div>
                    <div style="font-size: 14px;font-weight: bold;padding: 15px 0 0 15px;overflow: hidden;text-overflow: '';white-space: nowrap;"><a href="${webRoot}/tuan.ac?id=${today.groupBuyId}" target="_blank" title="${sdk:cutString(today.title, 80, '')}">${sdk:cutString(today.title, 80, "")}</a></div>
                    <div class="price" style="text-align: center">
                        <a href="javascript:void(0)" >原价：￥<fmt:formatNumber value="${today.orgPrice}" type="number" pattern="#0.00#" /></a>
                        <a href="javascript:void(0)" >折扣：<fmt:formatNumber  value="${today.discount/10}" type="number"  pattern="#0.0#"/>折</a>
                        <a href="javascript:void(0)" >购买<span>${today.soldQuantity}</span>件</a>
                    </div>
                    <div class="li">
                        <p><a href="javascript:void(0)">￥<fmt:formatNumber value="${today.price.unitPrice}" type="number" pattern="#0.00#" /></a></p>
                        <h4><a href="${webRoot}/tuan.ac?id=${today.groupBuyId}" target="_blank"><img src="${webRoot}/template/bdw/statics/images/02-08.PNG" /></a></h4>
                        <div class="clear"></div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <c:if test="${tSelect=='process'}">
        <div class="page" style="margin-bottom: 37px">
            <div style="float: right;">
                <c:if test="${groupBuyProduct.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${groupBuyProduct.lastPageNumber}' currentPage='${_page}'  totalRecords='${groupBuyProduct.totalCount}' ajaxUrl='${webRoot}/tuanlist.ac' frontPath='${webRoot}' displayNum='6' />
                </c:if>
            </div>
        </div>
    </c:if>
    &lt;%&ndash;进行中的团购 结束&ndash;%&gt;

    &lt;%&ndash;即将开团 开始&ndash;%&gt;
    <div class="list already" style="display: none;">
        <ul style="overflow: hidden;">
            <c:forEach items="${previewGroupBuyProduct.result}" var="preview">
                <li>
                    <div style="height: 258px;width: 386px;overflow: hidden;"><a href="${webRoot}/tuan.ac?id=${preview.groupBuyId}" target="_blank"><img style="height: 258px;width: 386px;" src="${preview.pic}"/></a></div>
                    <div style="font-size: 14px;font-weight: bold;padding: 15px 0 0 15px;overflow: hidden;text-overflow: '';white-space: nowrap;"><a href="${webRoot}/tuan.ac?id=${preview.groupBuyId}" target="_blank" title="${sdk:cutString(preview.title, 80, '')}">${sdk:cutString(preview.title, 80, "")}</a></div>
                    <div class="price" style="text-align: center">
                        <a href="javascript:void(0)" >原价：￥<fmt:formatNumber value="${preview.orgPrice}" type="number" pattern="#0.00#" /></a>
                        <a href="javascript:void(0)" >折扣：<fmt:formatNumber  value="${preview.discount/10}" type="number"  pattern="#0.0#"/>折</a>
                        <a href="javascript:void(0)" >购买<span>${preview.soldQuantity}</span>件</a>
                    </div>
                    <div class="li">
                        <p><a href="javascript:void(0)">￥<fmt:formatNumber value="${preview.price.unitPrice}" type="number" pattern="#0.00#" /></a></p>
                        <h4><a href="${webRoot}/tuan.ac?id=${preview.groupBuyId}" target="_blank"><img  src="${webRoot}/template/bdw/statics/images/02-08.PNG" /></a></h4>
                        <div class="clear"></div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <c:if test="${tSelect=='already'}">
        <div class="page" style="margin-bottom: 37px">
            <div style="float: right;">
                <c:if test="${previewGroupBuyProduct.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${previewGroupBuyProduct.lastPageNumber}' currentPage='${_page}'  totalRecords='${previewGroupBuyProduct.totalCount}' ajaxUrl='${webRoot}/tuanlist.ac' frontPath='${webRoot}' displayNum='6' />
                </c:if>
            </div>
        </div>
    </c:if>
    &lt;%&ndash;即将开团 结束&ndash;%&gt;
</div>--%>

<!--主体-->
<div class="banner">
    <div class="cont">
        <ul class="slider-main frameEdit" frameInfo="yaoBulk_banner_adv|1920X300" id="focus-cont">
            <c:set value="${sdk:findPageModuleProxy('yaoBulk_banner_adv').advt.advtProxy}" var="advtVar"/>
            <c:forEach items="${advtVar}" var="advtProxys" varStatus="s">
                <c:choose>
                    <c:when test="${s.first}">
                        <li style="display: block; position: absolute; opacity:1; z-index: 1; background-color: #b6d35d;">
                            <div class="cont-box">
                                <a href="${advtProxys.link}" title="${advtProxys.title}" target="_blank"><img src="${advtProxys.advUrl}" height="300" width="1920"></a>
                            </div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li style="display: block; position: absolute; opacity:0; z-index: 0; background-color: #e8e8e8;">
                            <div class="cont-box">
                                <a href="" title="" target="_blank"><img src="${advtProxys.advUrl}" height="300" width="1920"></a>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
        <c:if test="${fn:length(advtVar) > 1}">
            <div class="slider" id="focus-slider" style="display: block;">
                <c:forEach items="${advtVar}" var="advtProxys" varStatus="s">
                    <a href="javascript:void(0);" class="<c:if test="${s.first}">cur</c:if>" title=""></a>
                </c:forEach>
            </div>
            <div class="slider-page" style="display: block;">
                <a href="javascript:;" class="lb-prev" id="focus-prev"></a>
                <a href="javascript:;" class="lb-next" id="focus-next"></a>
            </div>
        </c:if>
    </div>
</div>
<div class="main">
    <div class="mt">
        <div class="cont">
            <c:if test="${empty param.s || param.s<=6}">
            <ul id="all" style="height: 47px;"><!-- 点击 更多按钮，这里变成 height:auto; -->
                </c:if>
                <c:if test="${param.s>6}">
                <ul id="all" style="height: auto"><!-- 点击 更多按钮，这里变成 height:auto; -->
                    </c:if>
                    <c:if test="${categoryId eq 15}">
                        <li class="cur"><a href="${webRoot}/tuanlist.ac">全部药团购</a></li>
                    </c:if>
                    <c:if test="${categoryId ne 15}">
                        <li class=""><a href="${webRoot}/tuanlist.ac">全部药团购</a></li>
                    </c:if>
                    <c:forEach items="${category.children}" var="node" varStatus="s">
                        <c:if test="${node.categoryId eq categoryId}">
                            <li class="cur"><a href="${webRoot}/tuanlist.ac?type=${type}&categoryId=${node.categoryId}&s=${s.count}">${node.name}</a></li>
                        </c:if>
                        <c:if test="${node.categoryId ne categoryId}">
                            <li class=""><a href="${webRoot}/tuanlist.ac?type=${type}&categoryId=${node.categoryId}&s=${s.count}">${node.name}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
                <c:if test="${fn:length(category.children)>6}">
                <c:if test="${empty param.s || param.s<=6}">
                <a href="javascript:;" class="more up">更多</a>
                </c:if>
                <c:if test="${param.s>6}">
                <a href="javascript:;" class="more down">收起</a>
                </c:if>
                </c:if>
                <c:if test="${type eq 'groupBuyIN'}">
                <a href="${webRoot}/tuanlist.ac?type=previewGroupBuy&categoryId=${param.categoryId}&s=${param.s}" class="btn01">团购预告</a>
                </c:if>
                <c:if test="${type eq 'previewGroupBuy'}">
                <a href="${webRoot}/tuanlist.ac?type=groupBuyIN&categoryId=${param.categoryId}&s=${param.s}" class="btn02">正在进行</a>
                </c:if>
        </div>
    </div>

    <div class="mc">
        <ul class="item">
            <c:forEach items="${group.result}" var="groupProxy">
                <c:if test="${groupProxy.stockQuantity>0}">
                    <li class="li_${groupProxy.groupBuyId}"><a href="${webRoot}/tuan.ac?id=${groupProxy.groupBuyId}" title="${groupProxy.title}"> <!-- 卖完的li加 class:disabled; -->
                        <div class="pic"><img data-original="${groupProxy.pic[""]}" width="360" height="270" alt=""></div>
                        <div class="bot">
                            <div class="title elli"><span><fmt:formatNumber  value="${groupProxy.discount/10}" type="number"  pattern="#0.0#"/>折</span>${groupProxy.title}</div>
                           <%-- <div class="p-ad">${groupProxy.sellingPoint}</div>--%>
                            <div class="summary">
                                <div class="price">
                                  <%--  <c:if test="${empty loginUser}">
                                        <i style="font-size: 15px; padding-top: 2px">批发价采购商可见</i>
                                    </c:if>--%>
                                   <%-- <c:if test="${not empty loginUser}">--%>
                                        <i>¥</i><span><fmt:formatNumber  value="${groupProxy.price.unitPrice}" type="number"  pattern="#0.00#"/></span>
                                        <del><fmt:formatNumber  value="${groupProxy.orgPrice}" type="number"  pattern="#0.00#"/></del>
                                   <%-- </c:if>--%>
                                </div>
                                <div class="sell"><span>${groupProxy.soldQuantity}</span>人已购买</div>
                            </div>
                            <div class="end-t">
                                <c:if test="${type eq 'groupBuyIN'}">
                                    <label>距团购结束：</label>
                                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time"></div>
                                    <script type="text/javascript">
                                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','default',webPath.systemTime);
                                    </script>
                                </c:if>
                                <c:if test="${type eq 'previewGroupBuy'}">
                                    <label>距团购开始：</label>
                                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time" itemNm="li_${groupProxy.groupBuyId}"></div>
                                    <script type="text/javascript">
                                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','previewdefault',webPath.systemTime);
                                    </script>
                                </c:if>
                            </div>
                        </div>
                        <span class="sell-out"></span>
                    </a></li>
                </c:if>
                <c:if test="${groupProxy.stockQuantity<=0}">
                    <li class="disabled"><a href="javascript:void(0);" title="${groupProxy.title}"> <!-- 卖完的li加 class:disabled; -->
                        <div class="pic"><img data-original="${groupProxy.pic[""]}" alt=""></div>
                        <div class="bot">
                            <div class="title elli"><span><fmt:formatNumber  value="${groupProxy.discount/10}" type="number"  pattern="#0.0#"/>折</span>${groupProxy.title}</div>
                           <%-- <div class="p-ad">${groupProxy.sellingPoint}</div>--%>
                            <div class="summary">
                                <div class="price">
                                    <i>￥</i>
                                  <%--  <c:if test="${empty loginUser}">
                                        <i style="font-size: 15px; padding-top: 2px">批发价采购商可见</i>
                                    </c:if>--%>
                                 <%--   <c:if test="${not empty loginUser}">--%>
                                        <span><fmt:formatNumber  value="${groupProxy.price.unitPrice}" type="number"  pattern="#0.00#"/></span>
                                        <del><fmt:formatNumber  value="${groupProxy.orgPrice}" type="number"  pattern="#0.00#"/></del>
                                   <%-- </c:if>--%>
                                </div>
                                <div class="sell"><span>${groupProxy.soldQuantity}</span>人已购买</div>
                            </div>
                            <div class="end-t">
                                <c:if test="${type eq 'groupBuyIN'}">
                                    <label>距团购结束：</label>
                                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time"></div>
                                    <script type="text/javascript">
                                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','groupdefault',webPath.systemTime);
                                    </script>
                                </c:if>
                                <c:if test="${type eq 'previewGroupBuy'}">
                                    <label>距团购开始：</label>
                                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time" itemNm="li_${groupProxy.groupBuyId}"></div>
                                    <script type="text/javascript">
                                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','previewdefault',webPath.systemTime);
                                    </script>
                                </c:if>
                            </div>
                        </div>
                        <span class="sell-out"></span>
                    </a></li>
                </c:if>
            </c:forEach>
        </ul>
        <div class="pager">
            <div class="infoPage">
                <c:if test="${group.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${group.lastPageNumber}' currentPage='${page}'  totalRecords='${group.totalCount}' ajaxUrl='${webRoot}/tuanlist.ac' frontPath='${webRoot}' displayNum='6' />
                </c:if>
            </div>
        </div>
    </div>

</div>
<%--<f:FrameEditTag />   --%>  <%--页面装修专用标签--%>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
