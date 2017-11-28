<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${webName}-已发表评论</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userTalk.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=product"/>
<%--页头结束--%>

<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<div id="position" class="m1-bg"> <div class="m1"><a href="${webRoot}/index.html">首页</a>
    <c:forEach items="${productProxy.category.categoryTree}" var="node" begin="1">
        > <a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a>
    </c:forEach>
    > <a href="${webRoot}/product-${param.id}.html" title="${productProxy.name}">${productProxy.name}</a>
    </div>
</div>

<div id="userTalk">
    <%--商品详细--%>
        <div class="lBox">
            <c:import url="/template/bdw/comment/includeProduct.jsp?id=${param.id}"/>
        </div>
    <%--商品详细--%>
	<div class="rBox">
		<div class="Put-B">
       <div class="t_Area">
	      <div class="tit">发表评论成功</div>
		  <div class="clear"></div>
	   </div>
	   <div class="box">
	      <div class="m1">
             <div class="success">
                 <p>发表评论成功！</p>
             </div>
		     <div class="t1">给商品评分：
                 <c:forEach begin="1" end="${param.gradeLevel}">
                    <img src="${webRoot}/template/bdw/statics/images/userTalk_star01.gif" />
                 </c:forEach>
                 <span>
                     <c:choose>
                         <c:when test="${param.gradeLevel >= 4}">
                             ${param.gradeLevel}分 非常满意
                         </c:when>
                         <c:when test="${param.gradeLevel == 3}">
                             ${param.gradeLevel}分 较好
                         </c:when>
                         <c:otherwise>
                             ${param.gradeLevel}分 一般
                         </c:otherwise>
                     </c:choose>
                 </span></div>
			 <div class="t2">
			    <label>您对此商品的评价：</label>
				<div class="result">
                    <%
                        /*  String commentCont = new String(request.getParameter("commentCont").getBytes("iso8859-1"),"utf-8");*/
                        String commentCont = request.getParameter("commentCont");
                        out.print(commentCont);
                    %>
                </div>
             </div>
              <div class="t2" style="position: relative;top: -122px;">
                  <label>晒图：</label>
                  <div class="result">
                      <c:set value="${fn:split(param.repPict,',')}" var="picArray" />
                      <c:forEach items="${picArray}" var="pic">
                          <img src="${pic}" width="100px" height="100px"/>
                      </c:forEach>
                  </div>
                  <div>
                  <div class="clear"></div>
             <div class="t2">
			    <label>&nbsp;</label>
				<div class="btn">
                    <a href="${webRoot}/product-${param.id}.html" title="${productProxy.name}">返回查看商品</a>
                </div>
				<div class="clear"></div>
			 </div>
		  </div>
	   </div>
   </div>
	</div>
	<div class="clear"></div>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
