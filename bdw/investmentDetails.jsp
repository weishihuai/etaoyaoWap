<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="investment" value="${bdw:getSymerchantsInfProxy(param.merchantsInfId)}"/>

<c:if test="${empty investment}">
    <c:redirect url="${webRoot}/attractAgentList.ac"></c:redirect>
</c:if>

<c:set var="news" value="${bdw:getSyMerchantsInfLatestNewsList(10)}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <title>招商详情</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/zs-detail.css">

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/investmentDetails.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.vticker.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",merchantsInfId:"${param.merchantsInfId}"}
    </script>

</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=agent"/>
<!--页头结束-->

<!--主体-->
<div class="main-bg">
    <div class="past">
        <div class="cont">
            <a href="${webRoot}/index.ac">易淘药商城首页 ></a>
            <%--<i></i>--%>
            <a href="${webRoot}/attractAgentList.ac">招标列表 ></a>
            <%--<i></i>--%>
            <span>招商详情</span>
        </div>
    </div>
    <div class="main-top">
        <div class="top-lt"><img src="${investment.productPicUrl}" alt=""></div>
        <div class="top-mt">
            <div class="title">&nbsp&nbsp${investment.merchantsProductName}</div>
            <div class="info">
                <div class="item1">
                    <span>通用名称：</span>
                    <em>${investment.commonName}</em>
                </div>
                <div class="item2">
                    <span>有  效 期：</span>
                    <em><fmt:formatDate value="${investment.infExpireDate}" pattern="yyyy-MM-dd"/></em>
                </div>
                <div class="item1">
                    <span>药品类型：</span>
                    <em>${investment.isRx}</em>
                </div>
                <div class="item2">
                    <span>产品品牌：</span>
                    <em>${investment.brandTagName}</em>
                </div>
                <div class="item1">
                    <span>产品规格：</span>
                    <em>${investment.prdSpec}</em>
                </div>
                <div class="item2">
                    <span>招商类型：</span>
                    <em>${investment.merchantsType}</em>
                </div>
                <div class="item1">
                    <span>批准文号：</span>
                    <em>${investment.approvalNumber}</em>
                </div>
                <div class="item2">
                    <span>招商区域：</span>
                    <em>${investment.merchantsZone}</em>
                </div>
                <div class="item1">
                    <span>生产厂家：</span>
                    <em>${investment.productionManufacturer}</em>
                </div>
            </div>
        </div>
        <div class="top-rt"><a href="##" id="toInv">我要代理</a></div>
    </div>
    <div class="main clearfix">
        <div class="mlt">

            <div class="mlt-bot">
                <div class="bot-dt">招商详情</div>
                <div class="bot-info">
                    <div class="cont">
                        <div class="cont-top">
                            <div class="item1">
                                <span>通用名称：</span>
                                <em>${investment.commonName}</em>
                            </div>
                            <div class="item2">
                                <span>有 效 期：</span>
                                <em><fmt:formatDate value="${investment.infExpireDate}" pattern="yyyy-MM-dd"/></em>
                            </div>
                            <div class="item1">
                                <span>药品类型：</span>
                                <em>${investment.isRx}</em>
                            </div>
                            <div class="item2">
                                <span>产品品牌：</span>
                                <em>${investment.brandTagName}</em>
                            </div>
                            <div class="item1">
                                <span>产品规格：</span>
                                <em>${investment.prdSpec}</em>
                            </div>
                            <div class="item2">
                                <span>招商类型：</span>
                                <em>${investment.merchantsType}</em>
                            </div>
                            <div class="item1">
                                <span>批准文号：</span>
                                <em>${investment.approvalNumber}</em>
                            </div>
                            <div class="item2">
                                <span>招商区域：</span>
                                <em>${investment.merchantsZone}</em>
                            </div>
                            <div class="item1">
                                <span>生产厂家：</span>
                                <em>${investment.productionManufacturer}</em>
                            </div>
                        </div>
                        <div class="cont-top">
                            <div class="item1">
                                <span>联系人：</span>
                                <em>${investment.contactMan}</em>
                            </div>
                            <div class="item2">
                                <span>联系电话：</span>
                                <em>${investment.contactTel}</em>
                            </div>
                        </div>
                        <div class="cont-bot">
                            <div class="item1">
                                <span>产品优势：</span>
                                <em>${investment.prdIngredient}</em>
                            </div>
                            <div class="item1">
                                <span>招商情况：</span>
                                <em>${investment.merchantsSituation}</em>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bot-dd">
                    <img src="${investment.productPicUrl}" alt="">
                    <h4 style="font-size: 24px;"><span style="color: #f25f55;">${investment.agentDescrStr}</span></h4>
                </div>
            </div>
        </div>
        <div class="mrt">
            <h5>最新招商信息</h5>
            <dl class="new">
                <dt>
                    <span>产品名称</span>
                    <span style="margin-left: 210px;">时间</span>
                </dt>
                <dd>
                    <div class="dowebok">
                        <ul>
                            <c:if test="${not empty news}">
                                <c:forEach items="${news}"  var="latestNews" varStatus="s">
                                    <li>
                                        <a href="${webRoot}/investmentDetails.ac?merchantsInfId=${latestNews.merchantsInfId}">
                                            <span class="m1 elli">${latestNews.merchantsProductName}</span>
                                            <span class="m2 elli"><fmt:formatDate value="${latestNews.releaseTime}" pattern="yyyy-MM-dd"/></span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </dd>
            </dl>
        </div>
    </div>
</div>
<div class="overlay" id="investment">
    <div class="info-box">
        <div class="mt">
            <span>代理信息填写</span>
            <a href="##" class="close" id="toClose">&times;</a>
        </div>
        <div class="mc">
            <input type="hidden" name="merchantsInfId" value="${param.merchantsInfId}" id="merchantsInfId">
            <div class="mc-top">
                <div class="item">
                    <span><em>* </em>代理区域</span>
                    <input type="text" placeholder="请告知您的销售区域" id="zone" autocomplete="off">
                    <input type="text"  style="display:none;" id="merZone" value="${investment.merchantsZone}"/>
                </div>
                <div class="item">
                    <span>代 理 商</span>
                    <input type="text" id="merchant" name="unitNm">
                </div>
                <div class="item m2">
                    <span><em>* </em>代理类型</span>
                    <div class="m2-cont" id="agentType">
                        <ul>
                            <c:forEach items="${bdw:getSysCustomerTypeList(param.merchantsInfId)}"  var="customerTypes" varStatus="s">
                                <li class="type${s.count}"><a href="javascript:void(0);" class="zctype${s.count}"  agentType="${customerTypes.customerTypeId}"  onclick="selectZsType('${s.count}')">${customerTypes.customerTypeName}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="item">
                    <span><em>* </em>联  系 人</span>
                    <input type="text" placeholder="" id="contactMan">
                </div>
                <div class="item">
                    <span><em>* </em>联系电话</span>
                    <input type="text" placeholder="" id="contactTel">
                </div>
                <div class="item">
                    <span><em>* </em>代理简述</span>
                    <textarea id="message"></textarea>
                </div>
            </div>
            <div class="mc-bot">
                <a href="javascript:void(0);" class="btn01" id="submitInfo">确认</a>
                <a href="javascript:void(0);" class="btn02" id="resetForm">重置</a>
            </div>
        </div>
    </div>
</div>

<!--页脚-->
<c:import url="/template/bdw/module/common/bottom.jsp?p=agent"/>

</body>
</html>
