<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}" /> <%--SEO description优化--%>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/newDetails.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
</head>


<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=detail"/>
<%--页头结束--%>

<%--页面内容 start--%>
<div class="d-main-bg">
<div class="past-bg">
    <div class="past">
        <a href="#">首页</a>
        >
        <a href="#">食品饮品</a>
        >
        <a href="#">健康保健</a>
        >
        伊敦娜果大豆卵磷脂软胶囊 60粒/瓶
    </div>
</div>
<div class="detail-bg">
    <div class="detail">
        <div class="info-left">
            <div class="b-pic"><img src="${webRoot}/template/bdw/statics/case/detail-01.jpg" alt="#" width="360" height="360" /></div>
            <div class="s-pic">
                <div class="last"><a href="#"></a></div>
                <div class="s-pic-box">
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-02.jpg" alt="#" width="40" height="40" /></a>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-02.jpg" alt="#" width="40" height="40" /></a>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-02.jpg" alt="#" width="40" height="40" /></a>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-02.jpg" alt="#" width="40" height="40" /></a>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-02.jpg" alt="#" width="40" height="40" /></a>
                </div>
                <div class="next"><a href="#"></a></div>
            </div>
            <div class="share">
                <a href="#" class="f-share">分享给好友</a>
                <a href="#" class="f-save">收藏商品</a>
            </div>
        </div>
        <div class="info-middl-bg">
            <div class="info-middle">
                <div class="title1"><a href="#">伊敦娜果大豆卵磷脂软胶囊 60粒/瓶</a></div>
                <div class="title2"><a href="#">预防感冒等疾病 使皮肤光滑 美白 有弹性 减少烟 酒 药物副作用 美容师推荐产品</a></div>
                <div class="price-bg">
                    <div class="price">
                            <span class="new-p">
                            	<em class="left">直降价：</em>
                                <em class="right"><i>￥</i>88.00</em>
                            </span>
                        <span class="old-p">￥129.00</span>
                    </div>
                </div>
                <div class="cuxiao">
                    <div class="left">正在促销：</div>
                    <div class="right">
                        <div class="manz"><i>满赠</i><em>曼秀雷敦满150送75 送完即止促销规则不累计</em></div>
                        <div class="zhij"><i>直降</i><em>伊敦娜全品类直降30元</em></div>
                    </div>
                </div>
                <div class="slt">
                    <div class="left">选择颜色：</div>
                    <ul class="right">
                        <li class="item cur"><i></i><a href="#">紫色</a></li>
                        <li class="item"><i></i><a href="#">白色</a></li>
                        <li class="item2"><i></i><a href="#"><img src="${webRoot}/template/bdw/statics/case/details03.png" width="30" height="30" /></a></li>
                        <li class="item2  cur"><i></i><a href="#"><img src="${webRoot}/template/bdw/statics/case/details03.png" width="30" height="30" /></a></li>
                    </ul>
                </div>
                <div class="num">
                    <div class="left">购买数量：</div>
                    <div class="right">
                        <input type="text" value="1"  /><a href="#" class="and"></a><a href="#" class="minus"></a>
                    </div>
                </div>
                <div class="gw">
                    <a href="#">加入购物车</a>
                </div>
            </div>
        </div>
        <div class="info-right">
            <div class="ir-top">店铺信息</div>
            <dl class="info-det">
                <dt>${webName}商城自营</dt>
                <dd class="xinx"><img src="${webRoot}/template/bdw/statics/case/xinxin.jpg" /></dd>
                <dd>好评率：<i>100.00%</i></dd>
                <dd>商品数量：2435</dd>
            </dl>
            <div class="ly-box">
                <a href="#" class="sc">收藏本店</a>
                <a href="#" class="dp">进入店铺</a>
            </div>
            <div class="scbz">
                <div class="title">商城保障：</div>
                <ul class="cont">
                    <li class="item">满88免运费&nbsp;&nbsp;全国免运费</li>
                    <li class="item">正品保障&nbsp;&nbsp;原装、原瓶、原产地进口</li>
                    <li class="item">闪电发货&nbsp;&nbsp;工作时间8小时内发货</li>
                    <li class="item">15天保障&nbsp;&nbsp;拆封无条件退换货</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="main">
