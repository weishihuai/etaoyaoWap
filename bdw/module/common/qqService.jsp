<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<link href="${webRoot}/template/bdw/statics/css/kfstyle.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/lrtk.js"></script>
<c:set var="codeImg" value="${sdk:findPageModuleProxy('common_kf_code').advt}"/>


<!--QQ客服 代码 开始 -->
<div class="main-im">
  <div id="open_im" class="open-im">&nbsp;</div>
  <div class="im_main" id="im_main">
    <div id="close_im" class="close-im"><a href="javascript:void(0);" title="点击关闭">&nbsp;</a></div>
    <a class="im-qq qq-a" title="在线QQ客服">
      <div class="qq-container"></div>
      <div class="qq-hover-c"><img class="img-qq" src="${webRoot}/template/bdw/statics/images/qqpic.png"></div>
      <span> QQ在线咨询</span>
    </a>
    <ul class="im-ser frameEdit" frameInfo="common_kf_info">
      <c:forEach items="${sdk:findPageModuleProxy('common_kf_info').links}" var="link" end="4">
        <li><a target="${link.newWin ? '_blank' : '_self'}" href="${link.link}">${link.title}</a></li>
      </c:forEach>
    </ul>
    <div class="im-tel frameEdit" frameInfo="common_kf_tel">
      <c:forEach items="${sdk:findPageModuleProxy('common_kf_tel').links}" var="tel" end="3">
        <div>${tel.title}</div>
        <div class="tel-num">${tel.description}</div>
      </c:forEach>
    </div>
    <div class="im-footer" style="position:relative">
      <div class="weixing-container">
        <div class="weixing-show frameEdit" frameInfo="common_kf_code">
          <c:forEach items="${codeImg.advtProxy}" var="advt" end="0">
            <div class="weixing-txt">微信扫一扫<br>${advt.title}</div>
            <img class="weixing-ma" src="${advt.advUrl}">
            <div class="weixing-sanjiao"></div>
            <div class="weixing-sanjiao-big"></div>
          </c:forEach>
        </div>
      </div>
      <div class="go-top"><a href="javascript:;" title="返回顶部"></a> </div>
      <div style="clear:both"></div>
    </div>
  </div>
</div>
<!--QQ客服 代码 结束 -->