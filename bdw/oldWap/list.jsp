<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${param.category==null ? 1 : param.category}" var="categoryId"/>
<c:set value="${sdk:getFacetWithoutFilter()}" var="facetProxy"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<!DOCTYPE HTML>
<html>
  <head>
    <title>商品列表</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.mmenu.css" rel="stylesheet">
   	<link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.mmenu.positioning.css" type="text/css" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/list.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.mmenu.min.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/stickUp.min.js" type="text/javascript" ></script>

    <script type="text/javascript">
        var category = '${categoryId}';
        var keyword = '${param.keyword}';
        var q = '${param.q}';
        var order = '${param.order}';
        <%--var page = '${_page}';--%>
        var webPath = "${webRoot}";
    </script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/list.js" type="text/javascript" ></script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=商品列表"/>
    <%--页头结束--%>
    <div class="row sort">
    	<div class="col-xs-12">
        	<div class="navtabs">
                <ul class="nav nav-tabs" id="myTab">
                  <li class="active"><a role="button" class="btn btn-default" href="#defaut" data-toggle="tab" value='default'>默认排序</a></li>
                  <li><a role="button" class="btn btn-default" href="#sell" data-toggle="tab" value='salesvolume'>销量<span class="caret xxjt1" id="spanSale"></span></a></li>
                  <li><a role="button" class="btn btn-default" href="#price" data-toggle="tab" value='price'>价格<span class="caret xxjt" id="spanPrice"></span></a></li>
                  <div class="filter"><a type="button" class="btn btn-default" href="#menu">筛选</a></div>
                </ul>
            </div>
        </div>
    </div>
    <div class="tab-content ">
        <div class="tab-pane active container" id="defaut" ></div>
        <div class="tab-pane container" id="sell">  </div>
        <div class="tab-pane container" id="price"> </div>
    </div>
    <nav id="menu" class="rightnav">
        <form class="hold-height">
			<div class="attrExtra">
				<a type="button" class="btn btn-sm btn-default confirm" href="#" id="confirm">确定</a>
				<a type="button" class="btn btn-sm btn-default confirm2" href="#" id="cancle">取消</a>
			</div>
			<div id="menu_content" style=" overflow: auto;">
                <c:forEach items="${facetProxy.allSelections}" var="selections" varStatus="s">
                    <c:if test="${fn:length(selections.couts) > 0}">

                        <div class="attr">
                            <div class="attrKey">${fn:substring(selections.title,0,6)}</div>
                            <div class="attrValues">
                                <ul >
                                    <c:forEach items="${selections.couts}" var="count" begin="0" end="3">
                                    <c:if test="${not empty count.name}">
                                        <li class="attrRow ${count.selected?"av-selected":""}" group='${selections.field}' value="${selections.field}:${count.value}"><a  href="#">${fn:substring(count.name,0,10)}</a></li>
                                    </c:if>
                                    </c:forEach>
                                </ul>
                                <div id="collapse${s.index}" class="collapse">
                                    <ul>
                                        <c:forEach items="${selections.couts}" var="count" begin="4">
                                        <c:if test="${not empty count.name}">
                                            <li class="attrRow ${count.selected?"av-selected":""}" group='${selections.field}' value="${selections.field}:${count.value}" ><a href="#">${fn:substring(count.name,0,10)}</a></li>
                                        </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="more">
                                    <c:if test="${fn:length(selections.couts) > 4}">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse${s.index}">更多属性>></a>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                    </c:if>
                </c:forEach>
                <div style="height:50px;padding-bottom: 50px;">
                    &nbsp;
                </div>
			</div>
        </form>
    </nav>
    <c:choose>
        <c:when test="${empty loginUser.bytUserId}">
            <%--页脚开始--%>
            <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
            <%--页脚结束--%>
        </c:when>
    </c:choose>
  </body>
</html>