<!--自由搭配-->
<div class="more-pro">
    <div class="title"><span><i>自由搭配</i></span></div>
    <div class="cont">
        <div class="cont-left">
            <div class="left-one">
                <dl>
                    <i></i>
                    <dt><a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-03.jpg" alt="" width="120" height="120" /></a></dt>
                    <dd class="name"><a href="#">伊敦娜果大豆卵磷脂软胶囊 60粒/瓶</a></dd>
                    <dd class="pri">¥49.00</dd>
                </dl>
            </div>
            <div class="left-two">
                <dl>
                    <i></i>
                    <dt><a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-03.jpg" alt="" width="120" height="120" /></a></dt>
                    <dd class="name"><a href="#">伊敦娜果大豆卵磷脂软胶囊 60粒/瓶</a></dd>
                    <dd class="pri"><em></em><span>¥49.00</span></dd>
                </dl>
                <dl>
                    <i></i>
                    <dt><a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-03.jpg" alt="" width="120" height="120" /></a></dt>
                    <dd class="name"><a href="#">伊敦娜果大豆卵磷脂软胶囊 60粒/瓶</a></dd>
                    <dd class="pri"><em class="cur"></em><span>¥49.00</span></dd>
                </dl>
                <dl>
                    <dt><a href="#"><img src="${webRoot}/template/bdw/statics/case/detail-03.jpg" alt="" width="120" height="120" /></a></dt>
                    <dd class="name"><a href="#">伊敦娜果大豆卵磷脂软胶囊 60粒/瓶</a></dd>
                    <dd class="pri"><em class="cur"></em><span>¥49.00</span></dd>
                </dl>
                <div class="scroll"><span></span></div>
            </div>
        </div>
        <div class="cont-right">
            <div class="sel">您已选择<i>3</i>个自由搭配组合</div>
            <div class="price1">原价：<i><em>￥</em>88.00</i></div>
            <div class="price2">搭配价：<i><em>￥</em>88.00</i></div>
            <div class="sp-btn"><a href="#">购买搭配组合</a></div>
            <div class="dy"></div>
        </div>
    </div>
</div>

<!--商品详情-->
<div class="main-menu">
<ul class="menu-m">
    <li class="item cur"><a href="#">商品详情</a></li>
    <li class="item"><a href="#">包装清单</a></li>
    <li class="item"><a href="#">售后服务</a></li>
    <li class="item"><a href="#">客户评论(<i>14</i>)</a></li>
    <li class="item"><a href="#">售前咨询</a></li>
</ul>
<div class="menu-info1"></div>
<ul class="menu-m">
    <li class="item"><a href="#">商品详情</a></li>
    <li class="item cur"><a href="#">包装清单</a></li>
    <li class="item"><a href="#">售后服务</a></li>
    <li class="item"><a href="#">客户评论(<i>14</i>)</a></li>
    <li class="item"><a href="#">售前咨询</a></li>
</ul>
<div class="menu-info2">
    本产品全国联保，享受三包服务，质保期为：二年质保<br />
    如因质量问题或故障，凭厂商维修中心或特约维修点的质量检测证明，享受7日内退货，15日内换货，15日以上在质保期内享受免费保修等三包服务！<br />
    售后服务电话：800-820-6655<br />
    品牌官方网站：http://www.asus.com.cn
</div>
<ul class="menu-m">
    <li class="item"><a href="#">商品详情</a></li>
    <li class="item"><a href="#">包装清单</a></li>
    <li class="item cur"><a href="#">售后服务</a></li>
    <li class="item"><a href="#">客户评论(<i>14</i>)</a></li>
    <li class="item"><a href="#">售前咨询</a></li>
</ul>
<div class="menu-info3">
    本产品全国联保，享受三包服务，质保期为：二年质保<br />
    如因质量问题或故障，凭厂商维修中心或特约维修点的质量检测证明，享受7日内退货，15日内换货，15日以上在质保期内享受免费保修等三包服务！<br />
    售后服务电话：800-820-6655<br />
    品牌官方网站：http://www.asus.com.cn
</div>
<ul class="menu-m">
    <li class="item"><a href="#">商品详情</a></li>
    <li class="item"><a href="#">包装清单</a></li>
    <li class="item"><a href="#">售后服务</a></li>
    <li class="item cur"><a href="#">客户评论(<i>14</i>)</a></li>
    <li class="item"><a href="#">售前咨询</a></li>
