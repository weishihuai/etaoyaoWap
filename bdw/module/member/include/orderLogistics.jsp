<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<div class="tit">
    <ul>
        <li class="li1">处理时间</li>
        <li class="li2">处理信息,<span style="padding-left:20px"/>以下数据由<a href="http://www.kuaidi100.com">快递100提供</a></li>
    </ul>
</div>
<div class="b">
    <table width="100%" border="0" cellspacing="0">
        <c:forEach items="${result}" var="stat">
            <tr>
                <td class="td1">${stat.dateString}</td>
                <td class="td2">${stat.content}</td>
            </tr>
        </c:forEach>
    </table>
</div>
