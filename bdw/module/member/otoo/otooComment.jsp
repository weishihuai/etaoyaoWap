<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>

<c:set var="pageNum" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${bdw:getOtooUserComment(pageNum,6,loginUser.userId)}" var="userCommentPage"/>   <%--获取O2O商品评价列表--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
  <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
  <title>O2O商品评论-${webName}-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>

  <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/template/bdw/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/template/bdw/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/template/bdw/module/member/statics/css/layer.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/template/bdw/module/member/otoo/statics/css/evaluate-list.css" rel="stylesheet" type="text/css" />

  <link href="${webRoot}/template/bdw/statics/js/easydialog/news_html.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.DOMWindow.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>

</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >  O2O商品评价 </div></div>
<%--面包屑导航 end--%>

  <div id="member">
    <%--左边菜单栏 start--%>
      <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
          <div class="right">
              <div class="tit">
                  评价
              </div>
              <div class="s-tit">
                  <span class="tit01">商品名称</span>
                  <span class="tit02">总体评分</span>
                  <span class="tit03">评价内容</span>
              </div>
              <c:choose>
                  <c:when test="${empty userCommentPage.result}">
                      <div class="b_info">
                          <li class="e-none" style="padding-left:268px;width:502px;height: 160px;padding-top: 50px;"><!--，没有搜到商品-->
                            <p><i>你没有做出评价？</i></p>
                            <a href="${webRoot}/index.html">返回首页>></a>
                          </li>
                      </div>
                  </c:when>
                  <c:otherwise>
                      <c:forEach items="${userCommentPage.result}" var="commentProxy" varStatus="status">
                          <div class="item">
                              <div class="i-tit">
                                 <strong>订单编号：${commentProxy.otooOrderNum}</strong>评价时间:${commentProxy.otooCreateTimeString}<i></i>
                              </div>

                              <div class="i-con">
                                  <div class="con01">
                                      <a class="img"  href="${webRoot}/otoo/product.ac?id=${commentProxy.otooProductId}" target="_blank" title="${commentProxy.otooProductNm}"><img src="${commentProxy.images}" alt="${commentProxy.otooProductNm}"></a>
                                      <em><a  href="${webRoot}/otoo/product.ac?id=${commentProxy.otooProductId}" target="_blank" title="${commentProxy.otooProductNm}">${commentProxy.otooProductNm}</a></em>
                                  </div>
                                  <div class="con02">
                                      <div class="star-bg">
                                          <c:forEach begin="1" end="${commentProxy.otooProductTotalScore}">
                                            <div class="star"></div>
                                          </c:forEach>
                                      </div>
                                  </div>
                                  <div class="con03">${commentProxy.otooCommentText}</div>
                              </div>
                              <!--i-con end-->
                          </div>
                      </c:forEach>
                  </c:otherwise>
              </c:choose>
            <!--item end-->
          </div>
          <%--分页 start--%>
          <c:if test="${userCommentPage.lastPageNumber > 1}">
              <div style="float:right">
                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/otoo/otooComment.ac" totalPages='${userCommentPage.lastPageNumber}' currentPage='${pageNum}'  totalRecords='${userCommentPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
              </div>
          </c:if>
      <%--分页 end--%>
      <div class="clear"></div>
  </div>
  <c:import url="/template/bdw/module/common/bottom.jsp"/>
</body>
</html>
