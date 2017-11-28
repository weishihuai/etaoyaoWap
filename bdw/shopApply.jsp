<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-商铺申请-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/shopApply.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-powerFloat/css/powerFloat.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-powerFloat/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidatorRegex.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-powerFloat/js/jquery-powerFloat.js"></script>
    <%--<script type="text/javascript" src="${webRoot}/ckeditor/adapters/jquery.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var pageValue={
            webRoot:"${webRoot}"
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shopApply.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<!--buy-main-->
<div id="buy-main">
<ul id="process" class="nav"></ul>

<form id="shopInfForm">
    <!--   			 填写店铺信息-->
    <div class="box shopInf_div">
        <%--<c:if test="${empty loginUser.loginId}">
            <div class="id">
                <div class="login"><span></span>登陆ID：</div>
                <div class="name">${loginUser.loginId}</div>
                <div class="clear"></div>
            </div>
        </c:if>--%>
        <div class="info">
            <div class="info-l">
                <div class="login"><span>*</span>姓名：</div>
                <div><input class="put" type="text" id="name" name="name"/></div>
            </div>
            <div class="info-r">
                <div class="login"><span>*</span>店铺名称：</div>
                <div><input class="put" type="text" id="shopNm" name="shopNm"/></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login"><span>*</span>手机号码：</div>
                <div><input class="put" type="text" id="mobile" name="mobile" /></div>
            </div>
            <div class="info-r">
                <div class="login">域名：</div>
                <div><input class="put" type="text" id="subDomain" name="subDomain"  /></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login"><%--<span>*</span>--%>电子邮箱：</div>
                <div><input class="put" type="text" id="email" name="email" /></div>
            </div>
            <div class="info-r">
                <div class="login">职位：</div>
                <div><input class="put" type="text" id="post" name="post" /></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login">传真号码：</div>
                <div><input class="put put1" type="text" id="cz_q" name="cz_q"/></div>
                <div><input class="put put2" type="text" id="cz_h" name="cz_h"/></div>
                <div><input class="put put3" type="text" id="cz_f" name="cz_f"/></div>
                <div class="text">格式：区号-号码-分机号</div>
                <input type="hidden" id="fax" name="fax"/>
            </div>
            <div class="info-r">
                <div class="login">电话：</div>
                <div><input class="put put1" type="text" id="dh_q" name="dh_q"/></div>
                <div><input class="put put2" type="text" id="dh_h" name="dh_h"/></div>
                <div><input class="put put3" type="text" id="dh_f" name="dh_f"/></div>
                <div class="text">格式：区号-号码-分机号</div>
                <input type="hidden" id="tel" name="tel"/>
            </div>

            <input type="hidden" id="storeType" name="storeType"/>
            <div class="info">
                <div class="info-l">
                    <div class="login"><span>*</span>店铺类型：</div>
                    <div style="line-height: 40px;">
                        <input type="radio" id="supplier" name="shopType" checked="checked" style="margin: 0px 10px;" value="1" />
                        <span style="font-size: 14px;">供应商</span>
                        <input  type="radio" id="store" name="shopType" style="margin: 0px 10px;" value="2" store="1"/>
                        <span style="font-size: 14px;">自营门店</span>
                        <input  type="radio" id="alley" name="shopType" style="margin: 0px 10px;" value="2" store="0"/>
                        <span style="font-size: 14px;">加盟门店</span>
                    </div>

                </div>
                <div class="clear"></div>
            </div>

            <div class="clear"></div>
        </div>
        <div class="next shopInfNext"><a href="#Num" onclick="shopInfNext()"><img src="${webRoot}/template/bdw/statics/images/bt4.jpg" /></a></div>
        <div class="clear"></div>
    </div>

    <!--    	填写公司信息-->
    <div class="box company_div" style="display: none;">
        <div class="info">
            <div class="info-l">
                <div class="login">法定代表人：</div>
                <div><input class="put" type="text" id="legalPerson" name="legalPerson" maxlength="20"/></div>
            </div>
            <div class="info-r">
                <div class="login">公司注册地址：</div>
                <div><input class="put" type="text" id="regAddr" name="regAddr"/></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login">公司负责人姓名：</div>
                <div><input class="put" type="text" id="companyCeo" name="companyCeo" maxlength="20"/></div>
            </div>
            <div class="info-r">
                <div class="login">联系地址：</div>
                <div><input class="put" type="text" id="contactAddr" name="contactAddr" maxlength="128"/></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login">公司负责人手机：</div>
                <div><input class="put" type="text" id="ceoMobile" name="ceoMobile" /></div>
            </div>
            <div class="info-r">
                <div class="login">成立日期：</div>
                <div><input class="put" type="text"  id="companyCreateDateString" name="companyCreateDateString"  /></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login">公司名称：</div>
                <div><input class="put" type="text" id="companyNm" name="companyNm" maxlength="64"/></div>
            </div>
            <div class="info-r">
                <div class="login">注册资金：</div>
                <div><input class="put" type="text" id="regCapital" name="regCapital"/><span style="position: relative;top: 7px;left: 4px;">万元</span></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login">邮政编码：</div>
                <div><input class="put" type="text" id="zipcode" name="zipcode" /></div>
            </div>

            <%--<div class="info-r">
                <div class="login">合同编号：</div>
                <div><input class="put" type="text" id="contractNumber" name="contractNumber"  /></div>
            </div>--%>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="label">&nbsp;&nbsp;&nbsp;营业执照有效期：</div>
                <div class="start_2 inputAll"><input class="put" type="text" id="start_date" name="CompanyLicStartDateString" /></div>
                <div class="label">&nbsp;至&nbsp;</div>
                <div class="end_2 inputAll"><input class="put" type="text" id="end_date" name="CompanyLicEndDateString"  /></div>
            </div>
            <div class="info-r">
                <div class="login">是否有实体店：</div>
                <div><input class="checkbox" type="checkbox" checked="checked" onclick="setCheck(this,'Y')" name="isOffline" /></div>
                <div class="have">我有实体店</div>
                <div><input class="checkbox" type="checkbox" onclick="setCheck(this,'N')" name="isOffline" /></div>
                <div class="have">没有</div>
                <input type="hidden" class="isOffLineShop" name="isOffLineShop" value="Y">
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l">
                <div class="login login1">营业执照经营范围：</div>
                <textarea class="textarea" id="businessScopeDesc" name="businessScopeDesc"></textarea>
            </div>
            <div class="clear"></div>
        </div>
        <div class="next"><a href="#Num2" onclick="companyInfNext()"><img src="${webRoot}/template/bdw/statics/images/bt4.jpg" /></a></div>
        <div class="next3"><a href="#" onclick="preDiv()"><img src="${webRoot}/template/bdw/statics/images/btn1.jpg" /></a></div>
        <div class="clear"></div>
    </div>

    <!--		商铺资质信息-->
    <div class="box info_div" style="display: none;">
        <%--<div class="info">
            <div class="info-l info-l2">
                <div class="login login3">组织机构代码证复印件：</div>
                <div><input id="upload_pic" class="put put6" type="text" name="wb" readonly="true" /></div>
                <div class="btn" id="upLoad_btn"><a style="cursor: pointer">选择上传文件</a></div>
                <div class="btn2 watch1" ><a href="javascript:">查看</a></div>
            </div>
            <input type="hidden" name="orgCodeFileId" id="photoFileId" value=""  />
            <div class="clear"></div>
        </div>--%>
        <div class="info">
            <div class="info-l info-l2">
                <div class="login login3">税务登记证复印件：</div>
                <div><input id="upload_pic2" class="put put6" type="text" name="wb" readonly="true" /></div>
                <div class="btn" id="upLoad_btn2"><a style="cursor: pointer">选择上传文件</a></div>
                <div class="btn2 watch2" ><a href="javascript:">查看</a></div>
            </div>
            <input type="hidden" name="taxFileId" id="photoFileId2" value=""  />
            <div class="clear"></div>
        </div>
        <div class="info">
            <div class="info-l info-l2">
                <div class="login login3">企业营业执照副本复印件名：</div>
                <div><input id="upload_pic3" class="put put6" type="text" name="wb" readonly="true" /></div>
                <div class="btn" id="upLoad_btn3"><a style="cursor: pointer">选择上传文件</a></div>
                <div class="btn2 watch3" ><a href="javascript:">查看</a></div>
            </div>
            <input type="hidden" name="licFileId" id="photoFileId3" value=""  />
            <div class="clear"></div>
        </div>
        <div class="next"><a href="#Num3" onclick="infoNext()"><img src="${webRoot}/template/bdw/statics/images/bt4.jpg" /></a></div>
        <div class="next3"><a href="#Num2" onclick="shopInfNext()"><img src="${webRoot}/template/bdw/statics/images/btn1.jpg" /></a></div>
        <div class="clear"></div>
    </div>
