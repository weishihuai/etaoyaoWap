<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!-- 绑定优惠券 -->
<link href="${webRoot}/template/bdw/statics/css/addorder_new.css" rel="stylesheet" type="text/css" />

<div class="couponlayer" style="display: none;">
    <div class="layer-box layer-binding-coupon">
        <div class="layer-header">
            <span>绑定优惠券</span>
            <a href="javascript:;" class="close"></a>
        </div>
        <div class="layer-body">
            <div class="item">
                <div class="mlt">优惠券编号</div>
                <div class="mrt">
                    <input  id="cardNum"  type="text">
                </div>
            </div>
            <div class="item">
                <div class="mlt">优惠券密码</div>
                <div class="mrt">
                    <input type="text"  id="cardPwd">
                </div>
            </div>
        </div>
        <div class="layer-footer">
            <a href="javascript:;" id="bindCoupon" class="confirm">确认激活</a>
        </div>
    </div>
</div>