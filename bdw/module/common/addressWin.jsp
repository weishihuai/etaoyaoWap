<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<div class="addresslayer" id="addressWin" style="display: none"  >
    <input type="hidden" id="receiveAddrId" name="receiveAddrId" value="">
    <input type="hidden" id="provinceId" name="provinceId" value="">
    <input type="hidden" id="cityId" name="cityId" value="">
    <input type="hidden" id="zoneId" name="zoneId" value="">
    <div class="addresslayer-box layer-shipping-address">
        <div class="addresslayer-header">
            <span>新增收货地址</span>
            <a href="javascript:;" class="close" onclick="closeAddressWin();"></a>
        </div>
        <div class="layer-body">
            <div class="item">
                <div class="mlt"><span>*</span>收货人姓名</div>
                <div class="mrt">
                    <input type="text" name="name" id="name" value="" maxlength="20">
                </div>
            </div>

            <div class="item" id="item_site">
                <div class="mlt"><span>*</span>所在地区</div>
                <div class="mrt">
                    <div class="input-f" id="pathName">省/市/区</div>
                    <div class="site-cj">
                        <ul class="dt">
                            <li class="cur">省份</li>
                            <li>城市</li>
                            <li>区/县</li>
                        </ul>
                        <div class="dd" >
                            <ul style="display: block;" id="provinceConten"></ul>
                            <ul id="cityConten"></ul>
                            <ul id="zoneConten"></ul>
                        </div>
                        <em class="icon"></em>
                    </div>
                </div>
            </div>

            <div class="item">
                <div class="mlt"><span>*</span>详细地址</div>
                <div class="mrt">
                    <input type="text" id="addr" name="addr" value="" maxlength="100">
                </div>
            </div>

            <div class="item">
                <div class="mlt"><span>*</span>手机号码</div>
                <div class="mrt">
                    <input type="text" id="mobile" name="mobile" value="" maxlength="11">
                </div>
            </div>
            <div class="item">
                <div class="mlt">邮政编码</div>
                <div class="mrt">
                    <input type="text" id="zipcode" name="zipcode" value="" maxlength="10">
                </div>
            </div>
            <p class="set-address"><label class="checkbox-box"><input type="checkbox" checked="checked"><em data-checked="true" onclick="setDefaultAddr(this)" id="isDefault"></em></label>设置为默认收货地址</p>
        </div>
        <div class="layer-footer">
            <a href="javascript:;" onclick="saveOrUpdateAddress();" class="confirm">保存收货人信息</a>
        </div>
    </div>
</div>
