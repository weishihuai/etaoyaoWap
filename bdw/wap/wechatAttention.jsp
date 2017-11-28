
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/wechatAttention.js"></script>
<link href="${webRoot}/template/bdw/wap/statics/css/wechatAttention.css" type="text/css" rel="stylesheet"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = "false";
    if (null != request.getCookies()) {
        Cookie[] cookie = request.getCookies();
        for (int i = 0; i < cookie.length; i++) {
            if (cookie[i].getName().equals("wechatAttentionLayerShowTime")) {
                name = "true";
                break;
            }
        }
    }
%>
<div class="attention" style="display: <%=name =="true"? "none":"block"%>">
    <a href="javascript:;" class="close" onclick="hideWechatAttentionLayer()"></a>
    <span>关注易淘药,尽享优惠哦！</span>
    <a href="javascript:;" class="att-btn wechatAttentionBtn"></a>
</div>

<div class="att-tion" style="display: none">
    <div class="att-box">
        <h5>关注易淘药，尽享优惠</h5>
        <p><span>长按指纹</span>识别二维码加关注</p>
        <div class="att-mc">
            <img src="${webRoot}/template/bdw/wap/statics/images/zhiwen.png" alt="指纹">
            <img src="${webRoot}/template/bdw/wap/statics/images/erweima.jpg" alt="二维码" class="right ">
        </div>
        <a href="##" class="att-close wechatAttentionBtn"></a>
    </div>
</div>

