<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="luckyDrawActivity" value="${weixinSdk:getValidActivityByType('0')}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>大转盘</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jQueryRotate.2.2.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.easing.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script type="text/javascript">
        var webRoot = "${webRoot}";
        var luckyDrawActivity = ${!luckyDrawActivity.isOn};
        var activityId = ${luckyDrawActivity==null?"":luckyDrawActivity.activityId};
        var pN_value = ${luckyDrawActivity==null?0:luckyDrawActivity.trophyCount};
        var tx_value =
                [
                    <c:if test="${luckyDrawActivity!=null}">
                       <c:forEach items="${luckyDrawActivity.torphyNameList}" var="torphyName" varStatus="num">
                          "${torphyName}"<c:if test="${!num.last}">,</c:if>
                       </c:forEach>
                    </c:if>
                ];

        function reloadLuckyDraw(){
            window.location.href = webRoot + "/wap/module/member/vLuckyDraw.ac?time="+new Date().getTime;
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/rrscript.js"></script>
</head>

<body <c:if test="${luckyDrawActivity!=null&& not empty luckyDrawActivity}">style="background:#8e130b;"</c:if>>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=幸运大转盘"/>
<%--页头结束--%>

<c:choose>
    <c:when test="${luckyDrawActivity==null||empty luckyDrawActivity}">
        <div class="row" >
            <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin-top:10px;border-radius:5px;color:#999;">暂无活动</div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row dzp_bg">
            <div class="col-xs-12" style="position: relative;">
                <div id="borderImg"></div>
                <canvas id="myCanvas"></canvas>
                <div id="rotate_pointer"></div>
            </div>
            <div class="col-xs-12 d_text" id="remainCount">您还有${luckyDrawActivity.remainCount}次抽奖机会</div>
        </div>

        <c:if test="${not empty luckyDrawActivity.desccription}">
            <div class="container dzp_box">
                <div class="row">
                    <div class="col-xs-12 b_title"><i>活动说明：</i></div>
                </div>
                <div class="row">
                    <div class="col-xs-12 b_text">${luckyDrawActivity.desccription}</div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 b_icon"></div>
            </div>
        </c:if>


        <div class="container dzp_box">
            <div class="row">
                <div class="col-xs-12 b_title"><i>活动时间：</i></div>
            </div>
            <div class="row">
                <div class="col-xs-12 b_text" >活动开始时间：${luckyDrawActivity.startTime}</div>
            </div>
            <div class="row">
                <div class="col-xs-12 b_text" >活动结束时间：${luckyDrawActivity.endTime}</div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 b_icon"></div>
        </div>


        <c:if test="${not empty luckyDrawActivity.trophyDesc}">
            <div class="container dzp_box">
                <div class="row">
                    <div class="col-xs-12 b_title"><i>奖品说明：</i></div>
                </div>
                <div class="row">
                    <div class="col-xs-12 b_text"><pre style="background:none;border:none;padding-top:0;margin-top:0;margin-left: -10px;">${luckyDrawActivity.trophyDesc}</pre></div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 b_icon"></div>
            </div>
        </c:if>



        <div class="container dzp_box">
            <div class="row">
                <div class="col-xs-12 b_title"><i>最新10位中奖名单：</i></div>
            </div>
            <c:forEach items="${luckyDrawActivity.winnerRecordList}" var="winnerRecord" varStatus="num">
                <div class="row">
                    <div class="col-xs-12 b_text">${winnerRecord}</div>
                </div>
            </c:forEach>
        </div>
        <div class="row">
            <div class="col-xs-12 b_icon"></div>
        </div>

        <div class="container g_popup" id="winner_toggle" style="display:none;">
            <div class="row">
                <div class="col-xs-12 p_pic"><img src="${webRoot}/template/bdw/oldWap/statics/images/gjjg.png" width="270" height="75"></div>
            </div>
            <div class="row">
                <div class="col-xs-12 p_title" id="winnerWarnStr"></div>
            </div>
            <div class="row" id="continueDraw">
                <div class="col-xs-12"><a href="javascript:void(0);" onclick="reloadLuckyDraw();" class="btn btn-primary bd_btn btn-block p_btn" role="button">继续抽奖</a></div>
            </div>
            <div class="row" id="getTrophy" style="display:none;">
                <div class="col-xs-12"><a href="${webRoot}/wap/module/member/myTrophy.ac" class="btn btn-primary bd_btn btn-block p_btn" role="button">领取奖品</a></div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<div class="row">
    <div class="col-xs-12 cklj"><a href="${webRoot}/wap/module/member/myTrophy.ac"><img src="${webRoot}/template/bdw/oldWap/statics/images/cklj.png"></a></div>
</div>

<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/easydialog/easydialog.js"></script>
<link href="${webRoot}/template/bdw/oldWap/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/draw.js"></script>
</body>
</html>
