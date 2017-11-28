<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<%
    request.setAttribute("applyStatCode", request.getParameter("applyStatCode"));            //label 状态
%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%-- 获取申请记录 --%>
<c:set value="${bdw:findFrialTrialApplyList(6)}" var="frialApplyPage"/>

<%-- 获取用户所有报告 --%>
<c:set var="repApply" value="${bdw:getAllTrialApplys('')}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
  <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
  <title>${webName}-会员专区-${sdk:getSysParamValue('index_title')}</title>  <%--SEO title优化--%>
  <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/${templateCatalog}/module/member/statics/css/myTry.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript">
    var webPath = {webRoot:"${webRoot}"};
  </script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
  <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/main.js"></script>
  <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/plupload/plupload.full.min.js"></script>
  <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/ObjectToJsonUtil.js"></script>
  <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myTry.js"></script>


</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html"  title="首页">首页</a> > <a href="${webRoot}/module/member/index.ac"  title="会员中心">会员中心</a> > 免费试用</div></div>

<div id="member">
  <%--左边菜单栏 start--%>
  <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
  <%--左边菜单栏 end--%>
      <div class="my-try">
          <div class="ord-top">
              <ul>
                  <li><a href="${webRoot}/module/member/myTry.ac?pitchOnRow=40&report=N" <c:if test="${empty param.applyStatCode}">class="cur" </c:if> >全部试用</a></li>
                  <li>|</li>
                  <li><a href="${webRoot}/module/member/myTry.ac?pitchOnRow=40&applyStatCode=0&report=N" <c:if test="${param.applyStatCode == 0}">class="cur" </c:if> >审核中</a></li>
                  <li>|</li>
                  <li><a href="${webRoot}/module/member/myTry.ac?pitchOnRow=40&applyStatCode=2&report=N" <c:if test="${param.applyStatCode == 2}">class="cur" </c:if> >已通过</a></li>
                  <li>|</li>
                  <li><a href="${webRoot}/module/member/myTry.ac?pitchOnRow=40&applyStatCode=3&report=y" <c:if test="${param.applyStatCode == 3}">class="cur" </c:if> >我的报告<span>${fn:length(repApply)}</span></a></li>
                  <li>|</li>
              </ul>
          </div>
          <div class="ord-cont">
              <c:choose>
                  <c:when test="${empty param.report || param.report eq 'N'}">
                      <div class="tabpane"style="<c:if test="${param.report eq 'N'}">display: block;</c:if>">
                          <div class="oc-mt">
                              <span style="float: left; margin-left: 104px;">商品信息</span>
                              <span style="margin-right: 40px;">交易操作</span>
                              <span style="margin-right: 76px;">订单状态</span>
                              <span style="margin-right: 82px;">申请时间</span>
                              <span style="margin-right: 64px;">试用份数</span>
                              <span style="margin-right: 32px;">价值金额（元）</span>
                          </div>
                          <div class="oc-mc">
                              <ul>
                                  <c:forEach items="${frialApplyPage.result}" var="frial" varStatus="s">
                                      <!--申请审核中-->
                                      <li>
                                          <div class="mc-cont">
                                              <table cellspacing="0" cellpadding="0" class="order-info">
                                                  <tbody>
                                                  <tr>
                                                      <td class="detail">
                                                          <table cellspacing="0" cellpadding="0">
                                                              <tbody>
                                                              <tr>
                                                                  <td class="s1"><a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}" target="_blank"><img src="${frial.productPic['']}" width="80" height="80"></a></td>
                                                                  <td class="s2">
                                                                      <a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}" target="_blank">${frial.productNm}</a>
                                                                  </td>
                                                                  <td class="s3">${frial.valueAmount}</td>
                                                                  <td class="s4">1</td>
                                                              </tr>
                                                              </tbody>
                                                          </table>
                                                      </td>
                                                      <td class="s6">
                                                          <fmt:formatDate value="${frial.applyTime}" pattern="yyyy-MM-dd"/>
                                                      </td>
                                                      <c:choose>
                                                          <%-- 审核中 --%>
                                                          <c:when test="${frial.applyStatCode == 0}">
                                                              <td class="s7"><span>审核中</span></td>
                                                              <td class="s8"></td>
                                                          </c:when>

                                                          <%-- 代发货 --%>
                                                          <c:when test="${frial.applyStatCode == 1}">
                                                              <td class="s7"><span>已通过</span><br/></td>
                                                              <td class="s8"></td>
                                                          </c:when>

                                                          <%-- 已通过 --%>
                                                          <c:when test="${ frial.applyStatCode == 2}">
                                                              <td class="s7"><span>已通过</span><br/>
                                                                  <div class="logis hover">
                                                                      <a href="javascript:void(0);" class="showLog" log="${s.count}">查看物流</a>
                                                                      <div class="log-cont" style="display: none;overflow: auto;height: 300px;" id="showLog${s.count}">
                                                                          <i></i>
                                                                          <div class="log-mt">${frial.logisticsCompanyNm}：${frial.logisticsOrderNum}</div>
                                                                          <div class="log-mc">
                                                                              <c:choose>
                                                                                  <c:when test="${fn:length(frial.logisticsLogs)<=0}">
                                                                                      <div class="lm-item">
                                                                                          <p>暂无物流信息!</p>
                                                                                      </div>
                                                                                  </c:when>
                                                                                  <c:otherwise>
                                                                                      <c:forEach items="${frial.logisticsLogs}" var="logs">
                                                                                          <div class="lm-item">
                                                                                              <p>${logs.log}</p>
                                                                                              <span><fmt:formatDate value="${logs.logDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                                                                          </div>
                                                                                      </c:forEach>
                                                                                  </c:otherwise>
                                                                              </c:choose>
                                                                          </div>
                                                                          <div class="log-mb">以上为最新跟踪信息</div>
                                                                      </div>
                                                                  </div>
                                                              </td>
                                                              <td class="s8">
                                                                  <a href="javascript:void(0);" class="btn bg-btn wriReport" freeTrialApplyId="${frial.freeTrialApplyId}" freeTrialId="${frial.freeTrialId}">填写报告</a>
                                                              </td>
                                                          </c:when>

                                                          <%-- 已收集试用报告 --%>
                                                          <c:when test="${frial.applyStatCode == 3}">
                                                              <td class="s7"><span>已通过</span>
                                                              <td class="s8">
                                                                  <span>已报告</span><br>
                                                                  <a href="javascript:void(0);" class="report"
                                                                     repTitle="${frial.repTitle}"
                                                                     repTime="<fmt:formatDate value="${frial.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                                                                     repCont="${frial.repCont}"
                                                                     repPict="${frial.repPict}"
                                                                          >报告详情</a>
                                                              </td>
                                                          </c:when>
                                                      </c:choose>
                                                  </tr>
                                                  </tbody>
                                              </table>
                                          </div>
                                      </li>
                                  </c:forEach>
                              </ul>
                          </div>
                          <div class="pager">
                              <c:if test="${frialApplyPage.lastPageNumber > 1}">
                                  <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${frialApplyPage.lastPageNumber}' currentPage='${_page}' totalRecords='${frialApplyPage.totalCount}' ajaxUrl='${webRoot}/module/member/myTry.ac' frontPath='${webRoot}' displayNum='6'/>
                              </c:if>
                          </div>
                      </div>
                  </c:when>
                  <c:otherwise>
                      <!--我的报告-->
                      <div class="my-report">
                          <div class="oc-mt">
                              <span style="float: left; margin-left: 20px;">报告信息</span>
                              <span style="margin-right: 50px;">操作</span>
                              <span style="margin-right: 160px;">时间</span>
                          </div>
                          <div class="oc-mc">
                              <ul>
                                  <c:forEach items="${frialApplyPage.result}" var="apply">
                                      <li>
                                          <div class="pic"><img src="${apply.productPic['']}" alt="${apply.productNm}"></div>
                                          <div class="title">${apply.repTitle} </div>
                                          <div class="time"><fmt:formatDate value="${apply.repSubmitTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                          <a href="javascript:void(0);" class="dt-btn report"
                                             repTitle="${apply.repTitle}"
                                             repTime="<fmt:formatDate value="${apply.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                                             repCont="${apply.repCont}"
                                             repPict="${apply.repPict}"
                                                  >报告详情</a>
                                      </li>
                                  </c:forEach>

                              </ul>
                          </div>
                      </div>
                  </c:otherwise>
              </c:choose>
          </div>
      </div>

      <!--报告详情弹窗-->
      <div class="overlay" style="display:none;" id="report_lay">
          <div class="lightbox rp-dt">
              <div class="mt">
                  <span>报告详情</span>
                  <a href="javascript:void(0);" class="close closeReport">&times;</a>
              </div>
              <div class="mc">
                  <div class="mc-top">
                      <h5 id="repTitle"></h5>
                      <span id="repTime"></span>
                  </div>
                  <div class="mc-cont" id="repCont">
                  </div>
              </div>
          </div>
      </div>

      <div class="overlay" style="display:none;" id="pic_lay">
          <div class="lightbox sel-pic">
              <div class="mt">
                  <span>选择图片</span>
                  <a href="javascript:void(0);" class="close closePic">&times;</a>
              </div>
              <div class="sel-mc">
                  <div class="mc-top">
                      <div class="item">
                          <img src="${webRoot}/template/bdw/statics/case/pic150x150.jpg" alt="">
                          <a href="javascript:void(0);" class="cut-btn"></a>
                          <a href="javascript:void(0);" class="del-btn"></a>
                          <div class="title elli">556513323bensonenson</div>
                      </div>
                  </div>
                  <div class="mc-bot">
                      <a href="javascript:void(0);" class="up-btn">上传图片</a>
                      <a href="javascript:void(0);" class="cm-btn">跳转</a>
                      <input type="text">
                      <div class="p-num">
                          <a href="javascript:void(0);" class="control-prev"></a>
                          <span>2/3</span>
                          <a href="javascript:void(0);" class="control-next"></a>
                      </div>
                  </div>
              </div>
              <div class="md">
                  <a href="javascript:void(0);" class="md-btn01">确认</a>
                  <a href="javascript:void(0);" class="md-btn02 closePic">取消</a>
              </div>
          </div>
      </div>

      <!--填写报告弹窗-->
      <form method="post" id="addFrom">
          <input id="freeTrialId" name="freeTrialId" type="hidden" value=""/>
          <input id="freeTrialApplyId" name="freeTrialApplyId" type="hidden" value=""/>
          <input id="repPict" name="repPict" type="hidden" value=""/>
      </form>
      <div class="overlay" style="display: none;" id="wri_lay">
          <div class="lightbox wt-rp">
              <div class="mt">
                  <span>填写报告</span>
                  <a href="javascript:void(0);" class="close closeWri">&times;</a>
              </div>
              <div class="mc">
                  <div class="mc-item">
                      <span class="label"><i>*</i>报告详情</span>
                      <input type="text" id="wriRepTitle" placeholder="请输入试用标题">
                  </div>
                  <div class="mc-item">
                      <span class="label"><i>*</i>填写报告</span>
                      <textarea placeholder="请输入报告内容" id="wriRepCont"></textarea>
                  </div>
                  <div class="mc-item up-pic">
                      <span class="label"><i>*</i>产品图片</span>
                      <div class="pic-cont">
                          <div class="up-ld"><a href="javascript:void(0);" id="btnUpload">上传图片</a></div>
                      </div>
                  </div>
                  <a class="btn-blue" href="javascript:void(0);" title="提交" onclick="updateFreeTrialApply()">提交</a>
              </div>
          </div>
      </div>
  <div class="clear"></div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
