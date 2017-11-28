<%@ page contentType="text/html;charset=UTF-8" language="java" %>


	<div class="header02">
        <div class="logo frameEdit"  frameInfo="header_logo|300X100">
            <c:forEach items="${sdk:findPageModuleProxy('sy_index_logo').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                <c:if test="${!empty advtProxys}">
                    <a href="${advtProxys.link}">
                        <img src="${advtProxys.advUrl}" alt="${webName}">
                    </a>
                </c:if>
            </c:forEach>
        </div>
		<h5>门店入驻</h5>
		<div class="login">
			已有门店账号?
			<a href="${webRoot}/admin.jsp">请登录</a>
		</div>
	</div>


