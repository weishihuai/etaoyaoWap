<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="bdw" %>
<c:set value="${bdw:getAdminPickedUp()}" var="adminPickedUp"/>
<c:if test="${empty adminPickedUp}">
  <c:redirect url="/ziti.ac"></c:redirect>
</c:if>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${param.orderNum}" var="orderNum"/>
<c:set var="pickedId" value="${param.pickedUpId}"/>
<c:set value="${bdw:findReceivingList('Y','N','N',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="notReceiving"/>
<c:set value="${bdw:findReceivingList('Y','Y','N',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="receiving"/>
<c:set value="${bdw:findReceivingList('Y','Y','Y',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="pickedUp"/>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>${webName}-提货验证</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css"/>
  <link href="${webRoot}/template/bdw/pickedUp/style/l_header.css" type="text/css" rel="stylesheet"/>
  <link href="${webRoot}/template/bdw/pickedUp/style/take.css" type="text/css" rel="stylesheet"/>
  <script type="text/javascript">
    var webPath = {webRoot: "${webRoot}"};
    var pickedid = {pickedUpId: "${pickedId}"};
  </script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
  <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.base64.js"></script>--%>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/pickedUp/common/top.jsp"/>
<%--页头开始--%>
<div class="t_index_bg">
  <div class="t_index">
    <div class="id_top">
      <ul>
        <li>
          <a href="${webRoot}/template/bdw/pickedUp/notReceiving.jsp">待收货订单<em>（<i>${not empty notReceiving?notReceiving.totalCount:0}</i>）</em></a>
        </li>
        <li>
          <a href="${webRoot}/template/bdw/pickedUp/receiving.jsp">已收货订单<em>（<i>${not empty receiving?receiving.totalCount:0}</i>）</em></a>
        </li>
        <li class="last cur">
          <a href="javascript:;">已提货订单<em>（<i>${not empty pickedUp?pickedUp.totalCount:0}</i></i>）</em></a>
        </li>
      </ul>
      <a href="${webRoot}/template/bdw/pickedUp/pickedUpVerify.jsp" class="t-btn">提货</a>
    </div>
    <div class="id_main">
      <div class="verify">
        <div class="item2">
          <p>订单号:<em>${orderNum}</em></p>
          <i>已经成功验证提货密码</i>
        </div>
        <input type="hidden" id="OrderNumVerify" value="${orderNum}"/>
        <div class="login_btn"><a href="${webRoot}/template/bdw/pickedUp/pickedUpVerify.jsp">继续提货</a></div>
      </div>
    </div>

  </div>
</div>
<%--页尾开始--%>
<c:import url="/template/bdw/pickedUp/common/bottom.jsp"/>
<%--页尾开始--%>

</body>
</html>
