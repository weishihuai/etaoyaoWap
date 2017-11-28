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

<div class="footer" style="position: relative;z-index: 9999">

    <div class="footer_t frameEdit" frameInfo="commons_bottom">
        <div style="${empty sdk:findPageModuleProxy('commons_bottom').pageModuleObjects[0].userDefinedContStr ? "display:none" : "display:block"}">
            ${empty sdk:findPageModuleProxy('commons_bottom').pageModuleObjects[0].userDefinedContStr ? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'></b></div>":(sdk:findPageModuleProxy('commons_bottom').pageModuleObjects[0].userDefinedContStr)}
        </div>
    </div>

    <div class="footer_m frameEdit" frameInfo="product_hint">
        <div style="${empty sdk:findPageModuleProxy('product_hint').pageModuleObjects[0].userDefinedContStr ? "display:none" : "display:block"}">
            ${empty sdk:findPageModuleProxy('product_hint').pageModuleObjects[0].userDefinedContStr ? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'></b></div>":(sdk:findPageModuleProxy('product_hint').pageModuleObjects[0].userDefinedContStr)}
        </div>
    </div>
    <div class="foot_ba frameEdit" frameInfo="custom20" style="margin-bottom:20px;">
        <div style="${empty sdk:findPageModuleProxy('custom20').pageModuleObjects[0].userDefinedContStr ? "display:none" : "display:block"}">
            ${empty sdk:findPageModuleProxy('custom20').pageModuleObjects[0].userDefinedContStr ? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'></b></div>":(sdk:findPageModuleProxy('custom20').pageModuleObjects[0].userDefinedContStr)}

        </div>
        <%--<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1254567257'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/z_stat.php%3Fid%3D1254567257%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));</script>--%>
    </div>
</div>

<div class="bank_gj" id="gotopbtn" style="display:none;">
    <script type="text/javascript">
        idTest=document.getElementById("gotopbtn");
        idTest.onclick=function (){
            document.documentElement.scrollTop=0;
            window.pageYOffset=0;
            document.body.scrollTop=0;
            sb();
        }
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
        <a href="javascript:void(0)"><i class="icon10"></i><em>返回顶部</em></a>
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
