<%@ page import="com.iloosen.imall.sdk.user.proxy.UserProxy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>

<%-- 如果地址只有一个的情况下，设置这个地址为默认默认地址 --%>
<c:if test="${fn:length(loginUser.receiverAddress) == 1}">
    <%
        UserProxy loginUser = (UserProxy) pageContext.getAttribute("loginUser");
        ServiceManager.receiverAddrService.updateReceiverAddrDefaultId(Integer.parseInt(loginUser.getReceiverAddress().get(0).getReceiveAddrId()));
    %>
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-地址管理-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript">

        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        var citylocation,map,marker = null;
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" language="javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/jquery.ld.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myAddressBook.js"></script>
</head>
<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html"  title="首页">首页</a> > <a href="${webRoot}/module/member/index.ac"  title="会员中心">会员中心</a> > 收货地址</div></div>
<%--面包屑导航 end--%>

<%--收货地址维护 start--%>
<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <h2 class="rightbox_h2_border">收货地址维护</h2>
        <div class="adress right_box_border">
            <%--地址信息输入 start--%>
            <div class="t1" style="position: relative;">
                <h4><b>新增收货地址</b></h4>
                <input id="receiveAddrId" name="receiveAddrId" type="hidden"/>
                <div class="newAddress">
                    <div class="fixBox">
                        <label><span>*</span>收货人姓名：</label>
                        <div class="put"><input id="name" class="w1" type="text"/><span id="alert" style="padding-left:5px;"></span></div>
                    </div>
                    <div class="fixBox">
                        <label><span></span>邮政编码：</label>
                        <div class="put"><input id="zipcode" name="zipcode" type="text" maxlength="6"/>
                            <span id="alert1" style="padding-left:5px;"></span>
                        </div>
                    </div>
                    <div class="fixBox">
                        <label><span>*</span>省　　份：</label>
                        <input type="hidden" id="zoneId" name="zoneId"/>
                        <div class="put selT">
                            <select class="addressSelect" id="province" name="" onchange="proviceSelected(this);">
                                <option>请选择</option>
                            </select>
                            <select class="addressSelect" id="city" name="" onchange="citySelected(this);">
                                <option>请选择</option>
                            </select>
                            <select class="addressSelect" id="country" name="" onchange="areaSelected(this);">
                                <option>请选择</option>
                            </select>
                            <select class="addressSelect" id="zone" name="" onchange="areaSelected(this);">
                                <option>请选择</option>
                            </select>
                            <span id="alert2" style="padding-left:5px;"></span>
                        </div>
                    </div>
                    <div class="fixBox">
                        <label><span>*</span>地　　址：</label>
                        <div class="put"><input id="addr" name="addr" class="w2" type="text" maxlength="255" onblur="locatedAddr();"/> <span id="alert3" style="padding-left:5px;"></span> </div>
                    </div>
                    <%--<div class="fixBox">
                        <label><span>*</span>纬度：</label>
                        <div class="put"><input id="addrLat" name="addrLat" readonly="readonly" type="text" maxlength="20"/><span id= style="padding-left:5px;"></span></div>
                    </div>
                    <div class="fixBox">
                        <label><span>*</span>经度：</label>
                        <div class="put"><input id="addrLng" name="addrLng" readonly="readonly" type="text" maxlength="20"/><span  style="padding-left:5px;"></span></div>
                    </div>
                    <div  class="btn" style="padding-bottom: 0px;"><a id="location" href="javascript:" title="定位" style="width: 60px;height: 30px;line-height: 27px;">定位</a></div>--%>
                    <div class="fixBox">
                        <label><span>*</span>手机号码：</label>
                        <div class="put"><input id="mobile" name="mobile" type="text" maxlength="11"/><span id="alert4" style="padding-left:5px;"></span></div>
                    </div>
                    <%--<div class="fixBox">--%>
                        <%--<label><span>*</span>固定电话：</label>--%>
                        <%--<div class="put"><input id="tel" name="tel" type="text" maxlength="20"/><span id="alert5" style="padding-left:5px;"></span>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <div class="btn"><a id="btnAdd" href="javascript:" title="保存收货人信息">保存收货人信息</a></div>
                </div>

                <div style="width: 417px;height: 360px; position: absolute; left: 515px; top:0;" id="memberMap">
                </div>
            </div>
            <%--地址信息输入 end--%>

            <%--地址列表 start--%>
            <div class="t2">
                <h3>已保存的有效地址</h3>
                <table width="100%" border="0" cellspacing="0">
                    <tr class="tr1">
                        <td class="td1">收货人</td>
                        <td class="td2">所在地区</td>
                        <td class="td3">街道地址</td>
                        <td class="td4">邮编</td>
                        <td class="td5">手机</td>
                        <td class="td7">操作</td>
                    </tr>
                    <c:forEach end="10" items="${loginUser.receiverAddress}" var="addrValue">
                        <c:set value="${fn:length(addrValue.addressPath)}" var="addrPathLength"/>
                        <tr>
                            <td class="td1">${addrValue.name}</td>
                            <td class="td2">${fn:substring(addrValue.addressPath, 1,addrPathLength)}</td>
                            <td class="td3">${addrValue.addr}</td>
                            <td class="td4">${addrValue.zipcode}</td>
                            <td class="td5">${addrValue.mobile}</td>
                            <td class="td7"><a class="btnAlt" name="btnAlt" href="javascript:" onclick="btnAlt('${addrValue.receiveAddrId}')" title="修改">修改</a> | <a href="javascript:" onclick="btnDel(${addrValue.receiveAddrId})" title="删除">删除</a>
                                <c:if test="${addrValue.isDefault == 'N'}"> | <a href="javascript:" onclick="btnDefault(${addrValue.receiveAddrId})" title="设为默认">设置默认</a></c:if>
                                <c:if test="${addrValue.isDefault == 'Y'}"> | <span style="color: red">默认地址</span></c:if></td>
                        </tr>
                    </c:forEach>
                </table>
                <p>* 最多保存10个有效地址。</p>
            </div>
            <%--地址列表 end--%>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--收货地址维护 end--%>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
