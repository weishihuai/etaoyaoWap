<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>

<%--获取招标详情--%>
<c:set var="invitationForBidProxyDetail" value="${bdw:getSyInvitationForBidProxyById(param.tnd)}"/>
<c:if test="${empty invitationForBidProxyDetail}">
    <c:redirect url="${webRoot}/404.ac"></c:redirect>>
</c:if>

<c:set value="${param.tnd}" var="tnd"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--查找出所有商品--%>
<c:set value="${bdw:searchProductByOrgId(2)}" var="productProxyPage"/>

<%--最新招标信息--%>
<c:set var="topForBidSizeList" value="${bdw:findInvitationForBidTopSize(20)}"/>
<%--获取供应商的所有商品--%>
<c:set var="allProductPage" value="${bdw:findAllProductByOrgId(3)}"/>
<c:if test="${not empty allProductPage}">
    <c:set var="allProductList" value="${allProductPage.result}"/>
</c:if>

<%--获取所有的投标记录--%>
<c:set var="allResponseItemPage" value="${bdw:findResponseItemListByForBidId(param.tnd, _page,5)}"/>
<c:set var="userIsSupplier" value="${bdw:checkUserIsSupplier()}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}"/>
    <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
    <%--SEO description优化--%>
    <title>${webName}-招标详情</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/tender-detail.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jqPaginator/jqPaginator.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.vticker.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var valueData = {
            webRoot: "${webRoot}"
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tenderDetail.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<%--主体--%>
<div class="main-bg">
    <div class="past">
        <div class="cont">
            <a href="${webRoot}/index.ac">易淘药商城首页</a>
            <i></i>
            <a href="${webRoot}/tenderList.ac">招标列表</a>
            <i></i>
            <span>招标详情</span>
        </div>
    </div>
    <div class="main clearfix">
        <div class="mlt">
            <div class="mlt-top">
                <div class="cont-lt">
                    <h5>${invitationForBidProxyDetail.title}</h5>
                    <div class="lt-bot">
                        <div class="item">
                            <span>发布时间</span>
                            <p><fmt:formatDate value="${invitationForBidProxyDetail.publishTime}" pattern="yyyy-MM-dd"/></p>
                        </div>
                        <div class="item">
                            <span>开始时间</span>
                            <p><fmt:formatDate value="${invitationForBidProxyDetail.startTime}" pattern="yyyy-MM-dd"/></p>
                        </div>
                        <div class="item">
                            <span>结束时间</span>
                            <p><fmt:formatDate value="${invitationForBidProxyDetail.endTime}" pattern="yyyy-MM-dd"/></p>
                        </div>
                    </div>
                </div>
                <div class="cont-rt">
                    <c:choose>
                        <c:when test="${invitationForBidProxyDetail.isEnd eq 'N'}">
                            <c:choose>
                                <c:when test="${empty user}">
                                    <a href="${webRoot}/login.ac" class="rt-btn">请登录</a>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${userIsSupplier}">
                                            <a href="javascript:void(0);" class="rt-btn" id="tender">我要投标</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="javascript:void(0);" class="rt-btn" id="disJoin">仅供应商参与</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="rt-btn">已结束</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="mlt-bot">
                <div class="bot-dt">招标详情</div>
                <div class="bot-dd">
                    <h4 style="font-size: 24px;">${invitationForBidProxyDetail.content}</h4>
                </div>
            </div>
        </div>
        <div class="mrt">
            <div id="responseResult">
                <c:choose>
                    <c:when test="${invitationForBidProxyDetail.isEnd eq 'N'}">
                        <h5>当前竞标信息<span><em>${invitationForBidProxyDetail.shopCount}</em>位商家正在竞标</span></h5>
                    </c:when>
                    <c:otherwise>
                        <h5>共有<span><em>${invitationForBidProxyDetail.shopCount}</em>位商家已竞标</span></h5>
                    </c:otherwise>
                </c:choose>
                <div class="current">
                    <c:if test="${allResponseItemPage.totalCount>0}">
                        <ul>
                            <c:forEach items="${allResponseItemPage.result}" var="responseItem">
                                <li>
                                    <div class="ct-mt">
                                        <div class="pic"><img src="${responseItem.shopLogo["100X100"]}" alt="" width="30px" height="30px"></div>
                                        <span class="name elli">${responseItem.shopName}</span>
                                        <em><fmt:formatDate value="${responseItem.createTime}" pattern="yyyy-MM-dd"/></em>
                                    </div>
                                    <div class="ct-mc">
                                        <div class="pic"><a href="${webRoot}/product-${responseItem.productId}.html"><img src="${responseItem.productImage["60X60"]}" height="60px" width="60px" alt=""></a></div>
                                        <a href="${webRoot}/product-${responseItem.productId}.html" class="title">${responseItem.productName}</a>
                                        <div class="repertory">库存：${responseItem.stockNumRange}件</div>
                                        <div class="price">￥${responseItem.priceRange}</div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <c:if test="${allResponseItemPage.lastPageNumber>1}">
                            <div class="control">
                                <c:if test='${!allResponseItemPage.firstPage}'>
                                    <a title="<c:choose><c:when test='${allResponseItemPage.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!allResponseItemPage.firstPage}'> class="control-prev" onclick="syncResponseItemPage(${allResponseItemPage.thisPageNumber-1},${tnd})" </c:if> ></a>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${allResponseItemPage.lastPageNumber}" step="1">
                                    <c:set var="displayNumber" value="6"/>
                                    <c:set var="startNumber" value="${(allResponseItemPage.thisPageNumber -(allResponseItemPage.thisPageNumber mod displayNumber))}"/>
                                    <c:set var="endNumber" value="${startNumber+displayNumber}"/>
                                    <c:if test="${(i>=startNumber) && (i<endNumber) }">
                                        <c:choose>
                                            <c:when test="${i==allResponseItemPage.thisPageNumber}">
                                                <a class="cur">${i}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a onclick="syncResponseItemPage(${i},${tnd})">${i}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:forEach>
                                <c:if test='${!allResponseItemPage.lastPage}'>
                                    <a title="<c:choose> <c:when test='${allResponseItemPage.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " <c:if test='${!allResponseItemPage.lastPage}'> class="control-next" onclick="syncResponseItemPage(${allResponseItemPage.thisPageNumber+1},${tnd})" </c:if> ></a>
                                </c:if>
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </div>
            <h5>最新招标信息</h5>
            <dl class="new">
                <dt>
                    <span>招标名称</span>
                    <span style="margin-left: 210px;">时间</span>
                </dt>
                <dd>
                    <div class="udbook">
                        <ul>
                            <c:if test="${not empty topForBidSizeList}">
                                <c:forEach var="forBid" items="${topForBidSizeList}">
                                    <li>
                                        <span class="elli" title="${forBid.title}"><a href="${webRoot}/tenderDetail.ac?tnd=${forBid.invitationForBidId}">${forBid.title}</a></span>
                                        <em><fmt:formatDate value="${forBid.endTime}" pattern="yyyy-MM-dd"/></em>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </dd>
            </dl>
        </div>
    </div>
</div>

<%--弹窗--%>
<div class="overlay" style="display: none;">
    <div class="lightbox">
        <div class="mt">
            <span>我要投标</span>
            <a href="javascript:void(0);" class="close" id="closeWin">&times;</a>
        </div>
        <div class="mc">
            <form id="uploadForm" name="uploadForm" enctype="multipart/form-data">
                <div class="mc-top">
                    <input type="hidden" name="productId" id="proId" value="">
                    <input type="hidden" name="forBidId" value="${param.tnd}" id="forBidId">
                    <div class="top-box">
                        <span>联系人</span>
                        <input type="text" id="contactName" name="contactName" autocomplete="off">
                        <span>联系电话</span>
                        <input type="text" id="contactMobile" name="contactMobile" autocomplete="off">
                    </div>
                    <div class="up">
                        竞标文件&nbsp;&nbsp;
                        <input type="file" name="reduceFile" id="upBtn"/>&nbsp;
                       <%-- <a href="javascript:void(0);" class="up-btn" id="upBtn">上传文件</a>--%>
                       <span style="color: red;"> 请上传竞标压缩文件，格式 （.rar/.zip），大小（10MB以内）</span>
                    </div>
                    <div class="mc-cont" id="prdContent">
                           <div class="dt">
                               <span>选择已有商品</span>
                               <em>选择已在易淘药平台上架或下架的商品进行竞标</em>
                               <a href="javascript:void(0);" class="btn" id="searchProductBtn">搜索</a>
                               <input type="text" id="searchTxt" placeholder="请输入商品名称或编码">
                           </div>
                           <div class="dd">
                               <div class="dd-th">
                                   <a href="javascript:void(0);" class="sel-btn" aria-disabled="true"></a>
                                   <span style="float: left; margin-left: 18px; ">商品信息</span>
                                   <span style="margin-right:20px;">实际库存</span>
                                   <span style="margin-right: 130px;">商品价格</span>
                               </div>
                               <div class="dd-td">
                                   <c:forEach items="${productProxyPage.result}" var="productProxy">
                                       <div class="item" id="prd${productProxy.productId}">
                                           <a href="javascript:void(0)" class="sel-btn box${productProxy.productId}" productId="${productProxy.productId}" onclick="toggleCheckBox(${productProxy.productId})"></a>
                                           <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["50X50"]}" alt="" width="50px" height="50px;"></a></div>
                                           <a href="${webRoot}/product-${productProxy.productId}.html" class="title">${productProxy.name}</a>
                                           <div class="num">${productProxy.stockRange}</div>
                                           <div class="price">${productProxy.priceRange}</div>
                                       </div>
                                   </c:forEach>
                               </div>
                           </div>
                           <c:if test="${productProxyPage.lastPageNumber>1}">
                               <div class="control">
                                   <c:if test='${!productProxyPage.firstPage}'>
                                       <a title="<c:choose><c:when test='${commentProxyResult.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!productProxyPage.firstPage}'> class="control-prev" onclick="syncProductPage(${productProxyPage.thisPageNumber-1})" </c:if> ></a>
                                   </c:if>
                                   <c:forEach var="i" begin="1" end="${productProxyPage.lastPageNumber}" step="1">
                                       <c:set var="displayNumber" value="6"/>
                                       <c:set var="startNumber" value="${(productProxyPage.thisPageNumber -(productProxyPage.thisPageNumber mod displayNumber))}"/>
                                       <c:set var="endNumber" value="${startNumber+displayNumber}"/>
                                       <c:if test="${(i>=startNumber) && (i<endNumber) }">
                                           <c:choose>
                                               <c:when test="${i==productProxyPage.thisPageNumber}">
                                                   <a class="cur">${i}</a>
                                               </c:when>
                                               <c:otherwise>
                                                   <a onclick="syncProductPage(${i})">${i}</a>
                                               </c:otherwise>
                                           </c:choose>
                                       </c:if>
                                   </c:forEach>
                                   <c:if test='${!productProxyPage.lastPage}'>
                                       <a title="<c:choose> <c:when test='${commentProxyResult.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " <c:if test='${!productProxyPage.lastPage}'> class="control-next" onclick="syncProductPage(${productProxyPage.thisPageNumber+1})" </c:if> ></a>
                                   </c:if>
                               </div>
                           </c:if>
                    </div>
                </div>
                <div class="mc-bot">
                    <a href="javascript:void(0);" class="btn01" id="submitBtn">确认</a>
                    <a href="javascript:void(0);" class="btn02" id="resetBtn">重置</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>