</ul>
<div class="menu-info4">
    <div class="info-top">
        <div class="t-left">
            <div class="score">
                <i>100</i><em>%</em><br />
                <span>用户满意度</span>
            </div>
            <div class="hp">
                <div class="rows">
                    <i>好评</i>
                                <span class="bar">
                                    <span class="in" style="width:95%"></span>
                                </span>
                    <em>95%</em>
                </div>
                <div class="rows">
                    <i>中评</i>
                                <span class="bar">
                                    <span class="in" style="width:5%"></span>
                                </span>
                    <em>5%</em>
                </div>
                <div class="rows">
                    <i>差评</i>
                                <span class="bar">
                                    <span class="in" style="width:0"></span>
                                </span>
                    <em>%</em>
                </div>
            </div>
        </div>
        <div class="t-right">
            <span>已购买过本产品的会员可去会员专区商品评价内发表使用评论，获得积分奖励。</span>
            <a href="#">发表评论</a>
        </div>
    </div>
    <div class="info-mid">
        <div class="ly">
            <div class="ly-top">
                <span class="name">netyjj@163.com</span>
                <span class="lv">(会员等级)</span>
                            <span class="pj">
                                <span></span>
                                <span></span>
                                <span></span>
                                <i></i>
                                <em></em>
                            </span>
            </div>
            <div class="ly-cont">
                <div class="cont-left">发货很快，下单后第二天就收到了，气泡包装很扎实，用着味道也很香，没有什么挑剔的</div>
                <div class="time">2014-03-17 19:45</div>
            </div>
            <div class="hf">管理员回复：感谢您对我们商城的支持！</div>
        </div>
        <div class="ly bg-color">
            <div class="ly-top">
                <span class="name">netyjj@163.com</span>
                <span class="lv">(会员等级)</span>
                            <span class="pj">
                                <span></span>
                                <span></span>
                                <span></span>
                                <i></i>
                                <em></em>
                            </span>
            </div>
            <div class="ly-cont">
                <div class="cont-left">发货很快，下单后第二天就收到了，气泡包装很扎实，用着味道也很香，没有什么挑剔的</div>
                <div class="time">2014-03-17 19:45</div>
            </div>
            <div class="hf">管理员回复：感谢您对我们商城的支持！</div>
        </div>
        <div class="ly">
            <div class="ly-top">
                <span class="name">netyjj@163.com</span>
                <span class="lv">(会员等级)</span>
                            <span class="pj">
                                <span></span>
                                <span></span>
                                <span></span>
                                <i></i>
                                <em></em>
                            </span>
            </div>
            <div class="ly-cont">
                <div class="cont-left">发货很快，下单后第二天就收到了，气泡包装很扎实，用着味道也很香，没有什么挑剔的</div>
                <div class="time">2014-03-17 19:45</div>
            </div>
            <div class="hf">管理员回复：感谢您对我们商城的支持！</div>
        </div>
        <div class="ly bg-color">
            <div class="ly-top">
                <span class="name">netyjj@163.com</span>
                <span class="lv">(会员等级)</span>
                            <span class="pj">
                                <span></span>
                                <span></span>
                                <span></span>
                                <i></i>
                                <em></em>
                            </span>
            </div>
            <div class="ly-cont">
                <div class="cont-left">发货很快，下单后第二天就收到了，气泡包装很扎实，用着味道也很香，没有什么挑剔的</div>
                <div class="time">2014-03-17 19:45</div>
            </div>
            <div class="hf">管理员回复：感谢您对我们商城的支持！</div>
        </div>
        <div class="ly">
            <div class="ly-top">
                <span class="name">netyjj@163.com</span>
                <span class="lv">(会员等级)</span>
                            <span class="pj">
                                <span></span>
                                <span></span>
                                <span></span>
                                <i></i>
                                <em></em>
                            </span>
            </div>
            <div class="ly-cont">
                <div class="cont-left">发货很快，下单后第二天就收到了，气泡包装很扎实，用着味道也很香，没有什么挑剔的</div>
                <div class="time">2014-03-17 19:45</div>
            </div>
            <div class="hf">管理员回复：感谢您对我们商城的支持！</div>
        </div>
    </div>
    <div class="info-btn"><img src="${webRoot}/template/bdw/statics/case/details4.png" /></div>
</div>
<ul class="menu-m">
    <li class="item"><a href="#">商品详情</a></li>
    <li class="item"><a href="#">包装清单</a></li>
    <li class="item"><a href="#">售后服务</a></li>
    <li class="item"><a href="#">客户评论(<i>14</i>)</a></li>
    <li class="item cur"><a href="#">售前咨询</a></li>
