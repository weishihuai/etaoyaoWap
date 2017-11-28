<%--
  Created by IntelliJ IDEA.
  User: HGF
  Date: 2015/12/11
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getSysDiseaseLibProxy(param.sysDiseaseId)}" var="subDiseaseProxy"/>
<c:set value="${bdw:findIllnessMedicinalPage(param.type == null?'':param.type,param.sysDiseaseId,25)}" var="diseaseMedicinal"/>
<c:set value="${bdw:findIllnessMedicinalKeyWords(param.sysDiseaseId)}" var="medicinalKeyWords"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<!DOCTYPE html>
<html>
<head>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <%--<title>${webName}-${sdk:getSysParamValue('index_title')}-疾病详细</title>--%>
  <title>${subDiseaseProxy.diseaseNm} -  ${webName}</title>
  <meta name="keywords" content="${subDiseaseProxy.diseaseNm}，${subDiseaseProxy.diseaseNm}，${subDiseaseProxy.diseaseNm}" />
  <%--SEO keywords 优 化 --%>
  <meta name="description" content="${subDiseaseProxy.diseaseIntroduceStr}" />
  <%--SEO description优化--%>
  <style type="text/css">div .slider{right: 0;left: auto;}</style>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/illness-detail.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/xywyIllnessDetail.js"></script>
  <script type="text/javascript">
    var webPath = {
      webRoot: "${webRoot}",
      sysDiseaseId: "${param.sysDiseaseId}",
      productCollectCount: "${loginUser.productCollectCount}"
    }
  </script>
</head>
<c:import url="/template/bdw/module/common/loginDialog.jsp"/>
<c:set value="${param.sysDiseaseId}" var="sysDiseaseId"/>
<c:set var="diseaseProxy" value="${bdw:getDiseaseById(sysDiseaseId)}"/>
<body>
<%--弹出层——加入购物车--%>
<div style="display: none;" class="layer-bg product-detail">
  <%--加入购物车成功信息--%>
  <div style="display: none;" class="d-layer addCartInfo" id="addCartInfo">
    <div class="mt">
      <span>加入购物车</span>
      <a class="close" href="javascript:"></a>
    </div>
    <div class="mc">
      <p>商品已成功添加到购物车！</p>
      <div class="btn">
        <a class="sub" href="${webRoot}/shoppingcart/cart.ac" class="pay">去购物车结算</a>

        <a class="sub close" href="javascript:">继续购物</a>
      </div>
    </div>
  </div>
