<%--
  Created by IntelliJ IDEA.
  User: sjw
  Date: 15-04-10
  Time: 上午10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<%-- 配送保证广告 --%>
<%--<div class="footer">
    <div class="ensure">
        <div class="w frameEdit" frameInfo="yz_bottom_ensure_adv|240X90">
            <c:forEach items="${sdk:findPageModuleProxy('yz_bottom_ensure_adv').advt.advtProxy}" var="ensureAdvt" end="4">
                <div class="item">
                    <a href="${ensureAdvt.link}" title="${ensureAdvt.title}"><img src="${ensureAdvt.advUrl}"></a>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="service">
        <div class="w">
            <div class="service-left">
                <div class="logo frameEdit" frameInfo="yz_bottom_web_log|50X180">
                    <c:forEach items="${sdk:findPageModuleProxy('yz_bottom_web_log').advt.advtProxy}" end="0" var="web_log">
                        <img src="${webRoot}/template/bdw/statics/images/logo_180x50_1019.png" height="50" width="180" alt="">
                    </c:forEach>
                </div>
                <p>客服热线</p>
                <strong>${sdk:getSysParamValue('webPhone')}</strong>
                &lt;%&ndash; 服务时间 &ndash;%&gt;
                <p>${sdk:getSysParamValue('webTime')}</p>
            </div>

            &lt;%&ndash; 帮助中心 &ndash;%&gt;
            <div class="service-mid">
                <c:forEach items="${sdk:getArticleCategoryById(60000).children}" var="articleCategory" varStatus="s" end="6">
                    <dl>
                        <dt>${articleCategory.name}</dt>
                        <dd>
                        <c:forEach items="${articleCategory.top5}" var="article">
                            <c:choose>
                                <c:when test="${not empty article.externalLink}">
                                    <a href="${article.externalLink}" title="${article.title}" target="_blank">${article.title}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${webRoot}/help-${article.infArticleId}.html" title="${article.title}" target="_blank">${article.title}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        </dd>
                    </dl>
                </c:forEach>
            </div>

            &lt;%&ndash; 微信二维码 &ndash;%&gt;
            <div class="service-right">
                <div class="code frameEdit" frameInfo="yz_bottom_weixin_code|115X115">
                    <c:forEach items="${sdk:findPageModuleProxy('yz_bottom_weixin_code').advt.advtProxy}" end="0" var="weixinCode">
                        <img src="${weixinCode.advUrl}" height="115" width="115">
                    </c:forEach>
                </div>
                <p>扫一扫关注微信公众号</p>
            </div>
        </div>
    </div>
    <div class="footer-info">
        <div class="t-intro frameEdit" frameInfo="yz_bottom_link">
            <c:forEach items="${sdk:findPageModuleProxy('yz_bottom_link').links}" var="link" varStatus="s" end="7">
                <a href="${link.link}" target="_blank" title="${link.title}">${link.title}</a>
                <c:if test="${s.count < 8}">
                    <span>|</span>
                </c:if>
            </c:forEach>
        </div>

        &lt;%&ndash; 底部模块 &ndash;%&gt;
        <div class="copyright frameEdit" frameInfo="yz_bottom_copyright">
            <c:if test="${not empty sdk:findPageModuleProxy('yz_bottom_copyright').pageModuleObjects[0]}">
                ${sdk:findPageModuleProxy('yz_bottom_copyright').pageModuleObjects[0].userDefinedContStr}
            </c:if>
        </div>

        &lt;%&ndash; 友情提示 &ndash;%&gt;
        <div class="authentication frameEdit" frameInfo="yz_bottom_friendship_link">
            <c:if test="${not empty sdk:findPageModuleProxy('yz_bottom_friendship_link').pageModuleObjects[0]}">
                ${sdk:findPageModuleProxy('yz_bottom_friendship_link').pageModuleObjects[0].userDefinedContStr}
            </c:if>
        </div>
    </div>
</div>--%>