</ul>
<div class="menu-info5">
    <div class="info-top">
        <div class="info-bg"></div>
        <div class="info-cont">声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、产地等参数，所以该回复仅在当时对提问者有效！咨询回复的工作时间为：周一至周五，9:00至18:00，请耐心等待工作人员回复。</div>
    </div>
    <div class="info-mid">
        <div class="question">
            <div class="name">
                <span>用户名昵称</span>
                <em>( 2014-03-17 19:45 )</em>
            </div>
            <div class="q-cont"><i>咨询内容：</i><em>当日下订单能发货吗当日下订单能发货吗？</em></div>
            <div class="hf"><i>客服回复：</i><em>您好！此款商品目前现货的，您下单我们会尽快安排处理，具体到货时间无法确保，还请您注意查看订单跟踪信息，祝您购物愉快！</em></div>
        </div>
        <div class="question bg-color">
            <div class="name">
                <span>用户名昵称</span>
                <em>( 2014-03-17 19:45 )</em>
            </div>
            <div class="q-cont"><i>咨询内容：</i><em>当日下订单能发货吗当日下订单能发货吗？</em></div>
            <div class="hf"><i>客服回复：</i><em>您好！此款商品目前现货的，您下单我们会尽快安排处理，具体到货时间无法确保，还请您注意查看订单跟踪信息，祝您购物愉快！</em></div>
        </div>
        <div class="question">
            <div class="name">
                <span>用户名昵称</span>
                <em>( 2014-03-17 19:45 )</em>
            </div>
            <div class="q-cont"><i>咨询内容：</i><em>当日下订单能发货吗当日下订单能发货吗？</em></div>
            <div class="hf"><i>客服回复：</i><em>您好！此款商品目前现货的，您下单我们会尽快安排处理，具体到货时间无法确保，还请您注意查看订单跟踪信息，祝您购物愉快！</em></div>
        </div>
        <div class="question bg-color">
            <div class="name">
                <span>用户名昵称</span>
                <em>( 2014-03-17 19:45 )</em>
            </div>
            <div class="q-cont"><i>咨询内容：</i><em>当日下订单能发货吗当日下订单能发货吗？</em></div>
            <div class="hf"><i>客服回复：</i><em>您好！此款商品目前现货的，您下单我们会尽快安排处理，具体到货时间无法确保，还请您注意查看订单跟踪信息，祝您购物愉快！</em></div>
        </div>
    </div>
    <div class="info-btn">
        <p>发表咨询：</p>
        <textarea cols="112"></textarea>
        <a href="#">提交咨询</a>
        <span>请登录后提交咨询！ </span>
    </div>
</div>
</div>

<!--左侧栏-->
<div class="m2_lt">
    <div class="side-hot">
        <div class="sh-title">品类热卖</div>
        <div class="sh-box">
            <ul>
                <li>
                    <div class="b-pic"><a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic01.jpg" width="150" height="150" /></a></div>
                    <div class="b-title"><a href="#">天梭(TISSOT)陶瓷腕表系列女士石英表T064.210.22.011.00</a></div>
                    <div class="b-pri">
                        <p class="p-new">
                            <span>￥<em>3363.00</em></span>
                        </p>
                        <p class="p-old">
                            <span>￥<em>4863.00</em></span>
                        </p>
                    </div>
                </li>
                <li>
                    <div class="b-pic"><a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic04.jpg" width="150" height="150" /></a></div>
                    <div class="b-title"><a href="#">天梭(TISSOT)陶瓷腕表系列女士石英表T064.210.22.011.00</a></div>
                    <div class="b-pri">
                        <p class="p-new">
                            <span>￥<em>3363.00</em></span>
                        </p>
                        <p class="p-old">
                            <span>￥<em>4863.00</em></span>
                        </p>
                    </div>
                </li>
                <li>
                    <div class="b-pic"><a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic05.jpg" width="150" height="150" /></a></div>
                    <div class="b-title"><a href="#">天梭(TISSOT)陶瓷腕表系列女士石英表T064.210.22.011.00</a></div>
                    <div class="b-pri">
                        <p class="p-new">
                            <span>￥<em>3363.00</em></span>
                        </p>
                        <p class="p-old">
                            <span>￥<em>4863.00</em></span>
                        </p>
                    </div>
                </li>
                <li>
                    <div class="b-pic"><a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic04.jpg" width="150" height="150" /></a></div>
                    <div class="b-title"><a href="#">天梭(TISSOT)陶瓷腕表系列女士石英表T064.210.22.011.00</a></div>
                    <div class="b-pri">
                        <p class="p-new">
                            <span>￥<em>3363.00</em></span>
                        </p>
                        <p class="p-old">
                            <span>￥<em>4863.00</em></span>
                        </p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="side-history">
        <div class="sh-title"><i>浏览过的商品</i><a href="#">清空</a></div>
        <div class="sh-box">
            <ul>
                <li>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic02.jpg" width="80" height="80" /></a>
                    <i>￥<em>3363.00</em></i>
                </li>
                <li class="mr0">
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic06.jpg" width="80" height="80" /></a>
                    <i>￥<em>3363.00</em></i>
                </li>
                <li>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic07.jpg" width="80" height="80" /></a>
                    <i>￥<em>3363.00</em></i>
                </li>
                <li class="mr0">
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic08.jpg" width="80" height="80" /></a>
                    <i>￥<em>3363.00</em></i>
                </li>
                <li>
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic06.jpg" width="80" height="80" /></a>
                    <i>￥<em>3363.00</em></i>
                </li>
                <li class="mr0">
                    <a href="#"><img src="${webRoot}/template/bdw/statics/case/list-pic02.jpg" width="80" height="80" /></a>
                    <i>￥<em>3363.00</em></i>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="clear"></div>
</div>
</div>
<%--页面内容 end--%>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