</form>


<!--    立即开店-->
<div class="box2 detailMsg" style="display: none;">
    <%--<c:if test="${empty loginUser.loginId}">
        <div class="layer">
            <div class="login5">登录ID：</div>
            <div class="name3">${loginUser.loginId}</div>
            <div class="clear"></div>
        </div>
    </c:if>--%>
    <div class="layer">
        <div class="info3">店铺信息</div>
    </div>
    <div class="layer">
        <div class="shop-name">店主姓名</div>
        <div class="shop-name2 name"></div>
        <div class="shop-name shop-name3">店铺名称</div>
        <div class="shop-name2 shop-name4 shopNm"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">手机号码</div>
        <div class="shop-name2 mobile"></div>
        <div class="shop-name shop-name3">域名</div>
        <div class="shop-name2 shop-name4 subDomain"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">电子邮箱</div>
        <div class="shop-name2 email"></div>
        <div class="shop-name shop-name3">职位</div>
        <div class="shop-name2 shop-name4 post"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">传真号码</div>
        <div class="shop-name2 fax"></div>
        <div class="shop-name shop-name3">电话</div>
        <div class="shop-name2 shop-name4 tel"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="info3">公司信息</div>
    </div>
    <div class="layer">
        <div class="shop-name">法定代表人</div>
        <div class="shop-name2 legalPerson"></div>
        <div class="shop-name shop-name3">公司注册地址</div>
        <div class="shop-name2 shop-name4 regAddr"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">公司负责人姓名</div>
        <div class="shop-name2 companyCeo"></div>
        <div class="shop-name shop-name3">联系地址</div>
        <div class="shop-name2 shop-name4 contactAddr"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">公司负责人手机</div>
        <div class="shop-name2 ceoMobile"></div>
        <div class="shop-name shop-name3">成立日期</div>
        <div class="shop-name2 shop-name4 companyCreateDateString"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">公司名称</div>
        <div class="shop-name2 companyNm"></div>
        <div class="shop-name shop-name3">注册资金</div>
        <div class="shop-name2 shop-name4 regCapital"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">邮政编码</div>
        <div class="shop-name2 zipcode"></div>
        <div class="shop-name shop-name3">是否有实体店</div>
        <div class="shop-name2 shop-name4 isOffLineShop"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">营业执照有效期</div>
        <div class="shop-name2">
            <div class="shop-start" style="float: left;"></div>
            <span style="float: left;padding: 0 5px;">至</span>
            <div class="shop-end" style="float: left;"></div>
            <div></div>
        </div>
        <div class="shop-name shop-name3">合同编号</div>
        <div class="shop-name2 shop-name4 contractNumber"></div>
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="info3">店铺资质信息</div>
    </div>
    <div class="layer">
        <div class="shop-name">营业执照经营范围</div>
        <div class="businessScopeDesc shop-name2"  style="width: 797px;"></div>
        <div class="clear"></div>
    </div>
    <%--<div class="layer">
        <div class="shop-name">组织机构代码复印件</div>
        <div class="shop-name2 shop-name4 look watch1"><a href="javascript:" style="color: #0066FF">查看</a></div>
        <input type="hidden" class="put6 picDetail1" value="">
        <div class="clear"></div>
    </div>--%>
    <div class="layer">
        <div class="shop-name">税务登记证复印件</div>
        <div class="shop-name2 shop-name4 look watch2"><a href="javascript:" style="color: #0066FF">查看</a></div>
        <input type="hidden" class="put6 picDetail2" value="">
        <div class="clear"></div>
    </div>
    <div class="layer">
        <div class="shop-name">企业营业执照副本复印件</div>
        <div class="shop-name2 shop-name4 look watch3"><a href="javascript:" style="color: #0066FF">查看</a></div>
        <input type="hidden" class="put6 picDetail3" value="">
        <div class="clear"></div>
    </div>
