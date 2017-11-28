<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysOrg" %>
<%@ page import="com.iloosen.imall.commons.helper.ServiceManager" %>
<%@ page import="com.iloosen.imall.module.product.domain.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.iloosen.imall.client.constant.product.IProduct" %>
<%@ page import="org.apache.commons.collections.CollectionUtils" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    PrintWriter print = response.getWriter();
    String[] orgCodes = {"1812","9600","6687","5201","2410"};
    for(String orgCode : orgCodes){
        if(StringUtils.isBlank(orgCode)){
            print.write("orgCode：" + orgCode + "为空");
            continue;
        }

        SysOrg sysOrg = ServiceManager.sysOrgService.getByOrgCode(orgCode);
        if(sysOrg != null){
            List<Product> productList = ServiceManager.shopProductService.findByKey(IProduct.SYS_ORG_ID, sysOrg.getSysOrgId());
            if(CollectionUtils.isNotEmpty(productList)){
                for(Product product : productList){
                    ServiceManager.shopProductService.updateShopProductZone(product);
                }
            }else{
                print.print("orgCode为" + orgCode + "没有商品");
                continue;
            }
        }

        print.write("orgCode为："+ orgCode + "修改商品配送区域成功！！！<br/>");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
</body>
</html>