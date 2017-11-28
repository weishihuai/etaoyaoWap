<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${sdk:findAllOrder(loginUser.userId,1,5)}" var="orderProxyPage"/> <%--获取当前用户的前5条订单--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-活动专区-${sdk:getSysParamValue('index_title')}</title>  <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/statics/css/activityZone.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
        $(function(){
            $('#roteAdv').after("<div class='mub'><ul id='nav'>").cycle({
                fx:     'scrollLeft',
                speed:  'fast',
                timeout: 5000,
                pager:  '#nav',
                before: function() { if (window.console) console.log(this.src); },
                pagerAnchorBuilder:function(index,slide){
                    var count=index+1;
                    if(index==0){
                        return '<li><a href="javascript:;" id="c'+count+'" class="cur">'+count+'</a></li>'
                    }else{
                        return '<li><a href="javascript:;" id="c'+count+'">'+count+'</a></li>'
                    }
                },
                after:function(currSlideElement, nextSlideElement, options, forwardFlag){
                    var a= $("#nav").find("a").attr("class","");
                    $("#c"+nextSlideElement.id).attr("class","cur");
                }
            });
        })
    </script>
</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=activityZone"/>
<%--头部 end--%>

<!--main-->
<div id="main">
    <div class="m1">
        <div class="m1-l">
            <div class="box">
                <h2><a href="#">热门品牌</a></h2>
                <div class="ubox">
                    <c:forEach begin="1" end="12" varStatus="row">
                        <c:set var="strAdv" value="jvan_activity_remen_adv${row.count}"/>
                        <div class="advLi frameEdit"  frameInfo="${strAdv}|85X60">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="85px" height="60px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <div class="m1-r frameEdit"  frameInfo="jvan_activity_lunhuan_adv|700X280">
            <div id="roteAdv" style="width: 700px;height: 280px">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_lunhuan_adv').advt.advtProxy}" var="advtProxys" varStatus="s" >
                    <a target="_blank" id="${s.count}" href="${advtProxys.link}" title="${advtProxys.title}">
                        <img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="700px" height="280px" />
                    </a>
                </c:forEach>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <%--F1--%>
    <div class="m2">
        <%--tab--%>
        <div class="layer frameEdit" frameInfo="jvan_activity_custom_tab1">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_custom_tab1').links}" var="adv" end="0" varStatus="s">
                <a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}<span>${adv.description}</span></a>
            </c:forEach>
        </div>
        <%--adv--%>
        <div class="box">
            <%--left_adv--%>
            <div class="box-l frameEdit" frameInfo="jvan_activity_F1_left_adv|210X300">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F1_left_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                        <img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="210px" height="300px" />
                    </a>
                </c:forEach>
            </div>
            <%--right_adv--%>
            <div class="box-r">
                <div class="f1-r1">
                    <c:forEach begin="1" end="2" varStatus="row">
                        <c:set var="strAdv1" value="jvan_activity_F1_right_adv${row.count}"/>
                        <div class="f1-r1-t frameEdit"  frameInfo="${strAdv1}|180X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv1).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="180px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                    <div class="f1-r1-b frameEdit"  frameInfo="jvan_activity_F1_right_adv3|360X150">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F1_right_adv3').advt.advtProxy}" var="adv" varStatus="s" end="0">
                            <a target="_blank" href="${adv.link}" title="${adv.title}">
                                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="360px" height="150px"/>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="f1-r2">
                    <c:forEach begin="4" end="5" varStatus="row">
                        <c:set var="strAdv2" value="jvan_activity_F1_right_adv_c_${row.count}"/>
                        <div class="f1-r2-all frameEdit"  frameInfo="${strAdv2}|180X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv2).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="180px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <div class="f1-r3">
                    <c:forEach begin="6" end="7" varStatus="row">
                        <c:set var="strAdv3" value="jvan_activity_F1_right_adv_r_${row.count}"/>
                        <div class="f1-r3-all frameEdit"  frameInfo="${strAdv3}|230X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv3).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="230px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="f-long-adv frameEdit" frameInfo="jvan_activity_F1_long_adv|980X90">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F1_long_adv').advt.advtProxy}" var="adv" varStatus="s" end="0">
            <a target="_blank" href="${adv.link}" title="${adv.title}">
                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="980px" height="90px"/>
            </a>
        </c:forEach>
    </div>
    <div class="clear"></div>

    <%--F2--%>
    <div class="m2">
        <%--tab--%>
        <div class="layer frameEdit" frameInfo="jvan_activity_custom_tab2">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_custom_tab2').links}" var="adv" end="0" varStatus="s">
                <a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}<span>${adv.description}</span></a>
            </c:forEach>
        </div>
        <%--adv--%>
        <div class="box">
            <%--left_adv--%>
            <div class="box-l frameEdit" frameInfo="jvan_activity_F2_left_adv|210X300">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F2_left_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                        <img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="210px" height="300px" />
                    </a>
                </c:forEach>
            </div>
            <%--right_adv--%>
            <div class="box-r">
                <div class="f2-r1">
                    <c:forEach begin="1" end="6" varStatus="row">
                        <c:set var="strAdv4" value="jvan_activity_F2_right_adv${row.count}"/>
                        <div class="f2-r1-all frameEdit"  frameInfo="${strAdv4}|180X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv4).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="180px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <div class="f2-r2">
                    <c:forEach begin="7" end="9" varStatus="row">
                        <c:set var="strAdv5" value="jvan_activity_F2_right_adv_r_${row.count}"/>
                        <div class="f2-r2-all frameEdit"  frameInfo="${strAdv5}|230X100">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv5).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="230px" height="100px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="f-long-adv frameEdit" frameInfo="jvan_activity_F2_long_adv|980X90">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F2_long_adv').advt.advtProxy}" var="adv" varStatus="s" end="0">
            <a target="_blank" href="${adv.link}" title="${adv.title}">
                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="980px" height="90px"/>
            </a>
        </c:forEach>
    </div>
    <div class="clear"></div>

    <%--F3--%>
    <div class="m2">
        <%--tab--%>
        <div class="layer frameEdit" frameInfo="jvan_activity_custom_tab3">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_custom_tab3').links}" var="adv" end="0" varStatus="s">
                <a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}<span>${adv.description}</span></a>
            </c:forEach>
        </div>
        <%--adv--%>
        <div class="box">
            <%--left_adv--%>
            <div class="box-l frameEdit" frameInfo="jvan_activity_F3_left_adv|210X300">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F3_left_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                        <img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="210px" height="300px" />
                    </a>
                </c:forEach>
            </div>
            <%--right_adv--%>
            <div class="box-r">
                <div class="f3-r1">
                    <c:forEach begin="1" end="2" varStatus="row">
                        <c:set var="strAdv6" value="jvan_activity_F3_right_adv${row.count}"/>
                        <div class="f3-r1-all frameEdit"  frameInfo="${strAdv6}|360X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv6).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="360px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <div class="f3-r2">
                    <c:forEach begin="3" end="4" varStatus="row">
                        <c:set var="strAdv7" value="jvan_activity_F3_right_adv_c_${row.count}"/>
                        <div class="f3-r2-all frameEdit"  frameInfo="${strAdv7}|180X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv7).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="180px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <div class="f3-r3">
                    <c:forEach begin="5" end="6" varStatus="row">
                        <c:set var="strAdv8" value="jvan_activity_F3_right_adv_r_${row.count}"/>
                        <div class="f3-r3-all frameEdit"  frameInfo="${strAdv8}|230X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv8).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="230px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="f-long-adv frameEdit" frameInfo="jvan_activity_F3_long_adv|980X90">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F3_long_adv').advt.advtProxy}" var="adv" varStatus="s" end="0">
            <a target="_blank" href="${adv.link}" title="${adv.title}">
                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="980px" height="90px"/>
            </a>
        </c:forEach>
    </div>
    <div class="clear"></div>

    <%--F4--%>
    <div class="m2">
        <%--tab--%>
        <div class="layer frameEdit" frameInfo="jvan_activity_custom_tab4">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_custom_tab4').links}" var="adv" end="0" varStatus="s">
                <a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}<span>${adv.description}</span></a>
            </c:forEach>
        </div>
        <%--adv--%>
        <div class="box">
            <div class="box-l frameEdit" frameInfo="jvan_activity_F4_left_adv|210X300">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F4_left_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <a target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                        <img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="210px" height="300px" />
                    </a>
                </c:forEach>
            </div>
            <div class="box-r">
                <div class="f4-r1 f4-c">
                    <c:forEach begin="1" end="3" varStatus="row">
                        <c:set var="strAdv9" value="jvan_activity_F4_right_adv${row.count}"/>
                        <div class="f4-r1-all frameEdit"  frameInfo="${strAdv9}|180X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv9).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="180px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                    <div class="f4-r-all frameEdit" frameInfo="jvan_activity_F4_right_adv4|230X150">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F4_right_adv4').advt.advtProxy}" var="adv" varStatus="s" end="0">
                            <a target="_blank" href="${adv.link}" title="${adv.title}">
                                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="230px" height="150px"/>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="f4-r2 f4-c">
                    <div class="f4-r-all frameEdit" frameInfo="jvan_activity_F4_right_adv5|230X150">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F4_right_adv5').advt.advtProxy}" var="adv" varStatus="s" end="0">
                            <a target="_blank" href="${adv.link}" title="${adv.title}">
                                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="230px" height="150px"/>
                            </a>
                        </c:forEach>
                    </div>
                    <c:forEach begin="6" end="8" varStatus="row">
                        <c:set var="strAdv10" value="jvan_activity_F4_right_adv_b_${row.count}"/>
                        <div class="f4-r2-all frameEdit"  frameInfo="${strAdv10}|180X150">
                            <c:forEach items="${sdk:findPageModuleProxy(strAdv10).advt.advtProxy}" var="adv" varStatus="s" end="0">
                                <a target="_blank" href="${adv.link}" title="${adv.title}">
                                    <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="180px" height="150px"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="f-long-adv frameEdit" frameInfo="jvan_activity_F4_long_adv|980X90">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_activity_F4_long_adv').advt.advtProxy}" var="adv" varStatus="s" end="0">
            <a target="_blank" href="${adv.link}" title="${adv.title}">
                <img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="980px" height="90px"/>
            </a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
