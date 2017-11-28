<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>我要反馈-${webName}</title>
        <meta content="yes" name="apple-mobile-web-app-capable">
        <meta content="yes" name="apple-touch-fullscreen">
        <meta content="telephone=no,email=no" name="format-detection">
        <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"  />
        <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/module/member/statics/css/pre-fill.css" type="text/css" rel="stylesheet" />

        <script>
            var webPath = {
                webRoot: "${webRoot}"
            };
        </script>
        <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
        <script src="${webRoot}/template/bdw/wap/module/member/statics/js/feedback.js"></script>
    </head>
    <body>
        <div class="m-top">
            <a href="javascript:history.go(-1)" class="back"></a>
            <span>我要反馈</span>
        </div>
        <div class="fill-main">
            <div class="mt">请选择您要咨询的类型</div>
            <div class="fill-type">
                <a href="javascript:void(0);" class="selected">建议</a>
                <a href="javascript:void(0);">投诉</a>
            </div>
            <div class="mt">请描述下您的问题</div>
            <textarea id="feedbackCont" class="fill-box" placeholder="例：商品出现破损怎么处理" maxlength="255" oninput="changeFeedbackCont()"></textarea>
            <p id="feedbackContLength" class="orange">0/255</p>
        </div>
        <div class="m-sub"><a id="confirmBtn" href="javascript:void(0);" class="disable" onclick="submitFeedback()"><span>提交</span></a></div>
        <div class="fill-reminder" id="errorMsg" style="display: none">描述字符请在255字内</div>
    </body>
</html>
