<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="otooProductProxy" value="${bdw:getOtooProductById(param.id)}"/>
<c:if test="${empty otooProductProxy || otooProductProxy.otooIsOnSale == 'N'}">
    <c:redirect url="/otoo/index.ac"></c:redirect>
</c:if>
<%--取分类--%>
<c:set var="otooCategoryProxy" value="${otooProductProxy.otooCategoryProxy}"/>
<%--店铺信息--%>
<c:set value="${sdk:getShopInfProxyById(otooProductProxy.shopInfId)}" var="shopInf"/>
<%--<c:set value="${sdk:getShopUser(otooProductProxy.shopInfId)}" var="shopUser"/>--%>
<%--取出商品属性--%>
<c:set var="attrDicList" value="${otooProductProxy.dicValues}"/>
<c:set var="attrDicMap" value="${otooProductProxy.dicValueMap}"/>
<c:set var="attrGroupProxyList" value="${otooProductProxy.attrGroupProxyList}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${bdw:findCommentPageByProductId(param.id,5)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>


<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>${otooProductProxy.otooProductNm}-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/base.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/groupo-detail.css" rel="stylesheet" type="text/css"/>
    <%--<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />--%>
    <link href="${webRoot}/template/bdw/otoo/statics/js/baiduMap/SearchInfoWindow_min.css" rel="stylesheet"/>


    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=EBQree22ojdUD9SDUm2rXRkN"></script>
    <%--<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/baiduMap/SearchInfoWindow_min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scrollimage.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}",productId:"${param.id}",userId:"${loginUser.userId}",userMobile:"${loginUser.mobile}"};
        var COOKIE_NAME = 'ProductHistory'+${otooProductProxy.otooProductId};
        if(!$.cookie(COOKIE_NAME) ){
            $.cookie(COOKIE_NAME, ${otooProductProxy.otooProductId} , { path: '/', expires: (60 * 60 * 24 * 365 * 1) });
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/product.js"></script>
</head>


<body>
<%-- header start --%>
<c:import url="/template/bdw/otoo/common/top.jsp?p=detail"/>
<%-- header end --%>

<div class="main">
    <div class="crumb">
        <a href="${webRoot}/otoo/index.ac" title="首页">首页</a>&gt;
        <c:forEach items="${otooCategoryProxy.categoryTree}" var="category" varStatus="stats" begin="1">
            <c:choose>
                <c:when test="${stats.last}">
                    <span><a href="${webRoot}/otoo/productList.ac?categoryId=${category.categoryId}">${category.categoryName}</a></span>
                </c:when>
                <c:otherwise>
                    <a href="${webRoot}/otoo/productList.ac?categoryId=${category.categoryId}" title="${category.categoryName}">${category.categoryName}</a>&gt;
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

    <div class="left">
        <div class="pro-intro">
            <div class="preview fl">
                <%--大图--%>
                <div class="spec-main">
                    <a href="javascript:" title="${otooProductProxy.otooProductNm}" style="cursor:default">
                        <img id="bigsrc" src="${otooProductProxy.defaultImage['352X235']}" title="${otooProductProxy.otooProductNm}" alt='${otooProductProxy.otooProductNm}' border="0" />
                    </a>
                </div>

                <%--小图--%>
                <div class="spec-list" >
                    <div><a class="pre" href="javascript:" id="turnL" title="">&lt;</a></div>
                    <ul id="mycarousel">
                        <c:forEach varStatus="s" items="${otooProductProxy.images}" var="image">
                            <li>
                                <a href="javascript:" class='productImgClass' bigImgData="${image['352X235']}" title="${otooProductProxy.otooProductNm}">
                                    <img src="${image['90X60']}" title="${otooProductProxy.otooProductNm}" alt='${otooProductProxy.otooProductNm}'/>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <div><a class="next" href="javascript:" id="turnR" title="">&gt;</a></div>
                </div>


                <!--spec-list end-->
                <div class="short-share">
                    <div style="margin-left: 10px;float:left;">
                        <div class="bdsharebuttonbox" style="margin-top:7px;"><a href="javascript:" class="bds_more" data-cmd="more"></a><a title="分享到QQ空间" href="javascript:" class="bds_qzone" data-cmd="qzone"></a><a title="分享到新浪微博" href="javascript:" class="bds_tsina" data-cmd="tsina"></a><a title="分享到腾讯微博" href="javascript:" class="bds_tqq" data-cmd="tqq"></a><a title="分享到人人网" href="javascript:" class="bds_renren" data-cmd="renren"></a><a title="分享到微信" href="javascript:" class="bds_weixin" data-cmd="weixin"></a></div>
                        <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
                    </div>
                    <div style="margin-left: 10px; float: left">
                        <a class="col" href="javascript:void(0);" onclick="collectOtooProduct();">收藏商品</a>
                    </div>
                </div>

                <div class="clear"></div>
            </div>
            <!--preview end-->
            <div class="detail fl">
                <p class="p-name">${otooProductProxy.otooProductNm}</p>

                <p class="p-desc">${otooProductProxy.otooSellingPoint}</p>

                <p class="c-price">
                    <span class="label">优惠价</span>
                    <span class="val"><i>&yen;</i>${otooProductProxy.otooDiscountPrice}</span>
                </p>

                <p class="o-price">
                    <span class="label">市场价</span>
                    <span class="val">&yen;${otooProductProxy.otooMarketPrice}</span>
                </p>

                <p class="evaluate">
                    <span class="label">商品评价</span>
                        <c:choose>
                            <c:when test="${otooProductProxy.total>0}">
                                <span class="star-back">
                                    <i style="width: ${otooProductProxy.commentStatistics.average/5*100}%"></i>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span style="color:red">暂无人评价</span>
                            </c:otherwise>
                        </c:choose>
                    <a href="#comment" class="disComment">(共有${otooProductProxy.total}条评价）</a>
                </p>

                <p class="date">
                    <span class="label">有效日期</span>
                    <span class="val">
                        <i>截止到&nbsp;<fmt:formatDate value="${otooProductProxy.otooCouponEndTime}" pattern="yyyy-MM-dd"/></i>
                        <%--可退款截止日期&nbsp;<fmt:formatDate value="${otooProductProxy.otooRefundEndTime}" pattern="yyyy-MM-dd"/>--%>
                    </span>
                </p>

                <c:choose>
                    <c:when test="${otooProductProxy.otooProductStock<=0}">
                        <%--库存不足--%>
                        <div class="buy">
                            <a class="noProductBtn" href="javascript:void(0);" style="cursor:default">库存不足</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="buy">
                            <span class="label">购买数量</span>
                            <div class="num">
                                <a href="javascript:void(0);" class="prd_subNum jian"></a>
                                <input type="text" value="1" class="prd_num"/>
                                <a href="javascript:void(0);" class="prd_addNum jia"></a>
                            </div>
                            <span class="label">库存${otooProductProxy.otooProductStock}件</span>
                            <a class="btn" href="javascript:void(0);" id="buyBtn">立即购买</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="tit-trigger" id="toggleTab" style="z-index:9999">
            <a class="cur address" href="#address">商家位置</a>
            <a class="buy" href="#buy">购买须知</a>
            <a class="productDetail" href="#productDetail">商品详情</a>
            <a class="introduce" href="#introduce">商家介绍</a>
            <a class="comment" href="#comment">消费评论（<em>${otooProductProxy.total}</em>）</a>
        </div>
        <!--tit-trigger end-->

        <%--百度地图-大图--%>
        <div id="allmapFullDiv" style="width: 1200px; height: 700px;display: none;"></div>
        <input type="hidden" name="baiduMapXAxis" id="baiduMapXAxis" value="${shopInf.baiduMapXAxis}"/>
        <input type="hidden" name="baiduMapYAxis" id="baiduMapYAxis" value="${shopInf.baiduMapYAxis}"/>
        <input type="hidden" name="baiduMapLocationShopTitle" id="baiduMapLocationShopTitle" value="${shopInf.shopNm}"/>
        <input type="hidden" name="baiduMapLocationShopAddr" id="baiduMapLocationShopAddr" value="${shopInf.shopAddr}"/>


        <div class="con01" id="address">
            <h3>商家位置</h3>
            <div class="inner">
                <div class="mapBaidu">
                    <div style="height: 280px;width: 420px;" id="smallMapDiv"></div>

                    <div class="view">
                        <a href="javascript:" title="" id="showFullBaiduMapBtn">查看完整地图</a>
                    </div>
                </div>
                <div class="intro">
                    <div class="name">${shopInf.shopNm}</div>
                    <ul>
                        <li class="li01">消费评价：<i>${otooProductProxy.total}</i>人评价</li>
                       <c:if test="${not empty shopInf.tel}"> <li class="li02">门市电话：<i>${shopInf.tel}</i></li></c:if>
                        <li class="li03">商家手机：${shopInf.mobile}</li>
                        <li class="li04">店铺地址：${shopInf.shopAddr}</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="con02" id="buy">
            <h3>购买须知</h3>
            <div class="inner">
                <ul>
                    <c:if test="${not empty attrGroupProxyList}">
                        <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                            <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                    <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                        <li>
                                            <span class="label">${attrDict.name}</span>
                                            <span class="val">${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}</span>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        </div>

        <%--商品详情start--%>
        <div class="r_infobox" id="productDetail">
            <h3>商品详情</h3>
            <div class="b_adv">${not empty otooProductProxy.description ? (otooProductProxy.description) : ''}</div>
        </div>
        <%--商品详情end--%>

        <div class="con03">
            <h3 id="introduce">商家介绍</h3>
            <div class="inner">
                <div class="i-tit shopName">${shopInf.shopNm}</div>
                <p class="productDescr">
                    ${shopInf.shopDescrStr}
                </p>

                <div class="con pro-comment" id="comment">
                    <div class="comment">
                        <div class="rate">
                            <c:choose>
                                <c:when test="${otooProductProxy.total>0}">
                                    <span class="star-back">
                                        <i style="width: ${otooProductProxy.commentStatistics.average/5*100}%"></i>
                                    </span>
                                    <br>
                                    <span>共有${otooProductProxy.total}人评论</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:red">暂无人评价</span>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div class="percent">
                            <dl>
                                <dt>好评</dt>
                                <dd class="p-box">
                                    <div style="width:${otooProductProxy.goodRate};"></div>
                                </dd>
                                <dd class="p-num">${otooProductProxy.goodRate}</dd>
                            </dl>
                            <dl>
                                <dt>中评</dt>
                                <dd class="p-box">
                                    <div style="width:${otooProductProxy.normalRate};"></div>
                                </dd>
                                <dd class="p-num">${otooProductProxy.normalRate}</dd>
                            </dl>
                            <dl>
                                <dt>差评</dt>
                                <dd class="p-box">
                                    <div style="width:${otooProductProxy.badRate};"></div>
                                </dd>
                                <dd class="p-num">${otooProductProxy.badRate}</dd>
                            </dl>
                        </div>
                        <div class="btn">
                            <%--<div class="d-01">评论获积分</div>--%>
                            <%--<div class="d-02">已购买过本产品的会员发表商品评价，获得积分奖励。</div>--%>
                            <%--<a class="a-btn" href="javascript:void(0)">发表评论</a>--%>
                            <a class="a-all" href="${webRoot}/otoo/productComment.ac?id=${otooProductProxy.otooProductId}">查看所有评论</a>
                        </div>
                    </div>
                    <%--评论星级:2分5颗星,1分显示4颗星,以此类推--%>
                    <c:if test="${commentProxyPage.totalCount>0}">
                        <div class="com-list">
                            <c:forEach items="${commentProxyResult}" var="commentProxy">
                                <div class="item item01">
                                    <div class="i-name">${commentProxy.userName}
                                        <i class="star-back">
                                            <c:if test="${commentProxy.totalScore == 2}">
                                                <i style="width:100%"></i>
                                            </c:if>
                                            <c:if test="${commentProxy.totalScore == 1}">
                                                <i style="width:80%"></i>
                                            </c:if>
                                            <c:if test="${commentProxy.totalScore == 0}">
                                                <i style="width:60%"></i>
                                            </c:if>
                                            <c:if test="${commentProxy.totalScore == -1}">
                                                <i style="width:40%"></i>
                                            </c:if>
                                            <c:if test="${commentProxy.totalScore == -2}">
                                                <i style="width:20%"></i>
                                            </c:if>
                                        </i>
                                    </div>
                                    <div class="c-con">
                                        <span class="fl">${commentProxy.content}</span>
                                        <span class="fr">${commentProxy.createTimeString}</span>
                                    </div>
                                    <!--  <div class="reply">管理员回复：感谢您对我们商城的支持！</div> -->
                                </div>
                            </c:forEach>
                            </div>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <div class="right" id="topMenu" style="z-index: 1">
        <h3>最近浏览<a href="javascript:" class="fr" style="font-size: 12px;color:red;margin-right: 4px;" onclick="clearHistoryProductsCookie();"><img src="${webRoot}/template/bdw/otoo/statics/images/rubbish.png" title="清空" style="margin-top: 20px; margin-right: 20px;"></a></h3>
        <c:set value="${bdw:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
            <c:choose>
                <c:when test="${not empty productFromCookies}">
                    <ul>
                    <c:forEach items="${productFromCookies}" var="product" end="5">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" title=""><img src="${product.defaultImage['120X80']}" alt="${product.otooProductNm}"></a>
                            <div class="p-info">
                                <a class="p-name" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="">${product.otooProductNm}</a>
                                <p>${product.otooSellingPoint}</p>
                                <span class="c-price">&yen;${product.otooDiscountPrice}</span>
                                <span class="o-price"><del>&yen;${product.otooMarketPrice}</del></span>
                            </div>
                        </li>
                    </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div style="margin-top: 16px; margin-bottom: 16px;text-align: center;color:red">你还未浏览其他商品</div>
                </c:otherwise>
            </c:choose>
    </div>
    <div class="clear"></div>
</div>

<%--商品收藏-弹出层 --%>
<div class="AddTomyLikeLayer" style="display:none;" id="collectProduct">
    <div class="showTip">
        <div class="close"><a href="javascript:" onclick="hideLayer();"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
        <div class="succe">
            <h3>商品已成功收藏！</h3>
            <div class="tips"><a href="${webRoot}/module/member/otoo/otooCollection.ac?pitchOnRow=49" target="_blank" onclick="hideLayer();">查看收藏夹</a></div>
        </div>
    </div>
</div>


<c:if test="${fn:length(otooProductProxy.images)>3}">
    <script type="text/javascript">
        var scrollPic_02 = new ScrollPic();
        scrollPic_02.scrollContId   = "mycarousel"; //内容容器ID
        scrollPic_02.arrLeftId      = "turnL";//左箭头ID
        scrollPic_02.arrRightId     = "turnR"; //右箭头ID
        scrollPic_02.frameWidth     = 282;//装图片的总容器宽度(容器大小不一样,这个经常改)
        scrollPic_02.pageWidth      = 99; //翻页宽度(翻阅一张图片的宽度,根据图片大小不同而调整,一般是一张图片的宽度加上两张图片的间距的数值,也可以翻阅多张,比如我要一下子翻阅4张,则是220X4=880即可.)
        scrollPic_02.speed          = 10; //移动速度(单位毫秒，越小越快)
        scrollPic_02.space          = 10; //每次移动像素(单位px，越大越快)
        scrollPic_02.autoPlay       = false; //自动播放
        scrollPic_02.autoPlayTime   = 5; //自动播放间隔时间(秒)
        scrollPic_02.initialize(); //初始化
    </script>
</c:if>

<script type="text/javascript">


    var smallMap = new BMap.Map("smallMapDiv");//设置小地图容器
    var x_value_smallMap = document.getElementById("baiduMapXAxis").value;
    var Y_value_smallMap = document.getElementById("baiduMapYAxis").value;

    var point_smallMap = new BMap.Point(x_value_smallMap, Y_value_smallMap);
    smallMap.centerAndZoom(point_smallMap, 15);

    smallMap.enableDragging();
    var marker_smallMap = new BMap.Marker(new BMap.Point(x_value_smallMap, Y_value_smallMap));
    smallMap.addOverlay(marker_smallMap);

    //======================================================
    var fullMap = new BMap.Map("allmapFullDiv");//设置大地图容器

    //把店铺的原来值设置到这里即可
    //根据坐标设置地图中心点
    var x_value_fullMap = document.getElementById("baiduMapXAxis").value;
    var Y_value_fullMap = document.getElementById("baiduMapYAxis").value;
    
    var baiduMapLocationShopTitleValue = document.getElementById("baiduMapLocationShopTitle").value;
    var baiduMapLocationShopAddrValue = document.getElementById("baiduMapLocationShopAddr").value;


    var point_fullMap = new BMap.Point(x_value_fullMap, Y_value_fullMap);//设置地图中心点位置
    fullMap.centerAndZoom(point_fullMap, 15);//设置放大级别

    fullMap.enableScrollWheelZoom(true);//支持鼠标滚轮放大、缩小地图

    fullMap.enableDragging();

    //添加工具条和比例尺
    var top_left_control_fullMap = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
    var top_left_navigation_fullMap = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
    var top_right_navigation_fullMap = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮
    fullMap.addControl(top_left_control_fullMap);
    fullMap.addControl(top_left_navigation_fullMap);
    fullMap.addControl(top_right_navigation_fullMap);

    //把店铺的原来值设置到这里即可
    var marker_fullMap = new BMap.Marker(new BMap.Point(x_value_fullMap, Y_value_fullMap)); // 创建点标注
    fullMap.addOverlay(marker_fullMap);    //将标注添加到地图中
    fullMap.panBy(605, 335);//在常见浏览器下,弹出显示层,标记不会居中,所以用移位来处理.

    //创建检索信息窗口对象
    var searchInfoWindow = null;
    searchInfoWindow = new BMapLib.SearchInfoWindow(fullMap, baiduMapLocationShopAddrValue, {
        title: baiduMapLocationShopTitleValue,      //标题
        width: 290,             //宽度
        height: 105,              //高度
        panel: "panel",         //检索结果面板
        enableAutoPan: true,     //自动平移
        searchTypes: [
            BMAPLIB_TAB_SEARCH,   //周边检索
            BMAPLIB_TAB_TO_HERE,  //到这里去
            BMAPLIB_TAB_FROM_HERE //从这里出发
        ]
    });
    marker_fullMap.addEventListener("click", function (e) {
        searchInfoWindow.open(marker_fullMap);
    })
</script>


<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1338866268911669" charset="utf-8"></script>
<!--main end-->
<c:import url="/template/bdw/otoo/common/bottom.jsp?p=index"/>
<!-- footer end-->
</body>
</html>
