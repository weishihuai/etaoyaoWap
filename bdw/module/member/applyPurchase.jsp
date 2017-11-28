<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${sdk:findOrderDetailed(param.orderId)}" var="orderProxy"/><%--查询订单详细--%>
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
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/formValidatorRegex.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/ObjectToJsonUtil.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",receiverZoneId:"${orderProxy.receiverZoneId}",orderItems :'${param.orderItems}',orderId:'${param.orderId}'};
        var isReturn = ${param.isReturn};
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html"  title="首页">首页</a> > <a href="${webRoot}/module/member/index.ac"  title="会员中心">会员中心</a> > 申请提现</div></div>
<%--面包屑导航 end--%>

<%--申请提现 start--%>
<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <h2 class="rightbox_h2_border">我选择退换货的商品</h2>
        <div class="adress purchase right_box_border">
            <%--申请提现列表 start--%>
            <div class="t2">
                <h3>申请退换货列表</h3>
                <div id="return_div">
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td1">商品名称</td>
                            <td class="td2">退货数量</td>
                            <td class="td3">商品单价</td>
                            <td class="td7">操作</td>
                        </tr>
                        <c:forEach end="10" items="${param.orderItems}" var="orderItemId">
                            <c:set value="${sdk:getOrderItemProxyById(orderItemId)}" var="orderItemProxy"/>
                            <tr class="orderItem" <c:if test="${orderItemProxy.combinedProductId != null}">combinedProductId ="${orderItemProxy.combinedProductId}" combinedProductItemNum = ${bdw:getCombinedProductNum(orderItemProxy.combinedProductId, orderItemProxy.skuId)}</c:if> id="${orderItemId}_div">
                                <input type="hidden" name="skuId" value="${orderItemProxy.skuId}"/>
                                <input type="hidden" name="orderItemId" value="${orderItemId}"/>
                                <td class="td1">${orderItemProxy.productProxy.name}</td>
                                <td class="td2"><input type="text" class="return_num" name="num" value="${orderItemProxy.canReturnNum != null ? orderItemProxy.canReturnNum : 0}" canReturnNum="${orderItemProxy.canReturnNum != null ? orderItemProxy.canReturnNum : 0}" onblur="changeItemNum('${orderItemId}_num','${orderItemProxy.canReturnNum != null ? orderItemProxy.canReturnNum : 0}');" id="${orderItemId}_num" /></td>
                                <td class="td3"><fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></td>
                                <td class="td7">
                                    <a href="javascript:" class="return_removeItem" onclick="removeOrderItem('${orderItemId}_div')" style="color: #fff;">移除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <%--申请提现列表 end--%>
            <c:choose>
                <c:when test="${param.isReturn == 'true'}">
                    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/applyPurchase.js"></script>
                    <%--退货--%>
                    <div class="t1">
                        <h4><b>填写处理内容</b></h4>
                        <div class="newAddress">
                            <form id="purchaseForm" method="post">
                                <div class="fixBox">
                                    <label><span>*</span>处理方式：</label>
                                    <div class="put" style="line-height:27px;"><input name="typeCode" value="1" type="hidden" >退货</div>
                                    <div id="typeCodeTip" style="float: left"></div>
                                </div>
                                <div class="fixBox">
                                    <label><span>*</span>问题备注：</label>
                                    <div class="put"><textarea rows="4" cols="35"  id="remark" name="remark" class="reason"></textarea></div>
                                    <div id="remarkTip" style="float: left"></div>
                                </div>
                                <div class="fixBox" id="addr_div" style="display: none">
                                    <label><span>*</span>收货地址：</label>
                                    <div class="put selT">
                                        <p class="row">
                                            <select class="addressSelect"  id="province">
                                                <option value="">请选择...</option>
                                            </select>
                                            <select  class="addressSelect" id="city">
                                                <option value="">请选择...</option>
                                            </select>
                                            <select class="addressSelect"  id="zone">
                                                <option value="">请选择...</option>
                                            </select>
                                        </p>
                                        <p style="padding-top:10px;float: left;">
                                            <input type="text" name="receiverAddr" id="receiverAddr" value="${orderProxy.address}">
                                        </p>
                                        <div style="padding-top:10px;float: left; margin: 0px; background: none repeat scroll 0% 0% transparent; display: none;" id="addrTipError"><span class="onError"><span class="onError_top">请完善收货地址</span><span class="onError_bot"></span></span></div>
                                        <div style="padding-top:10px;float: left; margin: 0px; background: none repeat scroll 0% 0% transparent; display: none;" id="addrTipCorrect"><span class="onCorrect"></span></div>
                                    </div>
                                </div>
                                <div class="fixBox">
                                    <label><span>*</span>联系人：</label>
                                    <div class="put">
                                        <input style="height:20px;" id="receiverName" name="receiverName" class="text" type="text" value="${orderProxy.receiverName}">
                                    </div>
                                    <div id="receiverNameTip" style="float: left"></div>
                                </div>
                                <div class="fixBox">
                                    <label><span>*</span>手机号码：</label>
                                    <div class="put"><input style="height:20px;" id="receiverMobile" name="receiverMobile" class="text text01" type="text" value="${orderProxy.mobile}"></div>
                                    <div id="receiverMobileTip" style="float: left"></div>
                                </div>
                                <div class="fixBox">
                                        <%--<label><span>*</span>上传图片：</label>--%>
                                    <label>上传图片：</label>
                                    <div class="put pruchaseUpload">
                                        <div class="pic"><img id="upload_pic" src="${webRoot}/${templateCatalog}/statics/images/noPic_100X100.jpg" alt=""></div>
                                        <div class="upLoad"><a href="javascript:void(0)" id="upLoad_btn">上传照片</a></div>
                                        <input type="hidden" name="photoFileId" id="photoFileId" value="" />
                                    </div>
                                    <div id="photoFileIdTip" style="float: left"></div>
                                </div>
                                <div class="btn"><a id="btnAdd" href="javascript:">确认提交</a></div>
                            </form>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/exchangeApplyPurchase.js"></script>
                    <%--换货--%>
                    <div class="t1">
                        <h4><b>填写处理内容</b></h4>
                        <div class="newAddress">
                            <form id="hh_purchaseForm" method="post">
                                <div class="fixBox">
                                    <label><span>*</span>处理方式：</label>
                                    <div class="put" style="line-height:27px;"><input name="typeCode" value="0" type="hidden" >换货</div>
                                    <div id="hh_typeCodeTip" style="float: left"></div>
                                </div>
                                <div class="fixBox">
                                    <label><span>*</span>问题备注：</label>
                                    <div class="put"><textarea rows="4" cols="35"  id="hh_remark" name="remark" class="reason"></textarea></div>
                                    <div id="hh_remarkTip" style="float: left"></div>
                                </div>
                                <div class="fixBox" id="hh_addr_div">
                                    <label><span>*</span>收货地址：</label>
                                    <div class="put selT">
                                        <p class="row">
                                            <select class="addressSelect"  id="hh_province">
                                                <option value="">请选择...</option>
                                            </select>
                                            <select  class="addressSelect" id="hh_city">
                                                <option value="">请选择...</option>
                                            </select>
                                            <select class="addressSelect"  id="hh_zone">
                                                <option value="">请选择...</option>
                                            </select>
                                        </p>
                                        <p style="padding-top:10px;float: left;">
                                            <input type="text" name="receiverAddr" id="hh_receiverAddr" value="${orderProxy.address}">
                                        </p>
                                        <div style="padding-top:10px;float: left; margin: 0px; background: none repeat scroll 0% 0% transparent; display: none;" id="hh_addrTipError"><span class="onError"><span class="onError_top">请完善收货地址</span><span class="onError_bot"></span></span></div>
                                        <div style="padding-top:10px;float: left; margin: 0px; background: none repeat scroll 0% 0% transparent; display: none;" id="hh_addrTipCorrect"><span class="onCorrect"></span></div>
                                    </div>
                                </div>
                                <div class="fixBox">
                                    <label><span>*</span>联系人：</label>
                                    <div class="put">
                                        <input style="height:20px;" id="hh_receiverName" name="receiverName" class="text" type="text" value="${orderProxy.receiverName}">
                                    </div>
                                    <div id="hh_receiverNameTip" style="float: left"></div>
                                </div>
                                <div class="fixBox">
                                    <label><span>*</span>手机号码：</label>
                                    <div class="put"><input style="height:20px;" id="hh_receiverMobile" name="receiverMobile" class="text text01" type="text" value="${orderProxy.mobile}"></div>
                                    <div id="hh_receiverMobileTip" style="float: left"></div>
                                </div>
                                <div class="fixBox">
                                        <%--<label><span>*</span>上传图片：</label>--%>
                                    <label>上传图片：</label>
                                    <div class="put pruchaseUpload">
                                        <div class="pic"><img id="hh_upload_pic" src="${webRoot}/${templateCatalog}/statics/images/noPic_100X100.jpg" alt=""></div>
                                        <div class="upLoad"><a href="javascript:void(0)" id="hh_upLoad_btn">上传照片</a></div>
                                        <input type="hidden" name="photoFileId" id="hh_photoFileId" value="" />
                                    </div>
                                    <div id="photoFileIdTip" style="float: left"></div>
                                </div>
                                <div class="btn"><a id="hh_btnAdd" href="javascript:">确认提交</a></div>
                            </form>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <%--申请提现信息 start--%>

            <%--申请提现信息 end--%>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--申请提现 end--%>

<div id="buttomLine"></div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
<div style="display:none;" id="tip" class="box" title="上传图片" >
    <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px">
        <form id="upload" action="${webRoot}/member/uploadPhoto.ac" method="post" enctype="multipart/form-data">
            <input type="file" id="tmpFile" name="imageFile" />
        </form>
    </div>
</div>

<div style="display:none;" id="hh_tip" class="box" title="上传图片" >
    <div align="center" id="hh_tiptext" style="font-size: 14px;font-weight: bold;padding: 15px">
        <form id="hh_upload" action="${webRoot}/member/uploadPhoto.ac" method="post" enctype="multipart/form-data">
            <input type="file" id="hh_tmpFile" name="imageFile" />
        </form>
    </div>
</div>
</body>
</html>
