<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %><%--分页引用--%>

<%-- 设置发布轮播的数量 --%>
<c:set var="release_num" value="6"/>
<%-- 分页--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%-- 招商分类 --%>
<c:set var="syMerchantsCategoryProxy" value="${bdw:getMerchantsCategoryProxy()}"/>
<%-- 最新发布 --%>
<c:set var="SyMerchantsInfProxyList" value="${bdw:getCountSyMerchantsInfProxyList(release_num)}"/>
<%-- 药品分类 --%>
<c:set var="isRx" value="${empty param.isRx ? null : param.isRx}"/>
<%-- 招商分类 --%>
<c:set var="categoryId" value="${empty param.categoryId ? null : param.categoryId}"/>
<%-- 品牌 --%>
<c:set var="brandTagId" value="${empty param.brandTagId ? null : param.brandTagId}"/>
<%-- 药品分类 --%>
<c:set var="releaseDate" value="${empty param.releaseDate ? null : param.releaseDate}"/>
<%--招商商品信息--%>
<c:set value="${bdw:getMerchantsInfProxyProduct(_page, 6)}" var="merchantProductProxyPage" />
<%-- 招商类型 --%>
<c:set var="customerTypeId" value="${empty param.customerTypeId ? null : param.customerTypeId}"/>
<c:set var="customerTypeList" value="${bdw:getSysCustomerTypesList()}"/>
<%-- 招商区域 --%>
<c:set var="zoneList" value="${bdw:getZoneList()}"/>
<c:set var="merchantsZone" value="${empty param.merchantsZone ? null : param.merchantsZone}"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <meta name="keywords" content="易淘药产品招商代理，易淘药，易淘药集团，易淘药大健康，果维康，欧意，欧意和，若舒，恩必普，玄宁，丁苯酞，诺利宁，多美素，全安素，安沃勤，纯净冰岛，安蜜乐，易淘药贝贝，易淘药健康城"/>
    <meta name="description" content="易淘药健康网，优质药食源，易淘药集团官方网站，易淘药产品招商代理"/>
    <title>${sdk:getSysParamValue('index_title')}</title>
  <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
  <link href="${webRoot}/template/bdw/statics/css/attractAgentList.css" rel="stylesheet" type="text/css"/>
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/attractAgentList.js"></script>

  <script type="text/javascript">
      window.onload = function(){
          if(${not empty param.categoryId} || ${not empty param.customerTypeId} || ${not empty param.isRx} || ${not empty param.releaseDate} || ${not empty param.merchantsZone}){
              $("#product").show();
              $("#type").show();
              $("#zone").show();
              $("#time").show();
              $("#showMore").html("收起筛选");
          }
      }
  </script>

  <script type="text/javascript">

  </script>



</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=agent"/>
<!--页头结束-->

