<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="scratchCardActivity" value="${weixinSdk:getValidActivityByType('1')}"/>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>刮刮卡</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/wScratchPad.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/ggk.js"></script>
    <script type="text/javascript">
        var webRoot = "${webRoot}";
        var activityId = ${scratchCardActivity==null?"":scratchCardActivity.activityId};
        var luckyDrawActivity = ${!scratchCardActivity.isOn};
    </script>
</head>


<body style="<c:if test="${scratchCardActivity!=null && not empty scratchCardActivity}">background:#8e130b;</c:if> padding-bottom: 20px;">
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=刮刮卡"/>
<%--页头结束--%>

<c:choose>
    <c:when test="${scratchCardActivity==null||empty scratchCardActivity}">
        <div class="row" >
            <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin-top:10px;border-radius:5px;color:#999;">暂无活动</div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row">
            <div class="col-xs-12" style="text-align:center;"><img src="${webRoot}/template/bdw/oldWap/statics/images/gg_pic.png"></div>
        </div>
        <div class="row" style="background:url(${webRoot}/template/bdw/oldWap/statics/images/gj_bg.png) no-repeat; width:290px; height:93px; margin:0 auto; position:relative;">
            <div class="col-xs-12"> <div id="trophy" style="position:absolute;width:290px; top:20px; font-size:35px; text-align:center;"></div></div>
            <div class="col-xs-12">
                <div <c:if test="${scratchCardActivity.remainCount>0}">id="wScratchPad3"</c:if> style="display:inline-block; position:absolute; left:5px; top:5px;"></div>
            </div>
        </div>
        <div class="container g_box">
            <div class="row">
                <div class="col-xs-12 b_text" style="text-align: center;color:#F6CC70;" id="remainCount">您还有${scratchCardActivity.remainCount}次抽奖机会！</div>
            </div>
        </div>

        <c:if test="${not empty scratchCardActivity.desccription}">
            <div class="container g_box">
                <div class="row">
                    <div class="col-xs-12"><i class="b_icon">活动说明：</i></div>
                </div>
                <div class="row">
                    <div class="col-xs-12 b_text">${scratchCardActivity.desccription}</div>
                </div>
            </div>
        </c:if>

        <div class="container g_box">
            <div class="row">
                <div class="col-xs-12"><i class="b_icon">活动时间：</i></div>
            </div>
            <div class="row">
                <div class="col-xs-12 b_text" style="color: #FFF;">活动开始时间：${scratchCardActivity.startTime}</div>
            </div>
            <div class="row">
                <div class="col-xs-12 b_text" style="color: #FFF;">活动结束时间：${scratchCardActivity.endTime}</div>
            </div>
        </div>

        <c:if test="${not empty scratchCardActivity.trophyDesc}">
            <div class="container g_box">
                <div class="row">
                    <div class="col-xs-12"><i class="b_icon">奖品说明：</i></div>
                </div>
                <div class="row">
                    <div class="col-xs-12 b_text"><pre style="background:none;border:none;padding-top:0;margin-top:0;margin-left: -10px;">${scratchCardActivity.trophyDesc}</pre></div>
                </div>
            </div>
        </c:if>


        <div class="container g_box">
            <div class="row">
                <div class="col-xs-12"><i class="b_icon">最新中奖：</i></div>
            </div>
            <c:forEach items="${scratchCardActivity.winnerRecordList}" var="winnerRecord" varStatus="num">
                <div class="row">
                    <div class="col-xs-12 b_text">${winnerRecord}</div>
                </div>
            </c:forEach>
        </div>

        <div class="container g_popup" id="winner_toggle">
            <div class="row">
                <div class="col-xs-12 p_pic"><img src="${webRoot}/template/bdw/oldWap/statics/images/gjjg.png" width="270" height="75"></div>
            </div>
            <div class="row">
                <div class="col-xs-12 p_title" id="winnerWarnStr"></div>
            </div>
            <div class="row">
                <div class="col-xs-12"><a href="javascript:void(0);" onclick="reload();" class="btn btn-primary bd_btn btn-block p_btn" role="button">继续抽奖</a></div>
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
