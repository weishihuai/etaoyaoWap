<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-27
  Time: 下午3:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>添加收货地址</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script type="text/javascript">
        <%--初始化参数，供myAddressBook.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        var change = false;
        var receiveAddrId = ${empty param.receiveAddrId}?false:"${param.receiveAddrId}";

        <%--初始化参数，供myAddressBook.js调用 end--%>
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/myAddressBook.js"></script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=添加收货地址"/>
<%--页头结束--%>
<input style="display: none" id="receiveAddrId" value="${empty param.receiveAddrId?'':param.receiveAddrId}"/>
<div class="container">
    <div class="row m_rows2">
        <div class="col-xs-3">收货人</div>
        <div class="col-xs-9"><input  id="name" type="text" placeholder="请输入收货人姓名" class="form-control"></div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-3">手机号码</div>
        <div class="col-xs-9"><input  id="mobile" name="mobile" type="number" placeholder="请输入11位手机号码" maxlength="11" class="form-control"></div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-3">省份</div>
        <div class="col-xs-9">
            <select class="form-control addressSelect" id="province" name="">
                <option>请选择</option>
            </select>
            <%--<div class="btn-group">--%>
                <%--<button type="button" class="btn btn-default" >广东</button>--%>
                <%--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" >--%>
                    <%--<span class="caret"></span>--%>
                    <%--<span class="sr-only">Toggle Dropdown</span>--%>
                <%--</button>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li>湖南</li>--%>
                    <%--<li>湖南</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-3">城市</div>
        <div class="col-xs-9">
            <select class="form-control addressSelect" id="city" name="">
                <option>请选择</option>
            </select>
            <%--<div class="btn-group">--%>
                <%--<button type="button" class="btn btn-default" >广东</button>--%>
                <%--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">--%>
                    <%--<span class="caret"></span>--%>
                    <%--<span class="sr-only">Toggle Dropdown</span>--%>
                <%--</button>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li>湖南</li>--%>
                    <%--<li>湖南</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-3">地区</div>
        <div class="col-xs-9">
            <select class="addressSelect form-control" id="zone" name="zoneId">
                <option>请选择</option>
            </select>
            <%--<div class="btn-group">--%>
                <%--<button type="button" class="btn btn-default" >广东</button>--%>
                <%--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">--%>
                    <%--<span class="caret"></span>--%>
                    <%--<span class="sr-only">Toggle Dropdown</span>--%>
                <%--</button>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li>湖南</li>--%>
                    <%--<li>湖南</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-3">详细地址</div>
        <div class="col-xs-9">
            <input id="addr" name="addr" class="form-control form-control3" placeholder="请输入详细地址" type="text" maxlength="255" rows="3"/>
        </div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-3">邮政编号</div>
        <div class="col-xs-9"><input   id="zipcode" name="zipcode" type="number" placeholder="请输入邮政编号,可以不填写" maxlength="6" class="form-control"></div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-12">
            <span id="alert" style="padding-left:5px;color:#e00"></span>
            <div class="alert alert-warning sr-only"id="success">!</div>
        </div>
   </div>
    <div class="row m_rows2">
        <div class="col-xs-12">
            <button id="btnAdd" href="javascript:" class="btn btn-danger btn-danger2" type="button">确定</button>
        </div>
    </div>

    <div class="row m_rows2">
        <div class="col-xs-12">
            <button href="javascript:" class="btn btn-danger btn-danger2" type="button" onclick="btnDel('${param.receiveAddrId}');">删除</button>
        </div>
    </div>



</div>
<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始1--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>

</body>
</html>