<%-- 这个可能有用 --%>
<%--<div class="bank_gj" id="gotopbtn" style="display:none;">
    <script type="text/javascript">
        idTest=document.getElementById("gotopbtn");
        idTest.onclick=function (){
            document.documentElement.scrollTop=0;
            window.pageYOffset=0;
            document.body.scrollTop=0;
            sb();
        };
        window.onscroll=sb;
        function sb(){
            var scrolltop = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
            if(scrolltop==0){
                idTest.style.display="none";
            }else{
                idTest.style.display="block";
            }
        }

    </script>
    <c:if test="${param.p=='index'}">
        <c:forEach items="${sdk:findPageModuleProxy('index_float_shortcut').links}" var="pageLinks" end="9" varStatus="s">
            <div class="tab">
                <a href="#LinkF${s.count}"><i style="background: url('${pageLinks.icon}') no-repeat scroll 0 0 rgba(0, 0, 0, 0);background-size:38px 38px;"></i><em>${pageLinks.title}</em></a>
            </div>
            <li></li>
        </c:forEach>
    </c:if>
    <div class="tab frameEdit" frameInfo="index_float_shortcut">
        <a href="#LinkH"><i class="icon10"></i><em>返回顶部</em></a>
    </div>
</div>--%>

<%--cnzz站长统计--%>
<%--<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan style='display:none;' id='cnzz_stat_icon_1257056943'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1257056943' type='text/javascript'%3E%3C/script%3E"));</script>--%>

<div class="footer">
    <div class="mod-service">
        <div class="mod-service-inner frameEdit" frameInfo="sy_bottom_bar">
            <ul>
                <c:forEach items="${sdk:findPageModuleProxy('sy_bottom_bar').advt.advtProxy}" var="advt" varStatus="s" end="5">
                    <li >
                        <img src="${advt.advUrl}">
                        <h5>${advt.title}</h5>
                        <p>${advt.advtHint}</p>
                            <%--${advt.htmlTemplate}--%>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="w">
        <%--<dl class="fore">
            &lt;%&ndash; 新手入门的categoryId是111003 &ndash;%&gt;
            <dt>${sdk:getArticleCategoryById(111003).name}</dt>
            <dd>
                <a href="">免费注册</a>
                <a href="">采购商入门</a>
                <a href="">供应商入门</a>
                <a href="">常见问题</a>
            </dd>
        </dl>
        <dl class="fore">
            &lt;%&ndash; 交易安全的categoryId是111008 &ndash;%&gt;
            <dt>${sdk:getArticleCategoryById(111008).name}</dt>
            <dd>
                <a href="">交易规则</a>
                <a href="">资金安全</a>
                <a href="">交易结算</a>
                <a href="">支付方式</a>
            </dd>
        </dl>
        <dl class="fore">
            &lt;%&ndash; 支付与配送的categoryId是111013 &ndash;%&gt;
            <dt>${sdk:getArticleCategoryById(111013).name}</dt>
            <dd>
                <a href="">支付方式</a>
                <a href="">关于发票</a>
                <a href="">物流配送服务</a>
            </dd>
        </dl>
        <dl class="fore">
            &lt;%&ndash; 售后服务的categoryId是111017 &ndash;%&gt;
            <dt>${sdk:getArticleCategoryById(111017).name}</dt>
            <dd>
                <a href="">退款说明</a>
                <a href="">退换货保障</a>
                <a href="">发票制度</a>
                <a href="">纠纷处理</a>
            </dd>
        </dl>
        <dl class="fore">
            &lt;%&ndash; 特色服务的categoryId是111022 &ndash;%&gt;
            <dt>${sdk:getArticleCategoryById(111022).name}</dt>
            <dt>特色服务</dt>
            <dd>
                <a href="">会员俱乐部</a>
                <a href="">投诉建议</a>
                <a href="">用药咨询</a>
                <a href="">免责声明</a>
            </dd>
        </dl>--%>

        <c:forEach items="${sdk:getArticleCategoryById(60000).children}" var="articleCategory" varStatus="s" end="4">
            <dl class="fore">
                <dt>${articleCategory.name}</dt>
                <dd>
                    <c:forEach items="${articleCategory.top5}" var="article">
                        <c:choose>
                            <c:when test="${not empty article.externalLink}">
                                <a href="${article.externalLink}" title="${article.title}" target="_blank">${article.title}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/help-${article.infArticleId}.html" title="${article.title}" target="_blank">${article.title}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dd>
            </dl>
        </c:forEach>

        <div class="ft-ewm frameEdit" frameInfo="sy_app_download">
            <c:forEach items="${sdk:findPageModuleProxy('sy_app_download').advt.advtProxy}" var="advt" varStatus="s" end="0">
                ${advt.htmlTemplate}
                <span>关注${webName}微信</span>
            </c:forEach>
        </div>
        <div class="service">
            <span>客服热线</span>
            <h5>${sdk:getSysParamValue("webPhone")}</h5>
            <p> ${sdk:getSysParamValue("workTime")} </p>
            <div class="frameEdit" frameInfo="sy_bottom_button">
                <c:forEach items="${sdk:findPageModuleProxy('sy_bottom_button').links}" var="link" end="0">
                    <a href="${link.link}" class="ser-btn" title="${link.title}" target="_blank">${link.title}</a>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="info">
        <div class="links frameEdit" frameInfo="sy_bottom_links">
            <c:forEach items="${sdk:findPageModuleProxy('sy_bottom_links').links}" var="link" end="7" varStatus="s">
                <a href="${link.link}" title="${link.title}" <c:if test="${link.newWin}">target="_blank"</c:if>>${link.title}</a>
                <c:if test="${!s.last}">
                    <span>|</span>
                </c:if>
            </c:forEach>
        </div>

        <div class="copyright frameEdit" frameInfo="sy_bottom_copyright">
            <c:if test="${not empty sdk:findPageModuleProxy('sy_bottom_copyright').pageModuleObjects[0]}">
                ${sdk:findPageModuleProxy('sy_bottom_copyright').pageModuleObjects[0].userDefinedContStr}
            </c:if>
        </div>

         <div class="authentication frameEdit" frameInfo="sy_bottom_friendship_link">
             <c:if test="${not empty sdk:findPageModuleProxy('sy_bottom_friendship_link').pageModuleObjects[0]}">
                 ${sdk:findPageModuleProxy('sy_bottom_friendship_link').pageModuleObjects[0].userDefinedContStr}
             </c:if>
       </div>
    </div>
    <div class="info-cont" style="text-align: center"><img src="${webRoot}/commons/images/trackPage.png"></div>

