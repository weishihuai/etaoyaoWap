<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<div class="main-top">
  <div class="mt-slider">
   <%-- <div class="slider-cont">
      <div class="slider-list frameEdit" frameInfo="sy_main_banner">
        <ul id="roteAdv">
          <c:forEach items="${sdk:findPageModuleProxy('sy_main_banner').advt.advtProxy}" var="banner" varStatus="s">
            <c:choose>
                <c:when test="${s.index == 0}">
                  <li style="opacity: 1; filter:alpha(opacity=100); z-index: 10; " id="${s.count}">
                    <a href="${banner.link}" target="_blank"><img src="${banner.advUrl}"></a>
                  </li>
                </c:when>
                <c:otherwise>
                  <li id="${s.count}">
                    <a href="${banner.link}" target="_blank"><img src="${banner.advUrl}"></a>
                  </li>
                </c:otherwise>
            </c:choose>
          </c:forEach>
        </ul>
      </div>


      &lt;%&ndash;这个地方要进行轮播和轮播点击滚动的改造&ndash;%&gt;
      <div class="slider-indicator slider" id="nav"></div>

      &lt;%&ndash;<div class="slider-indicator slider" id="nav" style="width:${fn:length(sdk:findPageModuleProxy('sy_main_banner').advt.advtProxy) * 20}px" ></div>&ndash;%&gt;

      <a href="javascript:void(0);" class="slider-control-prev main-banner-prev"></a>
      <a href="javascript:void(0);" class="slider-control-next main-banner-next"></a>
    </div>--%>
    <div class="swiper-container roteAdv frameEdit" frameInfo="sy_main_banner" style="width:700px;height:460px">
      <div class="swiper-wrapper">
        <c:forEach items="${sdk:findPageModuleProxy('sy_main_banner').advt.advtProxy}" var="banner" varStatus="s">
          <c:choose>
            <c:when test="${s.index == 0}">
              <li class="swiper-slide" style="opacity: 1; filter:alpha(opacity=100); z-index: 10; " id="${s.count}">
             ${banner.htmlTemplate}
              </li>
            </c:when>
            <c:otherwise>
              <li class="swiper-slide" id="${s.count}">
              ${banner.htmlTemplate}
              </li>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </div>
      <div class="pagination swiper-pagination-white"></div>
      <a href="javascript:void(0);" class="slider-control-prev main-banner-prev"></a>
      <a href="javascript:void(0);" class="slider-control-next main-banner-next"></a>
    </div>
    <div class="slider-extend frameEdit" frameInfo="sy_gg_banner_down">
      <c:forEach items="${sdk:findPageModuleProxy('sy_gg_banner_down').advt.advtProxy}" var="advt" varStatus="s" end="3">
          <div class="box">
            <%--<a href="${advt.link}" target="_blank">--%>
              <%--<img src="${advt.advUrl}">--%>
                ${advt.htmlTemplate}
            <%--<img class="lazy" data-original="${advt.advUrl}">--%>
             <%--</a>--%>
          </div>
      </c:forEach>
    </div>
  </div>
  <div class="mt-rt">

    <%--这是那副人体图，后面完善--%>
    <div class="rt-top">
      <a href="${webRoot}/channelXywyIndex.ac">
        <%--<img class="lazy" data-original="${webRoot}/template/bdw/statics/images/pic200x25.png">--%>
        <img src="${webRoot}/template/bdw/statics/images/pic200x25.png">
      </a>
      <div class="pic maleFront"><img src="${webRoot}/template/bdw/statics/images/man110x230-1.png" alt=""></div>
      <div class="pic maleBack" style="display:none"><img src="${webRoot}/template/bdw/statics/images/man110x230-2.png" alt=""></div>
      <div class="pic femaleFront" style="display:none"><img src="${webRoot}/template/bdw/statics/images/woman110x230-1.png" alt=""></div>
      <div class="pic femaleBack" style="display:none"><img src="${webRoot}/template/bdw/statics/images/woman110x230-2.png" alt=""></div>
      <div class="rt-sel">
        <div class="m-w">
          <a href="javascript:void(0);" class="active male">男性</a>
          <a href="javascript:void(0);" class="female">女性</a>
        </div>
        <div class="b-f">
          <a href="javascript:void(0);" class="active front">正面</a>
          <a href="javascript:void(0);" class="back">背面</a>
        </div>
      </div>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m1"target="_blank">全身</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m2"target="_blank">头部</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m3"target="_blank">颈部</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m4"target="_blank">腹部</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m5"target="_blank">生殖</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m6"target="_blank">心理</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m7"target="_blank">上肢</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m8"target="_blank">胸部</a>
      <a href="channelXywy.ac?askType=symptom" class="pa-model m9"target="_blank">下肢</a>
    </div>

    <div class="rt-info">
      <div class="info-nav frameEdit" frameInfo="sy_link1_banner_right">
        <ul>
          <c:forEach items="${sdk:findPageModuleProxy('sy_link1_banner_right').links}" var="link" varStatus="s" end="1">
              <c:choose>
                  <c:when test="${s.index == 0}">
                      <li class="cur mesLiLeft"><a href="javascript:void(0);">${fn:substring(link.title, 0, 7)}</a></li>
                  </c:when>
                  <c:otherwise>
                      <li class="mesLiRight"><a href="javascript:void(0);">${fn:substring(link.title, 0, 7)}</a></li>
                  </c:otherwise>
              </c:choose>
          </c:forEach>
        </ul>
      </div>

      <div class="tabpane frameEdit leftTab" frameInfo="sy_link_panel1_banner_right">
        <div class="info-cont">
          <c:forEach items="${sdk:findPageModuleProxy('sy_link_panel1_banner_right').links}" var="link" end="2">
              <a href="${link.link}" class="item elli" <c:if test="${link.newWin}">target="_blank"</c:if> title="${link.title}" ><span>·</span>${link.title}</a>
          </c:forEach>
        </div>
      </div>

      <div class="tabpane frameEdit rightTab" frameInfo="sy_link_panel2_banner_right" style="display:none">
        <div class="info-cont">
          <c:forEach items="${sdk:findPageModuleProxy('sy_link_panel2_banner_right').links}" var="link" end="2">
            <a href="${link.link}" class="item elli" <c:if test="${link.newWin}">target="_blank"</c:if> title="${link.title}"><span>·</span>${link.title}</a>
          </c:forEach>
        </div>
      </div>

    </div>
    <div class="fc-tion frameEdit" frameInfo="sy_gg_banner_right" >
      <c:forEach items="${sdk:findPageModuleProxy('sy_gg_banner_right').advt.advtProxy}" var="advt" varStatus="s" end="5" >
          <div class="item">
            <a href="${advt.link}" target="_blank">
              <img src="${advt.advUrl}">
              <%--<img class="lazy" data-original="${advt.advUrl}">--%>
              <p>${advt.title}</p>
            </a>
          </div>
      </c:forEach>
    </div>
  </div>
</div>

