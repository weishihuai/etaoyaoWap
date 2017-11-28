<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-商品评论</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userTalk.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
</head>
<c:if test="${param.id == null}">
    <c:redirect url="/index.jsp"></c:redirect>
</c:if>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<%--商品评论统计--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,10)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=product"/>
<%--页头结束--%>

<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<div id="position" class="m1-bg"><div class="m1"><a href="${webRoot}/index.html">首页</a>
    <c:forEach items="${productProxy.category.categoryTree}" var="node" begin="1">
        > <a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a>
    </c:forEach>
    > <a href="${webRoot}/product.ac?id=${param.id}" title="${productProxy.name}">${productProxy.name}</a>
    </div>
</div>

<div id="userTalk">
	<div class="lBox">
        <%--商品详细--%>
        <c:import url="/template/bdw/comment/includeProduct.jsp?id=${param.id}"/>
        <%--商品详细--%>
		<div class="m2">
			<h2>热销排行</h2>
			<div class="box">
				<ul>
                    <c:forEach items="${sdk:findMonthTopProducts(1,9)}" var="phoneList" varStatus="s">
                        <li>
                            <div class="pic"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html"><img src="${empty phoneList.images ? phoneList.defaultImage['60X60'] : phoneList.images[0]['60X60']}" alt="" style="width: 52px;height: 52px;" /></a></div>
                            <div class="title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html">${phoneList.name}</a></div>
                            <div class="price">￥<fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                            <div class="clear"></div>
                        </li>
                    </c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div class="rBox">
		<div class="talkList">
            <div class="t_Menu">
                <ul>
                    <li class="w"><a name="comment" <c:if test="${empty param.commentStatistics}">class="cur"</c:if> href="javascript:void(0);" onclick="reLoadPage('${webRoot}/comment/productComment.ac?id=${param.id}');">全部评论<span>(${commentStatistics.total})</span></a></li>
                    <li><a <c:if test="${param.commentStatistics == 'good'}">class="cur"</c:if> href="javascript:void(0);" onclick="reLoadPage('${webRoot}/comment/productComment.ac?id=${param.id}&commentStatistics=good#comment');">好评<span>(${commentStatistics.good})</span></a></li>
                    <li><a <c:if test="${param.commentStatistics == 'normal'}">class="cur"</c:if> href="javascript:void(0);" onclick="reLoadPage('${webRoot}/comment/productComment.ac?id=${param.id}&commentStatistics=normal#comment');">中评<span>(${commentStatistics.normal})</span></a></li>
                    <li><a <c:if test="${param.commentStatistics == 'bad'}">class="cur"</c:if> href="javascript:void(0);" onclick="reLoadPage('${webRoot}/comment/productComment.ac?id=${param.id}&commentStatistics=bad#comment');">差评<span>(${commentStatistics.bad})</span></a></li>
                    <li><a href="${webRoot}/comment/buyConsult.ac?id=${param.id}">售前咨询</a></li>
                </ul>
            </div>
            <div class="box">
            <c:choose>
                <c:when test="${commentStatistics.total == 0}">
                    <div class="datShowBox">
                        <div class="shar">
                            <div class="hornot">
                                <div class="prod">暂无评论</div>
                                <p><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></p>
                                <p>0人参与评分</p>
                            </div>
                            <div class="starShow">
                                <ul>
                                    <li>
                                        <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /></div>
                                        <div class="sorll">
                                            <div class="bg" style="display:block; width:0px"></div>	<!-- 100%=200px 30%=60px  -->
                                            <div class="mub" style=" margin-left:0px;">0</div>	<!-- margin-left 30%=60px  -->
                                        </div>
                                        <div class="clear"></div>
                                    </li>
                                    <li>
                                        <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                        <div class="sorll">
                                            <div class="bg" style="display:block; width:0px"></div>	<!-- 同上  -->
                                            <div class="mub" style=" margin-left:0px;">0</div>
                                        </div>
                                        <div class="clear"></div>
                                    </li>
                                    <li>
                                        <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                        <div class="sorll">
                                            <div class="bg" style="display:block; width:0px"></div>	<!-- 同上  -->
                                            <div class="mub" style=" margin-left:0;">0</div>
                                        </div>
                                        <div class="clear"></div>
                                    </li>
                                    <li>
                                        <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                        <div class="sorll">
                                            <div class="bg" style="display:block; width:0px"></div>	<!-- 同上  -->
                                            <div class="mub" style=" margin-left:0;">0</div>
                                        </div>
                                        <div class="clear"></div>
                                    </li>
                                    <li>
                                        <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                        <div class="sorll">
                                            <div class="bg" style="display:block; width:0px"></div>	<!-- 同上  -->
                                            <div class="mub" style=" margin-left:0px;">0</div>
                                        </div>
                                        <div class="clear"></div>
                                    </li>
                                </ul>
                            </div>
                            <div class="tips">
                                <p>我购买过该商品，我要评论此商品!</p>
                                <p>注：购买过此商品的用户才能进行评价。</p>
                                <div class="btn"><a href="javascript:void(0);" id="isAllowComment"><img src="${webRoot}/template/bdw/statics/images/detail_btn03.gif" /></a></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="datShowBox">
                            <div class="shar">
                                <div class="hornot">
                                    <div class="prod2"><b>${commentStatistics.average}</b>分</div>
                                    <p>
                                        <c:choose>
                                            <c:when test="${commentStatistics.average le 2 && commentStatistics.average ge 1}">
                                                <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" />
                                            </c:when>
                                            <c:when test="${commentStatistics.average le 3 && commentStatistics.average ge 2}">
                                                <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" />
                                            </c:when>
                                            <c:when test="${commentStatistics.average le 4 && commentStatistics.average ge 3}">
                                                <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" />
                                            </c:when>
                                            <c:when test="${commentStatistics.average ge 4}">
                                                <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" />
                                            </c:when>
                                        </c:choose>
                                    </p>
                                    <p>${commentStatistics.total}人参与评分</p>
                                </div>
                                <div class="starShow">
                                    <ul>
                                        <li>
                                            <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /></div>
                                            <div class="sorll">
                                                <div class="bg" style="display:block; width:${commentStatistics.fiveStar}%;"></div>	<!-- 100%=200px 30%=60px  -->
                                                <div class="mub" style=" margin-left:${commentStatistics.fiveStar * 2}px;">${commentStatistics.fiveStar}</div>	<!-- margin-left 30%=60px  -->
                                            </div>
                                            <div class="clear"></div>
                                        </li>
                                        <li>
                                            <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                            <div class="sorll">
                                                <div class="bg" style="display:block; width:${commentStatistics.fourStar}%;"></div>	<!-- 同上  -->
                                                <div class="mub" style=" margin-left:${commentStatistics.fourStar * 2}px;">${commentStatistics.fourStar}</div>	<!-- margin-left 30%=60px  -->
                                            </div>
                                            <div class="clear"></div>
                                        </li>
                                        <li>
                                            <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                            <div class="sorll">
                                                <div class="bg" style="display:block; width:${commentStatistics.threeStar}%;"></div>	<!-- 同上  -->
                                                <div class="mub" style=" margin-left:${commentStatistics.threeStar * 2}px;">${commentStatistics.threeStar}</div>	<!-- margin-left 30%=60px  -->
                                            </div>
                                            <div class="clear"></div>
                                        </li>
                                        <li>
                                            <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                            <div class="sorll">
                                                <div class="bg" style="display:block; width:${commentStatistics.twoStar}%;"></div>	<!-- 同上  -->
                                                <div class="mub" style=" margin-left:${commentStatistics.twoStar * 2}px;">${commentStatistics.twoStar}</div>	<!-- margin-left 30%=60px  -->
                                            </div>
                                            <div class="clear"></div>
                                        </li>
                                        <li>
                                            <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                            <div class="sorll">
                                                <div class="bg" style="display:block; width:${commentStatistics.oneStar}%;"></div>	<!-- 同上  -->
                                                <div class="mub" style=" margin-left:${commentStatistics.oneStar * 2}px;">${commentStatistics.oneStar}</div>	<!-- margin-left 30%=60px  -->
                                            </div>
                                            <div class="clear"></div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="tips">
                                    <p>我购买过该商品，我要评论此商品!</p>
                                    <p>注：购买过此商品的用户才能进行评价。</p>
                                    <div class="btn"><a href="javascript:void(0);" id="isAllowComment"><img src="${webRoot}/template/bdw/statics/images/detail_btn03.gif" /></a></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                </c:otherwise>
            </c:choose>

                <div class="plList">
                    <c:forEach items="${commentProxyResult}" var="commentProxy">
                    <div class="item">
                        <div class="user">
                            <div class="pic">
                                <img src="${commentProxy.icon['100X100']}" style="width: 80px;height: 80px;" alt="${commentProxy.roleNm}" />
                            </div>
                            <p class="vipConf">${commentProxy.roleNm}</p>
                            <p>购买时间</p>
                            <p>${commentProxy.buyTimeString}</p>
                        </div>
                        <div class="messg">
                            <div class="t_are">
                                <span>${commentProxy.userName}
                                    <c:forEach begin="1" end="${commentProxy.score}">
                                        <img src="${webRoot}/template/bdw/statics/images/detail_starIco04.gif" />
                                    </c:forEach>
                                    ${commentProxy.score}分
                                </span>
                                <em>${commentProxy.createTimeString}</em>
                                <div class="clear"></div>
                            </div>
                            <div class="c_are">
                                <p>${commentProxy.content}</p>
                                <c:forEach items="${commentProxy.commentReplys}" var="commentSession">
                                <p class="rePut">
                                    ${commentSession.userNm}回复：${commentSession.commentCont}
                                </p>
                                </c:forEach>
                            </div>
                            <div class="b_are">
                                <label>此评价对我：</label>
                                <div class="btn1"><a id="${commentProxy.sysCommentId}_Enable" href="javascript:void(0);" onclick="enableComment('${commentProxy.sysCommentId}','#${commentProxy.sysCommentId}_Enable')">有用(${commentProxy.helpful})</a></div>
                                <div class="btn2"><a id="${commentProxy.sysCommentId}_Disable" href="javascript:void(0);" onclick="disableComment('${commentProxy.sysCommentId}','#${commentProxy.sysCommentId}_Disable')">没用(${commentProxy.unHelpful})</a></div>
                                <div class="clear"></div>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    </c:forEach>
                </div>
                <c:if test="${not empty commentProxyResult && commentProxyPage.lastPageNumber > 1}">
                    <div class="page">
                        <div style="float:right">
                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/comment/productComment.ac"   totalPages='${commentProxyPage.lastPageNumber}' currentPage='${commentProxyPage.thisPageNumber}' totalRecords='${commentProxyPage.totalCount}' frontPath='${webRoot}'  displayNum='6'/>
                        </div>
                    </div>
                </c:if>
            </div>
		</div>
	</div>
	<div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