</div>
<%--页头--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<!--主体-->
<div class="main-bg">
  <div class="past">
    <div class="first">
      <a href="${webRoot}/index.html" class="cata">${webName}</a>
      <i class="crumbs-arrow"></i>
    </div>
      <a class="cata" href="${webRoot}/channelXywyIndex.ac">寻医问药</a>
      <i class="crumbs-arrow"></i>
    <div class="last">
      <a  class="cata" href="#">疾病详细</a>
    </div>
  </div>
  <div class="main">
    <div class="mt">
      <span>${subDiseaseProxy.diseaseNm}</span>
     <%-- <a href="javascript:history.back();">返回疾病列表</a>--%>
      <a href="${webRoot}/channelXywyDiseaseLib.ac">返回疾病列表</a>
    </div>
    <div class="mc">
      <div class="mc-nav">
        <a href="${webRoot}/xywyIllnessDetail.ac?sysDiseaseId=${param.sysDiseaseId}" class="<c:if test="${empty param.type or param.type eq 'illKnow'}">cur</c:if>"> 疾病知识</a>
        <a href="${webRoot}/xywyIllnessDetail.ac?type=illSuggest&sysDiseaseId=${param.sysDiseaseId}" class="<c:if test="${param.type eq 'illSuggest'}">cur</c:if>">用药建议</a>
      </div>
      <div class="collect">
        <%--<a href="javascript:" id="diseaseCollect" class="diseaseCollect">--%>
          <%--<i class="${diseaseProxy.isCollect?'yes':'no'}"></i><span>${diseaseProxy.isCollect? '已收藏':'加入收藏夹'}</span>--%>
        <%--</a>--%>
      </div>

      <c:if test="${empty param.type or param.type eq 'illKnow'}">
        <div class="illn-know">

          <div class="kn-item01">
            <label>常见症状：</label>

            <div class="mc-cont">
              <c:forEach items="${subDiseaseProxy.unselectedSymptoms}" var="symptoms">
                <span>${symptoms.symptomNm}</span>
              </c:forEach>
            </div>
          </div>
          <div class="kn-item02">
            <label>疾病简介：</label>
            <div class="mc-cont">
              ${subDiseaseProxy.diseaseIntroduceStr}
            </div>
          </div>
          <div class="kn-item03">
            <label>发病原因：</label>
            <div class="mc-cont">
                ${subDiseaseProxy.causeOfDiseaseStr}
            </div>
            <ul class="reason">
              <c:set value="${subDiseaseProxy.diseaseDeptmAndParts}" var="diseaseDeptmAndParts"/>
              <li>
                <span>挂号科室：</span>
                <em>
                  <c:forEach items="${diseaseDeptmAndParts.subList}" var="depart">
                    <i style="color: #333;padding-right: 8px;">${depart.subDepartmentNm}</i>
                  </c:forEach>
                </em>
              </li>
              <li>
                <span>发病部位：</span>
                  <em>
                    <c:forEach items="${diseaseDeptmAndParts.partsList}" var="part">
                      ${part.subPartNm}&nbsp;
                    </c:forEach>
                  </em>
              </li>
              <li>
                <span>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</span>
                <c:if test="${subDiseaseProxy.sexCode eq '0'}"><em>男性</em></c:if>
                <c:if test="${subDiseaseProxy.sexCode eq '1'}"><em>女性</em></c:if>
                <c:if test="${subDiseaseProxy.sexCode eq '2'}"><em>男、女性</em></c:if>
              </li>
              <li>
                <span>多发人群：</span>
                <em>
                  <c:forEach items="${diseaseDeptmAndParts.susceptiblesList}" var="susceptible">
                      <c:if test="${susceptible.susceptiblesCode eq '0'}">婴幼儿&nbsp;&nbsp;</c:if>
                      <c:if test="${susceptible.susceptiblesCode eq '1'}">少年儿童&nbsp;&nbsp;</c:if>
                      <c:if test="${susceptible.susceptiblesCode eq '2'}">青年&nbsp;&nbsp;</c:if>
                      <c:if test="${susceptible.susceptiblesCode eq '3'}">中年&nbsp;&nbsp;</c:if>
                      <c:if test="${susceptible.susceptiblesCode eq '4'}">老年&nbsp;&nbsp;</c:if>
                  </c:forEach>
                </em>
              </li>
            </ul>
          </div>
          <div class="kn-item03">
            <label>养生建议：</label>
            <div class="mc-cont">
                ${subDiseaseProxy.keepHealthSuggest}
            </div>
          </div>
        </div>
      </c:if>
      <c:if test="${param.type eq 'illSuggest'}">
        <div class="illn-suggest">
          <div class="illn-know">
            <div class="kn-item01">
              <label>用药建议：</label>
              <div class="mc-cont">
                  <%--用药建议 药品关键字--%>
                <c:forEach items="${medicinalKeyWords}" var="medicinalKeyWord">
                  <span>${medicinalKeyWord}</span>
                </c:forEach>
              </div>
            </div>

          <ul class="sug-cont">
            <c:forEach items="${diseaseMedicinal.result}" var="diseaseProduct">
              <li>
                <div class="pic"><a href="#" title="#">
                  <%--<c:if test="${diseaseProduct.isRecommend eq 'Y'}">--%>
                    <%--<span class="rec">店长推荐</span><!--店长推荐-->--%>
                  <%--</c:if>--%>
                  <img src="${diseaseProduct.defaultImage['100X100']}" width="100" height="100" alt="">
                </a></div>
                <div class="sc-md">
                  <a href="${webRoot}/product-${diseaseProduct.productId}.html" class="title elli">${diseaseProduct.name}</a>
                  <p>${diseaseProduct.salePoint}</p>
                  <%--<div class="md-info">--%>
                    <%--<div class="info-item">--%>
                      <%--<label>批准文号：</label>--%>
                      <%--<c:choose>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '0'}">&lt;%&ndash; 0 - 普通药品 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["approval_number"].valueString ?'-----':diseaseProduct.dicValueMap["approval_number"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '3'}">&lt;%&ndash; 3 - 药妆 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["cosmeceuticals_registry_code"].valueString ?'-----':diseaseProduct.dicValueMap["cosmeceuticals_registry_code"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                          <%--<span>-----</span>--%>
                        <%--</c:otherwise>--%>
                      <%--</c:choose>--%>
                    <%--</div>--%>
                    <%--<div class="info-item">--%>
                      <%--<label>剂&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</label>--%>
                      <%--<c:choose>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '0'}">&lt;%&ndash; 0 - 普通药品 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["form"].valueString ?'-----':diseaseProduct.dicValueMap["form"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                          <%--<span>-----</span>--%>
                        <%--</c:otherwise>--%>
                      <%--</c:choose>--%>
                    <%--</div>--%>
                    <%--<div class="info-item">--%>
                      <%--<label>生产厂家：</label>--%>
                      <%--<c:choose>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '0'}">&lt;%&ndash; 0 - 普通药品 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["manufacture_factory"].valueString ? '-----':diseaseProduct.dicValueMap["manufacture_factory"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '1'}">&lt;%&ndash; 1 - 保健品 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["hcp_manufacture_factory"].valueString ? '-----':diseaseProduct.dicValueMap["hcp_manufacture_factory"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '2'}">&lt;%&ndash; 2 - 医疗器械 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["mi_manufacture_factory"].valueString ? '-----':diseaseProduct.dicValueMap["mi_manufacture_factory"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '3'}">&lt;%&ndash; 3 - 药妆 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["cosmeceuticals_manufacture_factory"].valueString ? '-----':diseaseProduct.dicValueMap["cosmeceuticals_manufacture_factory"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '4'}">&lt;%&ndash; 4 - 其他  &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["common_manufacture_factory"].valueString ? '-----':diseaseProduct.dicValueMap["common_manufacture_factory"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                          <%--<span>-----</span>--%>
                        <%--</c:otherwise>--%>
                      <%--</c:choose>--%>
                    <%--</div>--%>
                    <%--<div class="info-item">--%>
                      <%--<label>规格包装：</label>--%>
                      <%--<c:choose>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '0'}">&lt;%&ndash; 0 - 普通药品 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["span"].valueString ? '-----':diseaseProduct.dicValueMap["span"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '1'}">&lt;%&ndash; 1 - 保健品 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["hcp_spec"].valueString ? '-----':diseaseProduct.dicValueMap["hcp_spec"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '2'}">&lt;%&ndash; 2 - 医疗器械 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["mi_spec"].valueString ? '-----':diseaseProduct.dicValueMap["mi_spec"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '3'}">&lt;%&ndash; 3 - 药妆 &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["cosmeceuticals_spec"].valueString ? '-----':diseaseProduct.dicValueMap["cosmeceuticals_spec"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${diseaseProduct.medicinalTypeCode eq '4'}">&lt;%&ndash; 4 - 其他  &ndash;%&gt;--%>
                          <%--<span>${empty diseaseProduct.dicValueMap["common_prd_spec"].valueString ? '-----':diseaseProduct.dicValueMap["common_prd_spec"].valueString}</span>--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                          <%--<span>-----</span>--%>
                        <%--</c:otherwise>--%>
                      <%--</c:choose>--%>
                    <%--</div>--%>
                  <%--</div>--%>
                </div>
                <div class="sc-rt">
                  <span>¥ ${diseaseProduct.priceListStr}</span>
                  <del>¥<fmt:formatNumber value="${diseaseProduct.marketPrice}" type="number" pattern="#0.00#" /></del>
                  <br/>
                  <c:if test="${diseaseProduct.isEnableMultiSpec eq 'Y'}">
                    <a href="${webRoot}/product-${diseaseProduct.productId}.html">查看详情</a>
                  </c:if>
                  <c:if test="${diseaseProduct.isEnableMultiSpec eq 'N'}">
                    <a class="addcart" href="javascript:void(0);" skuid="${diseaseProduct.isEnableMultiSpec=='Y' ? '': diseaseProduct.skus[0].skuId}" num="1" carttype="normal" handler="sku">加入购物车</a>
                  </c:if>
                </div>
              </li>
            </c:forEach>
          </ul>
        </div>
        <div class="pager">
          <div id="infoPage">
            <c:if test="${diseaseMedicinal.lastPageNumber>1}">
              <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${diseaseMedicinal.lastPageNumber}' currentPage='${diseaseMedicinal.thisPageNumber}'  totalRecords='${diseaseMedicinal.totalCount}' ajaxUrl='${webRoot}/xywyIllnessDetail.ac' frontPath='${webRoot}' displayNum='6' />
            </c:if>
          </div>
        </div>
      </c:if>
    </div>

  </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
