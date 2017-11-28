<%@ page import="com.iloosen.imall.client.commons.StringUtils" %>
<%@ page import="com.iloosen.imall.client.constant.product.IProduct" %>
<%@ page import="com.iloosen.imall.commons.helper.ServiceManager" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysFileLib" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.ObjectEngineTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.SysIndexObjectTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.product.domain.Product" %>
<%@ page import="com.iloosen.imall.module.product.domain.json.ProductImageValue" %>
<%@ page import="com.iloosen.imall.solr.client.IndexBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://127.0.0.1:3306/jvan3";
    String user = "root";
    String password = "";
    Connection conn = null;
    ResultSet rs = null;
    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);
        if(!conn.isClosed())
            System.out.println("Succeeded connecting to the Database!");
        Statement statement = conn.createStatement();
        String sql = "select * from product";
        rs = statement.executeQuery(sql);
        int num = 1;
        while(rs.next()) {
            List<Product> productList =ServiceManager.productService.findByKey(IProduct.PRODUCT_CODING,rs.getString("product_no"));
            if(productList.size()==0){
                System.out.println("没有商品记录");
                System.out.println("-----------------------------------");
                continue;
            }
            Product product = productList.get(0);
            if(StringUtils.isBlank(product.getProductDescrStr())){
                product.setProductDescrStr(rs.getString("DESCRIPTION"));
                ServiceManager.productService.update(product);
            }
            //保存商品图片到本地
            List<ProductImageValue.ImageValueEntry> images = new ArrayList<ProductImageValue.ImageValueEntry>();
            String smallPic = rs.getString("BASE_PICTURE");
            String pic1 = ServiceManager.sysFileLibService.saveNetworkFileByJvan("http://www.safemall.com/" + smallPic, 1003,product.getSysOrgId());
            //获取本地图片id和productid关联
            ProductImageValue.ImageValueEntry imageValueEntry1 =new ProductImageValue.ImageValueEntry();
            SysFileLib sysFile1=ServiceManager.sysFileLibService.getByStringId(pic1);
            imageValueEntry1.setSysFileId(sysFile1.getSysFileId());
            imageValueEntry1.setSysFileUrl(sysFile1.getSysFileId());
            images.add(imageValueEntry1);
            //搜索相关图片集
            String secondSql = "select * from templateblobfield where product_id='"+rs.getString("product_id")+"'";
            Statement statement2 = conn.createStatement();
            ResultSet  rs2 = statement2.executeQuery(secondSql);
            while (rs2.next()){
                String otherPicField = rs2.getString("field_basevalue").replace('\\','/');
                String otherPic = ServiceManager.sysFileLibService.saveNetworkFileByJvan("http://www.safemall.com/" + otherPicField, 1003,product.getSysOrgId());
                ProductImageValue.ImageValueEntry otherPicValueEntry =new ProductImageValue.ImageValueEntry();
                SysFileLib otherPicFile=ServiceManager.sysFileLibService.getByStringId(otherPic);
                otherPicValueEntry.setSysFileId(otherPicFile.getSysFileId());
                otherPicValueEntry.setSysFileUrl(otherPicFile.getSysFileId());
                images.add(otherPicValueEntry);
                System.out.println("其他图片路径：http://www.safemall.com/"+otherPic);
            }
            rs2.close();
            statement2.close();

            //找出productId关联图片
            Integer productId=ServiceManager.productService.findByKey(IProduct.PRODUCT_CODING,rs.getString("product_no")).get(0).getProductId();
            ProductImageValue productImageValue = new ProductImageValue();
            productImageValue.setImageValueEntryList(images);
            productImageValue.setObjectId(productId);
            ServiceManager.objectEnginService.saveObject(ObjectEngineTypeCodeEnum.PRODUCT_IMAGES, productId, productImageValue);
            IndexBuilder.commit(productId, ServiceManager.productIndexProvider, SysIndexObjectTypeCodeEnum.PRODUCT);
            System.out.println("图片ID：" + productId);
            System.out.println("路径：http://www.safemall.com/"+pic1);
            System.out.println("已经成功上传"+(num++)+"个商品,共有862个");
            System.out.println("--------------------------------------------------------------");
        }
        rs.close();
        conn.close();
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
</html>