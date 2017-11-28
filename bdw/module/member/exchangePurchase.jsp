<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page ? 1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-申请退换货-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
        $(function(){
            $('.rebateLog').addClass('cur');
            $('.returnLog').removeClass('cur');
            $("#isReturn").attr("value","N");
            $(".returnLog").click(function(){
                location.href = "${webRoot}/module/member/returnedPurchase.ac?pitchOnRow=13";

            });
        });

        var showLogistics = function(id){
            $("#logistics").val("");
            $("#tipAddr").dialog({
                buttons:{'确定':function(){
                    var logistics = jQuery.trim($("#logistics").val());
                    if(logistics == null || logistics == ''){
                        showDialog("请填写物流单号");
                        return;
                    }else if(!/^[0-9a-zA-Z]*$/.test(logistics)){
                        showDialog("物流单号只能输入数字,字母");
                        return;
                    }
                    var companyNm = jQuery.trim($("#companyNm").val());
                    if(companyNm == null || companyNm == ''){
                        showDialog("填写物流公司名称");
                        return;
                    } else if (!/^[0-9a-zA-Z\u4e00-\u9fa5]*$/.test(companyNm)) {
                        showDialog("物流公司只能输入数字,字母，中文");
                        return;
                    }
                    addLogistics(id,logistics,companyNm);
                }
                }});
        };

        //改变换货订单状态
        var updateExchangeOrderStatus = function(id){
            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
            $.post(webPath.webRoot+"/afterSale/exchangeOrder/finish.json",{exchangeOrderId:id},function(){
                setTimeout(function(){window.location.reload()},1);
            })
        };

        var seeReturnAdd = function(id){
            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
            $.get(webPath.webRoot+"/module/member/getReturnedAddr.ac?returnId="+id,function(data){
                showDialog("订单号:"+id+"</br>退货地址:"+data);
            })
        };
        var addLogistics = function(id,logistics,companyNm){
            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
            $.post(webPath.webRoot+"/afterSale/exchangeOrder/updateLogistics.json",{exchangeOrderId:id,logisticsOrderCode:logistics,logisticsCompany:companyNm},function(){
                $("#tipAddr").dialog("close");
                setTimeout(function(){window.location.reload()},1)
            })
        };
        //显示层 start
        var showDialog = function(text){
            $("#tiptext").html(text);
            $("#tip").dialog({
                buttons:{
                    '确定':function(){
                        $("#tip").dialog("close")
                    }
                }
            });
        }
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html"  title="首页">首页</a> > <a href="${webRoot}/module/member/index.ac"  title="会员中心">会员中心</a> > 申请退换货</div></div>
<%--面包屑导航 end--%>