</div>
<div class="btn3 detailMsg" style="display: none;"><a href="#Num2" onclick="companyInfNext()"><img src="${webRoot}/template/bdw/statics/images/btn1.jpg" /></a></div>
<div class="btn4 detailMsg" style="display: none;"><a href="javascript:" onclick="toSubmit()"><img src="${webRoot}/template/bdw/statics/images/btn2.jpg" /></a></div>
<div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>

<div style="display:none;" id="tip" class="box" title="组织机构代码证复印件" >
    <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px">
        <form id="upload" action="${webRoot}/member/uploadPhoto.ac" method="post" enctype="multipart/form-data">
            <input type="file" id="tmpFile" name="imageFile" />
        </form>
    </div>
</div>
<div style="display:none;" id="tip2" class="box" title="税务登记证复印件" >
    <div align="center" id="tiptext2" style="font-size: 14px;font-weight: bold;padding: 15px">
        <form id="upload2" action="${webRoot}/member/uploadPhoto.ac" method="post" enctype="multipart/form-data">
            <input type="file" id="tmpFile2" name="imageFile" />
        </form>
    </div>
</div>
<div style="display:none;" id="tip3" class="box" title="企业营业执照副本复印件名" >
    <div align="center" id="tiptext3" style="font-size: 14px;font-weight: bold;padding: 15px">
        <form id="upload3" action="${webRoot}/member/uploadPhoto.ac" method="post" enctype="multipart/form-data">
            <input type="file" id="tmpFile3" name="imageFile" />
        </form>
    </div>
</div>
</html>
