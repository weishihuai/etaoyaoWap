<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!--楼层广告-->

<c:set value="${7}" var="floorAmount"/>  <%-- 这里定义楼层的数量，以后如果石药觉得楼层多了或者少了直接来这里修改就行了，默认7层 --%>

<c:forEach begin="1" end="${floorAmount}" varStatus="s">
    <c:set var="sy_floor_title" value="sy_floor${s.index}_title" />
    <c:set var="sy_floor_quickSearch" value="sy_floor${s.index}_quickSearch" />
    <c:set var="sy_floor_pic" value="sy_floor${s.index}_pic" />
    <c:set var="sy_floor_hotSaleCate" value="sy_floor${s.index}_hotSaleCate" />
    <c:set var="sy_floor_recommend" value="sy_floor${s.index}_recommend" />
    <c:set var="sy_gg_floor" value="sy_gg_floor${s.index}" />
    <c:set var="sy_gg2_floor" value="sy_gg2_floor${s.index}" />
    <c:set var="sy_floor_hotSaleWeek" value="sy_floor${s.index}_hotSaleWeek" />
    <c:set var="sy_floor_brand" value="sy_floor${s.index}_brand" />
    <div class="floor fl-m${s.index}" id="floor${s.index}">
        <div class="mt">
            <span>${s.index}F</span>
            <h5 class="frameEdit" frameInfo="${sy_floor_title}">
                <c:forEach items="${sdk:findPageModuleProxy(sy_floor_title).links}" var="link" end="0">
                  ${link.title}
                </c:forEach>
            </h5>
            <ul class="frameEdit" frameInfo="${sy_floor_quickSearch}">
                <c:forEach items="${sdk:findPageModuleProxy(sy_floor_quickSearch).links}" var="link" end="4" varStatus="status">
                  <%--<a href="${link.link}" title="${link.title}">${link.title}</a>--%>
                  <li><a href="${link.link}" <c:if test="${link.newWin}">target="_blank" </c:if> >${link.title}</a></li>
                  <c:if test="${!status.last}">
                      <li>|</li>
                  </c:if>
                </c:forEach>
            </ul>
        </div>
        <div class="mc">
            <c:set value="${sdk:findPageModuleProxy(sy_floor_pic).advt.advtProxy}" var="floorPic"/>
            <c:set value="${(fn:length(floorPic))>0 ? floorPic[0].advtHint:''}" var="back"/>
            <div class="mc-lt" style="background-color:${back} ">
                <div class="pic frameEdit" frameInfo="${sy_floor_pic}">
                    <c:forEach items="${floorPic}" var="advt" end="0">
                      <%--<a href="${advt.link}" target="_blank">--%>
                          <%--<img src="${advt.advUrl}" width="240px" height="355px">--%>
                          <%--&lt;%&ndash;<img class="lazy" data-original="${advt.advUrl}" width="240px" height="355px">&ndash;%&gt;--%>
                      <%--</a>--%>
                        ${advt.htmlTemplate}
                    </c:forEach>
                </div>
                <div class="hot frameEdit" frameInfo="${sy_floor_hotSaleCate}">
                    <c:forEach items="${sdk:findPageModuleProxy(sy_floor_hotSaleCate).links}" var="link">
                      <c:set value="${empty link.description? '#fff':link.description}" var="fontColor"/>
                      <a href="${link.link}" title="${link.title}" style="color: ${fontColor}" <c:if test="${link.newWin}">target="_blank" </c:if> >${link.title}</a>
                    </c:forEach>
                </div>
            </div>

            <%--原来这地放商品推荐的，现在改成图片装修--%>
            <%--<div class="mc-md frameEdit" frameInfo="${sy_floor_recommend}">
                <c:forEach items="${sdk:findPageModuleProxy(sy_floor_recommend).recommendProducts}" var="productProxy" end="5">
                    <div class="item">
                        <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img class="lazy" data-original="${productProxy.images[0]['120X120']}"  height="120" width="120" alt="${productProxy.name}"></a></div>
                        <a href="${webRoot}/product-${productProxy.productId}.html" class="title">${productProxy.name}</a>
                        <p>${productProxy.salePoint}</p>
                        <div class="price"><span>￥</span>${productProxy.price.unitPrice}</div>
                    </div>
                </c:forEach>
            </div>--%>

            <div class="mc-md">
                <div class="md-box1 frameEdit" frameInfo="${sy_gg_floor}">
                    <c:forEach items="${sdk:findPageModuleProxy(sy_gg_floor).advt.advtProxy}" var="advt" end="0">
                      <%--<a href="${advt.link}" target="_blank">--%>
                          <%--<img src="${advt.advUrl}" width="356px" height="250px">--%>
                         <%--&lt;%&ndash; <img class="lazy" data-original="${advt.advUrl}" width="356px" height="250px">&ndash;%&gt;--%>
                      <%--</a>--%>
                        ${advt.htmlTemplate}
                    </c:forEach>
                </div>

                <div class="md-box2-div frameEdit" frameInfo="${sy_gg2_floor}">
                    <c:forEach items="${sdk:findPageModuleProxy(sy_gg2_floor).advt.advtProxy}" var="advt" end="1">
                        <div class="md-box2">
                            <%--<a href="${advt.link}" target="_blank">--%>
                                <%--&lt;%&ndash;<img class="lazy" data-original="${advt.advUrl}" width="175px" height="250px">&ndash;%&gt;--%>
                                <%--<img src="${advt.advUrl}" width="175px" height="250px">--%>
                            <%--</a>--%>
                                    ${advt.htmlTemplate}

                        </div>
                    </c:forEach>
                </div>

                <div class="md-box3-div frameEdit" frameInfo="${sy_floor_recommend}">
                    <c:forEach items="${sdk:findPageModuleProxy(sy_floor_recommend).recommendProducts}" var="productProxy" end="3">
                        <div class="md-box3">
                            <a href="${webRoot}/product-${productProxy.productId}.html" class="b3-pic" target="_blank">
                                <img src="${productProxy.images[0]['120X120']}" height="120" width="120" alt="${productProxy.name}">
                            </a>
                            <a href="${webRoot}/product-${productProxy.productId}.html" class="b3-title elli" target="_blank"  title="${productProxy.name}">${productProxy.name}</a>
                            <div class="b3-price"><span>￥</span>${productProxy.price.unitPrice}</div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="mc-rt">
                <div class="rt-dt">本周热销</div>
                <div class="rt-dd">
                    <c:set value="${fn:length(sdk:findPageModuleProxy(sy_floor_hotSaleWeek).recommendProducts)}" var="productAmount"/>
                    <c:set value="${(productAmount-1)/4}" var="bannerAmount" />
                    <div class="dd-cont frameEdit" frameInfo="${sy_floor_hotSaleWeek}">
                        <c:forEach begin="0" end="${bannerAmount}" varStatus="sta">
                            <ul <c:if test="${sta.index!=0}">style="display:none"</c:if> id="floorUl${s.count}${sta.count}" class="floorUl${s.count}">
                                <c:forEach items="${sdk:findPageModuleProxy(sy_floor_hotSaleWeek).recommendProducts}" var="productProxy" begin="${(sta.count-1)*4}" end="${(sta.count-1)*4+3}">
                                    <li>
                                        <div class="cont-box">
                                            <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html" target="_blank"><img src="${productProxy.images[0]['80X80']}"  height="80" width="80" alt="${productProxy.name}"></a></div>
                                            <div class="box-rt">
                                                <a href="${webRoot}/product-${productProxy.productId}.html" class="title elli" target="_blank"  title="${productProxy.name}">${productProxy.name}</a>
                                                <div class="price"><span>￥</span>${productProxy.price.unitPrice}</div>
                                                <div class="num">
                                                    销量
                                                    <span>${productProxy.salesVolume}</span>
                                                    评价
                                                    <em>${productProxy.commentStatistics.total}</em>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:forEach>
                    </div>
                    <div class="dd-control">
                        <c:if test="${bannerAmount != 0}">
                            <c:forEach begin="0" end="${bannerAmount}" varStatus="stu">
                                <c:choose>
                                    <c:when test="${stu.index==0}">
                                        <a href="javascript:void(0);" class="cur floorNav floorNav${s.count}" fSec="${s.count}" uSec="${stu.count}"></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:void(0);" class="floorNav floorNav${s.count}" fSec="${s.count}" uSec="${stu.count}"></a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="main-brand frameEdit" frameInfo="${sy_floor_brand}">
        <ul>
            <c:forEach items="${sdk:findPageModuleProxy(sy_floor_brand).advt.advtProxy}" var="advt" varStatus="s" end="8">
              <li>
                  <%--<a href="${advt.link}" target="_blank">--%>
                      <%--<img src="${advt.advUrl}">--%>
                      <%--&lt;%&ndash;<img class="lazy" data-original="${advt.advUrl}">&ndash;%&gt;--%>
                  <%--</a>--%>
                          ${advt.htmlTemplate}
              </li>
            </c:forEach>
        </ul>
    </div>
</c:forEach>

<!--左边导航-->
<div class="sidebar">
    <a href="#header" class="str" title="精选专场">精选专场</a>
    <c:if test="${!empty bdw:getFirstPromotionProductProxy()}">
        <a href="#panicBuy" class="str" title="限时抢购">限时抢购</a>
    </c:if>
   <%-- <a href="#floor1" class="str">热门推荐</a>--%>
    <c:forEach begin="1" end="${floorAmount}" varStatus="s">
        <c:set var="sy_floor_title" value="sy_floor${s.count}_title" />
        <a href="#floor${s.count}" title="${link.title}">
            <c:forEach items="${sdk:findPageModuleProxy(sy_floor_title).links}" var="link" end="0">
                ${fn:substring(link.title,0 , 4)}
            </c:forEach>
        </a>
    </c:forEach>
    <a href="#" class="back-top" title="返回顶部">返回顶部</a>
</div>
