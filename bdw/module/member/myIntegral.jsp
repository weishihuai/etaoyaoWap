<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %><%--分页引用--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="${sdk:getIntegralTransactionLogs(10)}" var="integralTransactionLogs"/><%--当前用户积分记录列表--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-我的积分 - ${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

     <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidatorRegex.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myIntegral.js"></script><%--积分可换购商品轮换效果--%>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/integral.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        <%--初始化参数，myIntegral.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        var webPath = {webRoot:"${webRoot}"};
        <%--初始化参数，myIntegral.js调用 end--%>
    </script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 我的积分</div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <div class="myIntegral">
            <h2 class="rightbox_h2_border">我的积分</h2>
            <h6 class="rightbox_h2_border">
                <div class="l">我的积分：<b><fmt:formatNumber value="${loginUser.integral}" type="number" pattern="##" /></b></div>
                <div class="r"><a href="${webRoot}/module/member/myInvite.ac">邀请好友获得更多积分</a></div>
                <div class="clear"></div>
            </h6>
            <div class="box right_box_border">
                <%--根据积分可换购商品 start--%>
                <div class="m1">
                    <c:if test="${not empty loginUser.integralProducts}">
                    <h3>
                        <div class="f">根据您您的积分可以换购以下商品</div>
                        <%--<div class="more"><a href="${webRoot}/integral/integralList.ac">更多积分商品>></a></div>--%>
                        <div class="more"><a href="${webRoot}/jfhg.ac">更多积分商品>></a></div>
                        <div class="clear"></div>
                    </h3>
                    <div class="area">
                        <div class="l_Btn"><a href="javascript:"  id="mycarousel-prev"><img src="${webRoot}/template/bdw/module/member/statics/images/member_turnL_btn_Empty.gif" /></a></div>
                        <div class="srcoll">
                            <div id="mycarousel-integral" class="jcarousel-skin-tango">
                            <ul style="width:2000px;">
                                <c:forEach items="${loginUser.integralProducts}" var="integralProduct">
                                <li>
                                    <div class="pic"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${integralProduct.integralProductId}" title="${integralProduct.integralProductNm}"><img src="${integralProduct.icon[""]}" alt="${integralProduct.integralProductNm}" style="width: 118px;height:118px;"/></a></div>
                                    <div class="title"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${integralProduct.integralProductId}" title="${integralProduct.integralProductNm}">${integralProduct.integralProductNm}</a></div>
                                    <div class="number"><%--兑换积分：<b>${integralProduct.integral}</b>--%>


                                        <c:choose>
                                            <c:when test="${integralProduct.paymentConvertTypeCode eq '2'}">

                                                <p>固&nbsp;定&nbsp;积&nbsp;分：<b><fmt:formatNumber value="${integralProduct.integral}" type="number"
                                                                             pattern="######.##"/></b></p>
                                                <p style="margin-top:5px;"> 积分+金额：<b style="width:170px;"><fmt:formatNumber
                                                        value="${integralProduct.exchangeIntegral}" type="number"
                                                        pattern="######.##"/>分+<fmt:formatNumber
                                                        value="${integralProduct.exchangeAmount}" type="number"
                                                        pattern="######.##"/>元</b></p>
                                            </c:when>
                                            <c:when test="${integralProduct.paymentConvertTypeCode eq '1'}">
                                                <p>积分+金额：<b style="width:170px;"><fmt:formatNumber
                                                        value="${integralProduct.exchangeIntegral}" type="number"
                                                        pattern="######.##"/>分+<fmt:formatNumber
                                                        value="${integralProduct.exchangeAmount}" type="number"
                                                        pattern="######.##"/>元</b></p>
                                            </c:when>
                                            <c:when test="${integralProduct.paymentConvertTypeCode eq '0'}">
                                                <p>固定积分：<b><fmt:formatNumber value="${integralProduct.integral}" type="number"/></b>
                                                </p>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="btn"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${integralProduct.integralProductId}" <%-- num="1" objectid="${integralProduct.integralProductId}" &lt;%&ndash;class="addcart"&ndash;%&gt; productInventory="${integralProduct.num}" userIntegral="${loginUser.integral}" carttype="integral" isLogin="${empty loginUser ? true :false}" price="${integralProduct.integral}"  handler="integral" href="javascript:" type="${integralProduct.type}"--%>>使用积分兑换</a></div>
                                </li>
                                </c:forEach>
                            </ul>
                            </div>
                        </div>
                        <div class="r_Btn"><a href="javascript:"  id="mycarousel-next"><img src="${webRoot}/template/bdw/module/member/statics/images/member_turnR_btn_Empty.gif" /></a></div>
                        <div class="clear"></div>
                    </div>
                    </c:if>
                </div>
                <%--根据积分可换购商品 end--%>

                <%--积分记录列表 start--%>
                <div class="m2">
                    <div class="t_Menu">
                        <ul>
                            <li><a class="cur" href="javascript:void(0);">积分易记录</a></li>
                        </ul>
                    </div>
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td1">交易积分</td>
                            <td class="td2">交易后积分</td>
                            <td class="td3">时间</td>
                            <td class="td4">原因</td>
                        </tr>
                        <c:forEach items="${integralTransactionLogs.result}" var="transactionLog">
                            <tr>
                                <td class="td1"><fmt:formatNumber value="${transactionLog.transactionAmount}" type="number" pattern="##" /></td>
                                <td class="td2"><fmt:formatNumber value="${transactionLog.endAmount}" type="number" pattern="##" /></td>
                                <td class="td3">${transactionLog.transactionTime}</td>
                                <td class="td4">${transactionLog.reason}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty integralTransactionLogs.result}">
                        <tr>
                            <td colspan="4" class="lest">没有消费记录</td>
                        </tr>
                        </c:if>
                    </table>
                </div>
                <%--积分记录列表分页 start--%>
                <div class="page">
                    <div style="float:right">
                        <c:if test="${integralTransactionLogs.lastPageNumber > 1}">
                        <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/myIntegral.ac"   totalPages='${integralTransactionLogs.lastPageNumber}' currentPage='${integralTransactionLogs.thisPageNumber}' totalRecords='${integralTransactionLogs.totalCount}' frontPath='${webRoot}'  displayNum='6'/>
                        </c:if>
                    </div>
                </div>
                <%--积分记录列表分页 end--%>
                <%--积分记录列表 end--%>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div id="myAddress">
    <form id="userAddrForm" method="get">
        <div class="box">
            <div class="new-ad">
                <h2><a href="javascript:" class="closeMyAddress"><img src="${webRoot}/template/bdw/statics/images/btn_box_close.JPG"></a></h2>
                <p>填写配送地址，提交订单</p>
                <ul class="province selT">
                    <li><span>*</span><em>所有省份：</em>
                        <select class="addressSelect" id="province" name="">
                            <option>请选择</option>
                        </select>
                    </li>
                    <li>市：
                        <select class="addressSelect" id="city" name="">
                            <option>请选择</option>
                        </select>
                    </li>
                    <li>区：
                        <select class="addressSelect" id="zone" name="receiverZoneId">
                            <option>请选择</option>
                        </select>
                    </li>
                    <div id="zoneTip" style="float: left"></div>
                </ul>
                <ol class="zip">
                    <li><a>邮政编码：</a><input type="text" class="put" id="receiverZipcode" name="receiverZipcode" maxlength="6"><div id="receiverZipcodeTip" style="float: left"></div></li>
                </ol>
                <div class="clear"></div>
                <div class="address">
                    <div style="float: left;">
                        <span>*</span>街道地址：<input type="text" id="receiverAddr" name="receiverAddr" maxlength="255">
                    </div>
                    <div id="receiverAddrTip" style="float: left"></div>
                </div>
                <ol class="info">
                    <li><a><span>*</span>收货人姓名：</a><input type="text" id="receiverName" name="receiverName"><div id="receiverNameTip" style="float: left"></div></li>
                    <li><a><span>*</span>手机：</a><input type="text" id="receiverMobile" name="receiverMobile"><div id="receiverMobileTip" style="float: left"></div></li>
                    <li><a>电话：</a><input type="text" class="code" id="receiverTel" name="receiverTel"><div id="receiverTelTip" style="float: left"></div></li>
                    <div class="btn1"><a href="javascript:" id="saveAddress">提 交</a></div>
                    <div class="btn2 closeMyAddress"><a href="javascript:">取 消</a></div>
                </ol>
            </div>
        </div>
        <input id="oid" type="hidden" value="" name="integralProductId">
        <input id="onum" type="hidden" value="" name="num">
    </form>
</div>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>

</body>
</html>
