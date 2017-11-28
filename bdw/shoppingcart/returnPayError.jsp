<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-11-24
  Time: 下午8:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>支付失败-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart.js"></script>
    <script>
        window.onload=function()
        {
            setInterval("redirect();",5000);
        };
        function redirect()
        {
            var type = "${param.type}";
            if(type == "propertyFee"){
                window.location.href="${webRoot}/iMall/admin/sadmin/module/shopLeaseInfo/shopLeaseInfoList.jsp";
            }else if(type == "shopIntegralChage"){
                window.location.href="${webRoot}/iMall/admin/sadmin/module/yzShopIntegralChange/yzShopIntegralChangeCashier.jsp";
            }else{
                window.location.href="${webRoot}/module/member/orderList.ac";
            }

        }
    </script>
</head>

<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">

<c:if test="${param.type == 'otooOrder' || param.type == 'integralOrder' || param.type == 'order'}">
    <%--页头开始--%>
    <c:import url="/template/bdw/shoppingcart/carttop.jsp"/>
    <%--页头结束--%>
</c:if>

<c:choose>
    <c:when test="${param.type == 'otooOrder' || param.type == 'integralOrder' || param.type == 'order'}">
        <div id="orderSuccess">
            <ul class="nav" style="width:984px;">
                <li class="n-item1"><span>1.查看购物车</span></li>
                <li class="n-item2"><span>2.填写订单信息</span></li>
                <li class="n-item3"><span>3.付款到收银台</span></li>
                <li class="n-item4"><span>4.收货评价</span></li>
            </ul><div class="clear"></div>
            <div class="box paySuccessBox">
                <ul>
                    <h2><a href="#"><img src="${webRoot}/template/bdw/statics/images/buyCar_erroIco.gif" /></a></h2>
                    <li>
                        <p>您的订单失败！${errorMsg}</p>
                        <div class="return">
                            <h4>您现在还可以：<a href="${webRoot}/index.html">返回首页</a> 5秒后将自动跳转至<a href="${webRoot}/module/member/orderList.ac">订单中心</a>页</h4>

                        </div>
                    </li><div class="clear"></div>
                </ul>

            </div>
        </div>
     </c:when>
    <c:otherwise>
        <div id="orderSuccess">
            <div class="clear"></div>
            <div class="box paySuccessBox">
                <ul>
                    <h2><a href="#"><img src="${webRoot}/template/bdw/statics/images/buyCar_erroIco.gif" /></a></h2>
                    <li>
                        <p>支付失败！${errorMsg}</p>
                        <div class="return">
                            <h4>5秒后将后退至提交页</h4>
                        </div>
                    </li><div class="clear"></div>
                </ul>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<c:if test="${param.type == 'otooOrder' || param.type == 'integralOrder' || param.type == 'order'}">
    <%--页头开始--%>
    <c:import url="/template/bdw/module/common/bottom.jsp"/>
    <%--页头结束--%>
</c:if>
</body>
</html>
