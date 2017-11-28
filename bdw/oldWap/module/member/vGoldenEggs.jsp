<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="goldenEggsActivity" value="${weixinSdk:getValidActivityByType('2')}"/>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>砸金蛋</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jQueryRotate.2.2.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.easing.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/egg.js"></script>
    <script type="text/javascript">
        var webRoot = "${webRoot}";
        var activityId = ${goldenEggsActivity==null?"":goldenEggsActivity.activityId};
        var luckyDrawActivity = ${!goldenEggsActivity.isOn};
    </script>
</head>

<body <c:if test="${goldenEggsActivity!=null&& not empty goldenEggsActivity}">style="background:#5e0404;"</c:if> >
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=砸金蛋"/>
<%--页头结束--%>

<c:choose>
    <c:when test="${goldenEggsActivity==null||empty goldenEggsActivity}">
        <div class="row" >
            <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin-top:10px;border-radius:5px;color:#999;">暂无活动</div>
        </div>
    </c:when>
    <c:otherwise>
        <div id="hamer_div" class="row zjd_bg" style="position:relative; overflow: hidden;">
            <div class="col-xs-12">
                <canvas id="eggCan"></canvas>
                <div id="rotate_hammer"></div>
                <%--<canvas id="hammerCan"></canvas>--%>
                <canvas id="contCan"></canvas>
                <img id="bombImg" src="${webRoot}/template/bdw/oldWap/statics/images/bomb.png" style="display: none;"/>
                <img id="eggImg" src="${webRoot}/template/bdw/oldWap/statics/images/egg.png" style="display: none;"/>
                <%--<img id="hammerImg" src="${webRoot}/template/jvan/wap/statics/images/hammer.png" style="display: none;"/>--%>
            </div>
            <div class="col-xs-12 b_text" style="text-align: center;color:#FFF;position:absolute;bottom:5px;font-size:18px;font-family:'微软雅黑' " id="remainCount">您还有${goldenEggsActivity.remainCount}次抽奖机会！</div>
        </div>
        <%--<div class="container zjd_box" style="background:none;color:#FFF;margin-top:-28px;">
            <div class="row">
                <div class="col-xs-12 b_text" style="text-align: center;color:#FFF;" id="remainCount">您还有${goldenEggsActivity.remainCount}次抽奖机会！</div>
            </div>
        </div>--%>

        <c:if test="${not empty goldenEggsActivity.desccription}">
            <div class="container zjd_box">
                <div class="row b_info">
                    <div class="col-xs-12 i_title">活动说明：</div>
                    <div class="col-xs-12 i_text">${goldenEggsActivity.desccription}</div>
                </div>
            </div>
        </c:if>

        <div class="container zjd_box">
            <div class="row b_info">
                <div class="col-xs-12 i_title">活动时间：</div>
                <div class="col-xs-12 i_text">活动开始时间：${goldenEggsActivity.startTime}</div>
                <div class="col-xs-12 i_text">活动结束时间：${goldenEggsActivity.endTime}</div>
            </div>
        </div>


        <c:if test="${not empty goldenEggsActivity.trophyDesc}">
            <div class="container zjd_box">
                <div class="row b_info">
                    <div class="col-xs-12 i_title">奖品说明：</div>
                    <div class="col-xs-12 i_text"><pre style="background:none;border:none;padding-top:0;margin-top:0;margin-left: -10px;">${goldenEggsActivity.trophyDesc}</pre></div>
                </div>
            </div>
        </c:if>



        <div class="container zjd_box">
            <div class="row b_info">
                <div class="col-xs-12 i_title">最新10位中奖名单：</div>
                <c:forEach items="${goldenEggsActivity.winnerRecordList}" var="winnerRecord" varStatus="num">
                    <div class="col-xs-12 i_text">${winnerRecord}</div>
                </c:forEach>

            </div>
        </div>

        <div class="container g_popup" id="winner_toggle">
            <div class="row">
                <div class="col-xs-12 p_pic"><img src="${webRoot}/template/bdw/oldWap/statics/images/gjjg.png" width="270" height="75"></div>
            </div>
            <div class="row">
                <div class="col-xs-12 p_title" id="winnerWarnStr"></div>
            </div>
            <div class="row">
                <div class="col-xs-12"><a href="javascript:void(0);" onclick="reloadGoldenEggs();" class="btn btn-primary bd_btn btn-block p_btn" role="button">继续抽奖</a></div>
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
