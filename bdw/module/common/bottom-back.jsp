<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-5-23
  Time: 上午11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<script type="text/javascript">
    $(function(){
        $("body").css("display","block");
    })
</script>

<div id="footer">
    <img width=0 height=0 src="${webRoot}/commons/images/trackPage.png" style="display:none">
    <div class="stup">
        <ul>
            <c:forEach items="${sdk:getArticleCategoryById(60000).children}" var="articleCategory" varStatus="s" end="4">

                <li class="${s.count==5?'last':''}">
                    <dl>
                        <dt><img src="${articleCategory.icon['']}" width="36px" height="27px" /> ${articleCategory.name}</dt>
                        <c:forEach items="${articleCategory.top5}" var="article">
                            <dd>
                                <a target="_blank" class="${param.infArticleId==article.infArticleId?'cur':''}"
                                   href="${webRoot}/help-${article.infArticleId}.html">
                                        ${article.title}
                                </a>
                            </dd>
                        </c:forEach>
                            <%--<dd><a href="#">购物流程</a></dd>--%>
                            <%--<dd><a href="#">会员介绍</a></dd>--%>
                            <%--<dd><a href="#">常见问题</a></dd>--%>
                            <%--<dd><a href="#">联系客服</a></dd>--%>
                            <%--<dd>&nbsp;</dd>--%>
                    </dl>
                </li>
            </c:forEach>
            <%--<li>--%>
            <%--<dl>--%>
            <%--<dt><img src="images/footer_do02.gif" /> 配送方式</dt>--%>
            <%--<dd><a href="#">上门提货</a></dd>--%>
            <%--<dd><a href="#">快速运输</a></dd>--%>
            <%--<dd><a href="#">特快专递(EMS)</a></dd>--%>
            <%--<dd><a href="#">任何送礼</a></dd>--%>
            <%--<dd><a href="#">海外购物</a></dd>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <%--<li>--%>
            <%--<dl>--%>
            <%--<dt><img src="images/footer_do03.gif" /> 支付方式</dt>--%>
            <%--<dd><a href="#">货到付款</a></dd>--%>
            <%--<dd><a href="#">在线支付</a></dd>--%>
            <%--<dd><a href="#">分期付款</a></dd>--%>
            <%--<dd><a href="#">邮局汇款</a></dd>--%>
            <%--<dd><a href="#">公司转账</a></dd>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <%--<li>--%>
            <%--<dl>--%>
            <%--<dt><img src="images/footer_do04.gif" /> 售后服务</dt>--%>
            <%--<dd><a href="#">退换货政策</a></dd>--%>
            <%--<dd><a href="#">退换货流程</a></dd>--%>
            <%--<dd><a href="#">价格保护</a></dd>--%>
            <%--<dd><a href="#">退款说明</a></dd>--%>
            <%--<dd>&nbsp;</dd>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <%--<li>--%>
            <%--<dl>--%>
            <%--<dt><img src="images/footer_do05.gif" /> 乐商E购</dt>--%>
            <%--<dd><a href="#">退换货政策</a></dd>--%>
            <%--<dd><a href="#">退换货流程</a></dd>--%>
            <%--<dd><a href="#">价格保护</a></dd>--%>
            <%--<dd><a href="#">退款说明</a></dd>--%>
            <%--<dd>&nbsp;</dd>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <li class="text">
                <h2>入驻聚E购</h2>
                <div class="pro frameEdit custom"  frameInfo="custom21" style="width: 172px;margin: 0 auto;">
                    <div style="${empty sdk:findPageModuleProxy('custom21').pageModuleObjects[0].userDefinedContStr ? "display:none" : "display:block"}">
                        ${empty sdk:findPageModuleProxy('custom21').pageModuleObjects[0].userDefinedContStr ? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'></b></div>":(sdk:findPageModuleProxy('custom21').pageModuleObjects[0].userDefinedContStr)}
                    </div>
                </div>
                <%--<div class="pro">--%>
                    <%--致力打造“知名品牌、正品行货、直营低价”的一站式保险箱网上购物商城，现诚招供应商，欢迎能够成为乐商网的合作伙伴，分享网络商务发展的巨大商机，共同发展。--%>
                <%--</div>--%>
            </li>
        </ul>
    </div>
    <div class="dow frameEdit" frameInfo="jvan_bottom_banner|1200X57/960X57">
                      <c:set value="${sdk:findPageModuleProxy('jvan_bottom_banner').advt}" var="wideAdv"/>
        <c:forEach items="${wideAdv.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" class='commonScreen' title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="1200px" height="57px" /></a>
            <a href="${adv.link}" class='widthScreen' title="${adv.title}" target="_blank"><img  src="${not empty adv.widescreenAdvUrl ? adv.widescreenAdvUrl : adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="${wideAdv.widescreenWidth == 0 ?  '960px' : wideAdv.widescreenWidth}" height="${wideAdv.widescreenHeight == 0 ? '57px' :  wideAdv.widescreenHeight }" /></a>
        </c:forEach>
        <%--<a href="#"><img src="case/index_240_50_01.jpg" /></a>--%>
        <%--<img src="images/footer_dow.gif" />--%>
    </div>
    <div class="conpny">


        <p class="frameEdit" frameInfo="jvan_link2">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_link2').links}" var="pageLinks"  begin="0" end="10" varStatus="s">
                <a target="_blank" href="${pageLinks.link}">${pageLinks.title}</a> <c:if test="${!s.last}">|</c:if>
            </c:forEach>
        </p>
        <%--<a href="#">关于我们</a> | <a href="#">网站招商</a> | <a href="#">诚聘英才</a> | <a href="#">友情链接</a> | <a href="#">官方微博</a> | <a href="#">销售联盟</a>--%>

        <p><%--客服电话：400-050-9899  客服邮箱：service@safemall.com    乐商网 All Rights Reserved--%>
        <div class="shortScreen frameEdit custom"  frameInfo="custom20" style="margin: 0 auto;">
            <div style="${empty sdk:findPageModuleProxy('custom20').pageModuleObjects[0].userDefinedContStr ? "display:none" : "display:block"}">
                ${empty sdk:findPageModuleProxy('custom20').pageModuleObjects[0].userDefinedContStr ? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'></b></div>":(sdk:findPageModuleProxy('custom20').pageModuleObjects[0].userDefinedContStr)}
            </div>
        </div>
        </p>
        <%--<p><a href="http://http://www.iloosen.com/">广州市乐商软件科技有限公司</a>&nbsp;&nbsp;版权所有&nbsp;&nbsp;Powered by iMallS</p>--%>
        <%--<p>京ICP备11036570号 Copyright@2012</p>--%>
        <p>
        <div class="shortScreen frameEdit" frameInfo="jvan_link3" style="height:40px;text-align: center; ">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_link3').links}" var="pageLinks"  begin="0" end="10" varStatus="s">
                <a target="_blank" href="${pageLinks.link}"><img alt="${pageLinks.title}" src="${pageLinks.icon['']}" height="40px" width="108px" /></a>
            </c:forEach>
        </div>
        </p>
    </div>
</div>
<f:FrameEditTag />     <%--页面装修专用标签--%>
<%
    if(request.getSession().getAttribute("discuzScript") != null){
        out.print(request.getSession().getAttribute("discuzScript"));
        request.getSession().removeAttribute("discuzScript");
    }
%>
