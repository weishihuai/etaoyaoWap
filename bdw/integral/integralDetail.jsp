<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--根据积分商品Id取出积分商品--%>
<c:set value="${sdk:getIntegralProduct(param.integralProductId)}" var="integralProduct"/>

<%--根据积分商品分类Id 取出同类积分商品--%>
<c:set value="${sdk:findIntegralProductsByCategoryId(integralProduct.integralProductCategoryId,4)}" var="similarGoods"/>

<%--积分兑换 详细信息--%>
<c:set value="${sdk:getArticleById(60912)}" var="information"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-积分兑换详细</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/chuange.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/integral.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidatorRegex.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
</head>



<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=integral"/>
<%--页头结束--%>

<div id="position" class="m1-bg"><div class="m1"><a href="${webRoot}/index.html">首页</a> > <%--<a href="${webRoot}/integral/integralList.ac">--%><a href="${webRoot}/jfhg.ac">积分兑换</a></div></div>

<div id="chuange">
    <div class="lBox">
        <div class="detail">
            <div class="bigPic"><img src="${integralProduct.icon['320X320']}" width="320px" height="320px" /></div>
            <div class="r_Data">
                <h1>${integralProduct.integralProductNm}</h1>
                <%--<div class="p1">截止时间：2011/10/3</div>--%>
                <!--判断该商品的支付类型--->
                <c:choose>
                    <c:when test="${integralProduct.paymentConvertTypeCode eq '2'}">
                        <div class="p2">固定积分：<b><fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="######.##" />分</b></div>
                        <div class="p3" style="display: none">积分+金额：<b><fmt:formatNumber value="${integralProduct.exchangeIntegral}" type="number" pattern="######.##" /></b>
                        分+<b><fmt:formatNumber value="${integralProduct.exchangeAmount}" type="number" pattern="######.##" /></b>元
                        </div>
                    </c:when>
                    <c:when test="${integralProduct.paymentConvertTypeCode eq '0'}">
                        <div class="p2">固定积分：<b><fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="######.##" />分</b></div>
                    </c:when>
                    <c:when test="${integralProduct.paymentConvertTypeCode eq '1'}">
                        <div class="p3" style="display: block">积分+金额：<b><fmt:formatNumber value="${integralProduct.exchangeIntegral}" type="number" pattern="######.##" /></b>
                            分+<b><fmt:formatNumber value="${integralProduct.exchangeAmount}" type="number" pattern="######.##" /></b>元
                        </div>
                    </c:when>
                </c:choose>
                <div class="outBox">
                    <div class="fixBox">
                        <label>我要购买：</label>
                        <div class="inputArea">
                            <div class="btn-le"><a href="javascript:" class="prd_subNum"><img src="${webRoot}/template/bdw/statics/images/detail_toE.gif"></a></div>
                            <div class="put">
                                <input name="text" type="text" value="1" class="prd_num" />
                            </div>
                            <div class="btn-add"><a href="javascript:" class="prd_addNum"><img src="${webRoot}/template/bdw/statics/images/detail_toAdd.gif"></a></div>
                            <div class="clear"></div>
                        </div>
                        <div class="tip">可兑数量剩余<b>${integralProduct.num}</b>件！</div>
                        <div class="clear"></div>
                    </div>
                    <div class="fixBox">
                        <!--判断该商品的支付类型--->
                        <c:choose>
                            <c:when test="${integralProduct.paymentConvertTypeCode eq '2'}">
                               <div class="choose-pro">
                                   <label>兑换方式：</label>
                                   <span class="label"></span>
                                   <ul class="cho-cont">
                                       <li class="cur integralModeBtn" integralExchangeType="0"><a href="javascript:void(0);" style="text-underline: none;">固定积分</a><i></i></li><!--这里可以加cur-->
                                       <li class="integralCashModeBtn" integralExchangeType="1"><a href="javascript:void(0);" style="">积分+现金</a><i></i></li>
                                   </ul>
                               </div>
                            </c:when>
                            <c:when test="${integralProduct.paymentConvertTypeCode eq '0'}">
                                <div class="choose-pro">
                                    <label>兑换方式：</label>
                                    <span class="label"></span>
                                    <ul class="cho-cont">
                                        <li class="cur integralModeBtn" integralExchangeType="0"><a href="javascript:void(0);" style="">固定积分</a><i></i></li><!--这里可以加cur-->
                                    </ul>
                                </div>
                            </c:when>
                            <c:when test="${integralProduct.paymentConvertTypeCode eq '1'}">
                                <div class="choose-pro">
                                    <label>兑换方式：</label>
                                    <span class="label"></span>
                                    <ul class="cho-cont ">
                                        <li class="integralCashModeBtn cur" integralExchangeType="1"><a href="javascript:void(0);" style="">积分+现金</a><i></i></li>
                                    </ul>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>

                    <div class="fixBox">
                        <div class="getiT">
                            <c:choose>
                                <c:when test="${empty integralProduct || integralProduct.isDelete eq 'Y'}">
                                    <span>对不起，该商品已经失效！</span>
                                </c:when>
                                <c:otherwise>
                                    <a num="${integralProduct.num}" integralProductNum="${integralProduct.num}" objectid="${integralProduct.integralProductId}" class="addcart" productInventory="${integralProduct.num}" userIntegral="${loginUser.integral}" carttype="integral" isLogin="${empty loginUser ? true :false}" price="${integralProduct.integral}" exchangeIntegral="${integralProduct.exchangeIntegral}"  handler="integral" href="javascript:" type="${integralProduct.type}"><img src="${webRoot}/template/bdw/statics/images/chuange_btn04.gif" /></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
        </div>

        <%--积分兑换 详细信息 开始--%>
        <div class="detail_Tex">
            <h2>
                <div class="tit"><b>详细信息</b></div>
                <div class="clear"></div>
            </h2>
            <div class="box">
                        ${integralProduct.desc}

            </div>
        </div>
        <%--积分兑换 详细信息 结束--%>

        <%--同类积分商品 开始--%>
        <div class="m2">
            <h2>
                <div class="tit"><b>同类礼品</b></div>
                <div class="clear"></div>
            </h2>
            <div class="box">
                <ul>
                    <c:forEach items="${similarGoods.result}" var="goods">
                        <c:if test="${goods.integralProductId != param.integralProductId}">
                            <li>
                                <div class="pic">
                                    <c:choose>
                                        <c:when test="${goods.type eq 0}">
                                            <a href="${webRoot}/integral/integralDetail.ac?integralProductId=${goods.integralProductId}" title="${goods.integralProductNm}">
                                                <img src="${goods.icon['160X160']}" width="160px" height="160px" />
                                            </a>
                                        </c:when>
                                        <c:otherwise> <img src="${goods.icon['']}" width="160px" height="160px" /></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="title"><a <c:if test="${goods.type eq 0}">href="${webRoot}/integral/integralDetail.ac?integralProductId=${goods.integralProductId}"</c:if>>${goods.integralProductNm}</a></div>
                                <c:choose>
                                    <c:when test="${goods.paymentConvertTypeCode eq '2'}">
                                        <p>固定积分：<b><fmt:formatNumber value="${goods.integral}" type="number" /></b></p>
                                        <p>积分+金额：<b><fmt:formatNumber value="${goods.exchangeIntegral}" type="number" />分+<fmt:formatNumber value="${goods.exchangeAmount}" type="number" />元</b></p>
                                    </c:when>
                                    <c:when test="${goods.paymentConvertTypeCode eq '1'}">
                                        <p>积分+金额：<b style="width:500px;"><fmt:formatNumber value="${goods.exchangeIntegral}" type="number" />分+<fmt:formatNumber value="${goods.exchangeAmount}" type="number" />元</b></p>
                                        <p></p>
                                    </c:when>
                                    <c:when test="${goods.paymentConvertTypeCode eq '0'}">
                                        <p>固定积分：<b><fmt:formatNumber value="${goods.integral}" type="number" /></b></p>
                                        <p></p>
                                    </c:when>
                                </c:choose>

                                <%--<p>所需积分： <b>${goods.integral}</b> 积分</p>--%>

                                <div class="btn"><a num="1" objectid="${goods.integralProductId}" class="addcart" userIntegral="${loginUser.integral}" carttype="integral" isLogin="${empty loginUser ? true : false}" price="${goods.integral}" exchangeIntegral="${goods.exchangeIntegral}"  handler="integral" href="javascript:" type="${goods.type}"></a></div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <%--同类积分商品 结束--%>

    </div>

    <%--积分兑换右边栏目 开始--%>
    <c:import url="/template/bdw/integral/rightMenu.jsp" />
    <%--积分兑换右边栏目 结束---%>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

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
                    <li><a>邮政编码：</a><input type="text" class="put" id="receiverZipcode" name="receiverZipcode" maxlength="6" onblur="removeTheSign(this,'receiverZipcodeTip')"><div id="receiverZipcodeTip" style="float: left"></div></li>
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
                    <li><a>电话：</a><input type="text" class="code" id="receiverTel" name="receiverTel" onblur="removeTheSign(this,'receiverTelTip')"><div id="receiverTelTip" style="float: left"></div></li>
                    <div class="btn1"><a href="javascript:" id="saveAddress">提 交</a></div>
                    <div class="btn2 closeMyAddress"><a href="javascript:">取 消</a></div>
                </ol>
            </div>
        </div>
        <input id="oid" type="hidden" value="" name="integralProductId">
        <input id="onum" type="hidden" value="" name="num">
    </form>
</div>

</body>
</html>