<!--主体-->
<div class="main-bg">
    <div class="m-top">

        <%-- 轮播 --%>
        <div class="m-cont">
            <div class="cont-box" id="contBox">
                <!--ul宽度为li个数乘以240px-->
                <ul id="photo" style="width:1440px; ">
                    <c:forEach items="${SyMerchantsInfProxyList}" var="syMerchant">
                        <li>
                            <a href="${webRoot}/investmentDetails.ac?merchantsInfId=${syMerchant.merchantsInfId}">
                                <div class="box-top">
                                  <c:choose>
                                      <c:when test="${syMerchant.isRx == '0'}">
                                        RX . 非处方药
                                      </c:when>
                                      <c:when test="${syMerchant.isRx == '1'}">
                                        OTC . 处方药
                                      </c:when>
                                      <c:when test="${syMerchant.isRx == '2'}">
                                        BAISE . 基药
                                      </c:when>
                                      <c:when test="${syMerchant.isRx == '3'}">
                                        OTHER . 其它
                                      </c:when>
                                  </c:choose>
                                </div>
                                <div class="pic">
                                    <img id="picImg" src="${syMerchant.productPicUrl}" alt="${syMerchant.merchantsProductName}">
                                </div>
                                <div class="box-bot">
                                    <div class="title">${syMerchant.merchantsProductName}</div>
                                    <div class="info">
                                        <div class="info-item">
                                            <span>产品规格：</span>
                                            <em>${syMerchant.prdSpec}</em>
                                        </div>
                                        <div class="info-item">
                                            <span>批准文号：</span>
                                            <em>${syMerchant.approvalNumber}</em>
                                        </div>
                                        <div class="info-item">
                                            <span>有效期至：</span>
                                            <em><fmt:formatDate value="${syMerchant.infExpireDate}" pattern="yyyy-MM-dd"/></em>
                                        </div>
                                        <div class="info-item">
                                            <span>招商区域：</span>
                                            <em>${syMerchant.merchantsZone}</em>
                                        </div>
                                        <div class="info-item">
                                            <span>招商类型：</span>
                                            <em>${syMerchant.merchantsType}</em>
                                        </div>
                                        <div class="info-item">
                                            <span>生产厂家：</span>
                                            <em>${syMerchant.productionManufacturer}</em>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>


            <%-- 最新发布 --%>
            <div class="new-pic">最新发布<span>${fn:length(SyMerchantsInfProxyList)}</span>条信息</div>
            <a href="#"  class="control-prev"></a>
            <a href="#" class="control-next" id="next"></a>
        </div>
    </div>

    <%-- 轻松代理步骤阅读 --%>
    <div class="step-bg">
        <div class="step">
            <h5>轻松代理<em>3</em>步骤</h5>
            <img src="${webRoot}/template/bdw/statics/images/pic1042x244.png" alt="">
        </div>
    </div>


    <div class="main">
        <div class="main-top">
            <div>
                <ul>
                    <li <c:if test="${empty categoryId}">class="cur" </c:if> >
                        <a href="${webRoot}/attractAgentList.ac?categoryId=&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}" class="all <c:if test='${categoryId == null}'>cur</c:if>">
                           全部
                        </a>
                    </li>
                    <c:forEach items="${syMerchantsCategoryProxy.merchantsCategoryProxys}" var="category" varStatus="s">
                           <li <c:if test="${categoryId == category.categoryId}">class="cur" </c:if> >
                               <a  href="${webRoot}/attractAgentList.ac?categoryId=${category.categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">
                                 ${category.categoryName}
                               </a>
                           </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="m1_more" style="height: 30px;"><a href="javascript:void(0)" class="more cur" id="showMore" onclick="showMoreCategory()">更多筛选</a></div>
            <div class="m1_coll" style="display:block;height: 30px;"><a href="javascript:void(0)" id="hideMore" class="more cur" onclick="hideTheCategory()">收起</a></div>
        </div>

        <div class="main-choice">
          <%-- 产品属性 --%>
            <div class="item" style="display: none" id="product">
                <span>产品属性</span>
                <div class="cont">
                    <div class="cont-lt">
                        <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}" class="all <c:if test='${isRx == null}'>cur</c:if>">全部</a>
                        <ul>
                            <li <c:if test='${isRx == 0}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&brandTagId=${brandTagId}&isRx=0&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">非处方药</a></li>
                            <li <c:if test='${isRx == 1}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&brandTagId=${brandTagId}&isRx=1&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">处方药</a></li>
                            <li <c:if test='${isRx == 2}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&brandTagId=${brandTagId}&isRx=2&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">基药</a></li>
                            <li <c:if test='${isRx == 3}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&brandTagId=${brandTagId}&isRx=3&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">其他</a></li>
                        </ul>
                    </div>
                </div>
            </div>

              <%-- 招商区域 --%>
              <div class="item" style="display: none" id="zone">
                  <span>招商区域</span>
                  <div class="cont">
                      <div class="cont-lt">
                          <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=" class="all <c:if test='${merchantsZone == null}'>cur</c:if>">全部</a>
                          <ul id="zoneFew">
                              <c:forEach items="${zoneList}" var="zone" begin="0" step="1" end="7">
                                  <li <c:if test="${merchantsZone == zone}">class="cur" </c:if> >
                                      <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${zone}">
                                              ${zone}
                                      </a>
                                  </li>
                              </c:forEach>
                          </ul>
                          <ul id="zoneMore" style="display:none">
                              <c:forEach items="${zoneList}" var="zone">
                                  <li <c:if test="${merchantsZone == zone}">class="cur" </c:if> >
                                      <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${zone}">
                                              ${zone}
                                      </a>
                                  </li>
                              </c:forEach>
                          </ul>
                      </div>
                      <div class="cont-rt"><a href="javascript:void(0)" class="more cur" id="showMoreZone" onclick="showMoreZone()">更多</a></div>
                  </div>
              </div>

            <%-- 招商类型 --%>
            <div class="item" style="display: none" id="type">
                <span>招商类型</span>
                <div class="cont">
                    <div class="cont-lt">
                        <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}" class="all <c:if test='${customerTypeId == null}'>cur</c:if>">全部</a>
                        <ul id="few" style="display: block">
                            <c:forEach items="${customerTypeList}" var="customerType" begin="0" step="1" end="6">
                              <li <c:if test="${customerTypeId == customerType.customerTypeId}">class="cur" </c:if> >
                                <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerType.customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">
                                    ${customerType.customerTypeName}
                                </a>
                              </li>
                            </c:forEach>
                        </ul>
                        <ul id="more" style="display: none">
                            <c:forEach items="${customerTypeList}" var="customerType">
                                <li <c:if test="${customerTypeId == customerType.customerTypeId}">class="cur" </c:if> >
                                    <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerType.customerTypeId}&isRx=${isRx}&releaseDate=${releaseDate}&merchantsZone=${merchantsZone}">
                                            ${customerType.customerTypeName}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                  <div class="cont-rt"><a href="javascript:void(0)" class="more cur"  id="showMuch" onclick="showMoreType()">更多</a></div>
                </div>
            </div>

            <%-- 发布时间 --%>
            <div class="item" style="display: none" id="time">
                <span>发布时间</span>
                <div class="cont">
                    <div class="cont-lt">
                        <a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=" class="all <c:if test='${releaseDate == null}'>cur</c:if>">全部</a>
                      <ul>
                        <li <c:if test='${releaseDate == 1}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=1&merchantsZone=${merchantsZone}">一周内</a></li>
                        <li <c:if test='${releaseDate == 2}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=2&merchantsZone=${merchantsZone}">一个月内</a></li>
                        <li <c:if test='${releaseDate == 3}'> class="cur" </c:if>><a href="${webRoot}/attractAgentList.ac?categoryId=${categoryId}&customerTypeId=${customerTypeId}&isRx=${isRx}&releaseDate=3&merchantsZone=${merchantsZone}">三个月内</a></li>
                      </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main-bot">
            <div class="dt">
                <span style="float: left; margin-left: 40px;">商品信息</span>
                <span style="margin-right: 85px;">操作</span>
                <span style="margin-right: 118px;">有效期</span>
                <span style="margin-right: 90px;">药品类型</span>
                <span style="margin-right: 83px;">招商类型</span>
                <span style="margin-right: 85px;">招商区域</span>
            </div>
            <div class="dd">
                <ul>
                    <c:forEach items="${merchantProductProxyPage.result}" var="syMerchantsInfProxy" varStatus="vs">
                        <li>
                            <div class="pic"><a href="javascript:void(0)"><img src="${syMerchantsInfProxy.productPicUrl}" alt="${syMerchantsInfProxy.merchantsProductName}"></a></div>
                            <div class="m1">
                                <a href="javascript:void(0)" class="title elli">${syMerchantsInfProxy.merchantsProductName} </a>
                                <div class="m1-item">
                                    <span>产品规格：</span>
                                    <em>${syMerchantsInfProxy.prdSpec}</em>
                                </div>
                                <div class="m1-item">
                                    <span>批准文号：</span>
                                    <em>${syMerchantsInfProxy.approvalNumber}</em>
                                </div>
                                <div class="m1-item">
                                    <span>生产厂家：</span>
                                    <em>${syMerchantsInfProxy.productionManufacturer}</em>
                                </div>
                            </div>
                            <div class="m2">${syMerchantsInfProxy.merchantsZone}</div>
                            <div class="m2">${syMerchantsInfProxy.merchantsType}</div>
                            <div class="m2">
                                <c:choose>
                                    <c:when test="${syMerchantsInfProxy.isRx == '0'}">
                                        处方药
                                    </c:when>
                                    <c:when test="${syMerchantsInfProxy.isRx == '1'}">
                                        非处方药
                                    </c:when>
                                    <c:when test="${syMerchantsInfProxy.isRx == '2'}">
                                        基药
                                    </c:when>
                                    <c:when test="${syMerchantsInfProxy.isRx == '3'}">
                                        其它
                                    </c:when>
                                </c:choose>
                            </div>
                            <div class="m2"><span><fmt:formatDate value="${syMerchantsInfProxy.infExpireDate}" pattern="yyyy-MM-dd"/></span></div>
                            <div class="m3">
                                <a href="${webRoot}/investmentDetails.ac?merchantsInfId=${syMerchantsInfProxy.merchantsInfId}">查看详情</a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
          <div class="pager">
            <%--<div id="infoPage">--%>
              <%--<ul>--%>
                <%--<li><a title="上一页" class="upPage" href="">上一页</a></li>--%>
                <%--<li><a class="everyPage" href="">1</a></li>--%>
                <%--<li><span class="nowPage">2</span></li>--%>
                <%--<li><a class="everyPage" href="">3</a></li>--%>
                <%--<li><a class="everyPage" href="">4</a></li>--%>
                <%--<li><a class="everyPage" href="">5</a></li>--%>
                <%--<li><a class="everyPage" href="">6</a></li>--%>
                <%--<li><a title="下一页" class="downPage" href="">下一页</a></li>--%>
                <%--<li><div id="page-skip">&nbsp;&nbsp;第&nbsp;<input value="3" id="inputPage">&nbsp;页/128页<button class="goToPage" onclick="" href="javascript:;">确定</button><div></div></div></li>--%>
              <%--</ul>--%>
            <%--</div>--%>

              <c:if test="${merchantProductProxyPage.lastPageNumber > 1}">
                  <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${merchantProductProxyPage.lastPageNumber}' currentPage='${_page}' totalRecords='${merchantProductProxyPage.totalCount}' ajaxUrl='${webRoot}/attractAgentList.ac' frontPath='${webRoot}' displayNum='6'/>
              </c:if>
          </div>
        </div>
    </div>
</div>


<!--页脚-->
<c:import url="/template/bdw/module/common/bottom.jsp?p=agent"/>


</body>
</html>