</div>

<!-- 错误提示 -->
<div class="layerError" id="errorId" style="display: none">
    <div class="layer-dialog">
        <div class="layer-header">
            <h3>错误提示</h3>
            <a class="btn-close" href="javascript:;" title="" onclick="closeErrorWin()"></a>
        </div>
        <div class="wrong-body">
            <h5 id="errorText"></h5>
            <div class="bot-btn"><a href="javascript:;" id="errorBt" onclick="closeErrorWin()">确定</a></div>
        </div>
    </div>
</div>


<!--成功提示 -->
<div class="layerError" id="successId" style="display: none;">
    <div class="layer-dialog">
        <div class="layer-header">
            <h3>成功提示</h3>
            <a class="btn-close" href="javascript:;" title="" onclick="closeSuccessWin()"></a>
        </div>
        <div class="success-body">
            <h5 id="successText"></h5>
            <div class="bot-btn"><a href="javascript:;" id="successBt" onclick="closeSuccessWin()">确定</a></div>
        </div>
    </div>
</div>

<!-- 提示框 -->
<div class="layerError" id="confirmId" style="display: none">
    <div class="layer-dialog">
        <div class="layer-header">
            <h3>提示框</h3>
            <a class="btn-close" href="javascript:;" title="" onclick="closeConfirm()"></a>
        </div>
        <div class="layer-body">
            <%--<h5>确认提示</h5>--%>
            <p id="confirmMessage"></p>
            <a href="javascript:;" class="btn-r" id="confirmBt">确认</a>
            <a href="javascript:;" class="btn-w" id="confirmCloseBt" onclick="closeConfirm()" >取消</a>
        </div>
    </div>
</div>

<f:FrameEditTag />     <%--页面装修专用标签--%>
<%
    if(request.getSession().getAttribute("discuzScript") != null){
        out.print(request.getSession().getAttribute("discuzScript"));
        request.getSession().removeAttribute("discuzScript");
    }
%>
<!--end footer-->