<%--申请退换货 start--%>
<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <h2 class="rightbox_h2_border">退换货</h2>
        <div class="adress return right_box_border">
            <div class="t2" style="margin-top: 20px;">
                <%--
                2015-04-21,zch,宝得网不要这个按钮
                <div class="con">
                    <div class="conDiv">
                        <c:set value="${sdk:getSysParamValue('returned_date')}" var="returned_date" />
                        <c:set value="${sdk:getSysParamValue('exchange_date')}" var="exchange_date" />
                        <span>你在${returned_date}天内购买的商品享受退货服务，你在${exchange_date}天内购买的商品享受换货服务</span>
                    </div>
                    <div class="conBtn"><a href="${webRoot}/module/member/selectPurchase.ac" class="returnedPurchase_btn rb2">申请退货</a></div>
                    <div class="conBtn"><a href="${webRoot}/module/member/selectExchange.ac" class="returnedPurchase_btn">申请换货</a></div>
                    <div class="clear"></div>
                </div>
                --%>
                <input type="hidden" id="isReturn" value="N"/>
                <div class="t_Menu">
                    <ul>
                        <li><a href="javascript:void(0);" class="returnLog cur">退货记录</a></li>
                        <li><a href="javascript:void(0);" class="rebateLog">换货记录</a></li>
                    </ul>
                </div>

                <div id="rebate_div">
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td1" style="width:75px">换货号</td>
                            <td class="td2" style="width:102px">订单号</td>
                            <td class="td2" style="width:115px">图片文件</td>
                            <td class="td3" style="width:175px">入库物流信息</td>
                            <td class="td3" style="width:175px">出库物流信息</td>
                            <td class="td4" style="width:155px">换货地址</td>
                            <td class="td4" style="width:70px">处理时间</td>
                            <td class="td8" style="width:113px">处理状态</td>
                        </tr>

                        <%--修改成一页8条记录--%>
                        <c:set value="${sdk:getExchangedPurchaseOrderPage(pageNum,8)}" var="exchangeOrderPage"/> <%--获取当前用户普通订单--%>
                        <c:forEach items="${exchangeOrderPage.result}" var="exchangeOrder">
                        <%--<c:forEach items="${loginUser.exchangeOrder}" var="exchangeOrder">--%>
                            <tr>
                                <td class="td1" style="width:75px">${exchangeOrder.exchangeOrderId}</td>
                                <td class="td2" style="width: 102px"><a href="${webRoot}/module/member/orderDetail.ac?id=${exchangeOrder.orderId}">${exchangeOrder.orderNum}</a></td>
                                <td class="td2" style="width: 115px"><img src="${exchangeOrder.imageUrl}" onerror="this.src='${webRoot}/template/bdw/statics/images/noPic_100X100.jpg'" alt="" style="width:100px;height:100px;"></td>
                                <td class="td3" style="width: 175px;padding: 12px">
                                    <c:choose>
                                        <c:when test="${empty exchangeOrder.logisticsOrderCode}">
                                            ${exchangeOrder.logisticsCompany}<span style="color: #666666">(空)</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${exchangeOrder.logisticsCompany}(${exchangeOrder.logisticsOrderCode})
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="td3" style="width: 175px;padding: 12px">
                                    <c:choose>
                                        <c:when test="${empty exchangeOrder.newLogisticsOrderCode}">
                                            ${exchangeOrder.newLogisticsCompany}<span style="color: #666666">(空)</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${exchangeOrder.newLogisticsCompany}(${exchangeOrder.newLogisticsOrderCode})
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="td4"  style="width: 100px">
                                    ${exchangeOrder.receiverAddr}
                                </td>
                                <td class="td4"  style="width: 150px">
                                    <c:choose>
                                        <c:when test="${empty exchangeOrder.lastModTimeString}">
                                            <span style="color: #666666">(空)</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${exchangeOrder.lastModTimeString}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="td8" style="width: 113px">
                                    <span style="color: #CC0000">${exchangeOrder.stat}</span><br/>
                                    <c:if test="${exchangeOrder.stat == '同意换货'&& (empty exchangeOrder.logisticsCompany)}">
                                        <a onClick="showLogistics('${exchangeOrder.exchangeOrderId}')" href="javascript:void(0);">填写物流单号</a>
                                    </c:if>
                                    <c:if test="${exchangeOrder.stat == '换货出库'}">
                                        <div class="btn"><a onclick="updateExchangeOrderStatus('${exchangeOrder.exchangeOrderId}')" href="javascript:void(0);">确认收货</a></div>
                                    </c:if>

                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <%--分页 start--%>
                    <div class="page" style="_padding-left: 633px;">
                        <div style="float:right">
                            <c:if test="${exchangeOrderPage.lastPageNumber > 1}">
                                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/exchangePurchase.ac" totalPages='${exchangeOrderPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${exchangeOrderPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
                            </c:if>
                        </div>
                    </div>
                    <%--分页 end--%>
                </div>

            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--申请退换货 end--%>

<%--弹出层 start--%>
<div style="display:none;" id="tip" class="box" title="系统提示" >
    <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px"></div>
</div>
<div style="display:none;" id="tipAddr" class="box" title="填写物流单" >
    <div style="padding:5px 0 0 10px;">
        <label><span style="color: red;">*</span>填写物流单号：</label>
        <div style="padding-top:5px;"><input id="logistics" name="logistics" type="text" maxlength="24" style="height: 25px;width: 250px;"/></div>
    </div>
    <div style="padding:5px 0 0 10px;">
        <label><span style="color: red;">*</span>填写物流公司名称：</label>
        <div style="padding-top:5px;"><input id="companyNm" name="companyNm" type="text" maxlength="24" style="height: 25px;width: 250px;"/></div>
    </div>
</div>
<%--弹出层 end--%>
<div id="buttomLine"></div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>

</body>
</html>
