$(document).ready(function(){
    var his = new History('key');
    var data = his.getList();

    if(null != data || undefined != data){
        for(var i = 0; i < data.length; i++){
            his.appendDomElement($(".history-record"), data[i].title, data[i].link);
        }
    }else{
        var emptyHistoryImgUrl = Top_Path.webRoot+"/template/bdw/wap/statics/images/no-histroy.png";
        var emptyHistoryContentHtml = '<div class="empty-sec"><div class="empty-img"><img src="' + emptyHistoryImgUrl + '" alt=""></div><p class="empty-desc">暂无搜索记录</p></div>';
        $(".history-record").append(emptyHistoryContentHtml);
    }

    document.getElementsByClassName("history-record");

    $(".backtrack").click(function(){
        window.location.href = Top_Path.webRoot+"/wap/index.ac?timestamp="+new Date().getTime();
    });

    $("#search_btn").click(function(){
        var searchValue = $.trim($("#put").val());

        if(undefined != searchValue && null != searchValue && "" != searchValue){
            var targetHref = Top_Path.webRoot+"/wap/productList.ac?keyword="+searchValue+"&category=1"+"&shopId="+Top_Path.shopId;
            window.location.href = targetHref;
            if(null != data){
                if(his.removeRepeat(data, searchValue)){
                    his.add(searchValue, targetHref, "");
                    his.removeRepeat(data, searchValue);
                }
            } else{
                his.add(searchValue, targetHref, "");
                his.removeRepeat(data, searchValue);
            }
        }else {
            window.location.href = Top_Path.webRoot+"/wap/productList.ac?category=1&shopId=" + Top_Path.shopId;
        }
    });

    $(".hot-search").find("a").click(function(){
        var target = $(this);
        if(null != data){
            if(his.removeRepeat(data, target[0].innerText)){
                his.add(target[0].innerText, target[0].href, "");
                his.appendDomElement($(".history-record"),target[0].innerText, target[0].href);
            }
        } else{
            his.add(target[0].innerText, target[0].href, "");
            his.appendDomElement($(".history-record"),target[0].innerText, target[0].href);
        }

    });

    $(".clear-history").click(function(){
        his.clearHistory();
    });
});

/*
 用户通过点击热门搜索、历史搜索中的关键字或者是在搜索框输入关键字之后点击搜索按钮都会进入到搜索结果页面。所以，我们的思路是：
 当搜索结果页面加载完毕时，将关键字和关键字对应的链接地址存起来，当搜索页重新加载时，将保存的记录显示到界面上。*/

function History(key){
    this.limit = 10;                // 限制历史记录的条数
    this.key = key || 'y_his';     // 键值
    this.jsonData = null;         //数据缓存
    this.cacheTime = 48;          // 48小时
    this.path = '/';              // cookie path
}

History.prototype = {
    constructor : History
    ,setCookie : function(name, value, expireTimeHours, options){
        options = options || {};
        var cookieString = name + '=' + encodeURIComponent(value);
        // 设置过期时间
        if(undefined != expireTimeHours){
            var date = new Date();
            date.setTime(date.getTime() + expireTimeHours * 3600 * 1000);
            cookieString = cookieString + ';expires=' + date.toUTCString();
        }

        var others = [
            options.path ? '; path=' + options.path : '',
            options.domain ? '; domain=' + options.domain : '',
            options.secure ? '; secure' : ''
        ].join('');
        // 进行写入操作
        document.cookie =  cookieString + others;
    }
    ,getCookie : function(name){
        // cookie的格式是用分号空格分割
        var arrCookie =  document.cookie ? document.cookie.split('; ') : [],
            val = '', tmpArr = '';
        for(var i=0; i< arrCookie.length; i++) {
            tmpArr = arrCookie[i].split('=');
            tmpArr[0] = tmpArr[0].replace(' ', '');  // 去掉空格
            if(tmpArr[0] == name) {
                val = decodeURIComponent(tmpArr[1]);
                break;
            }
        }
        return val.toString();
    }
    ,deleteCookie : function(name){
        this.setCookie(name, '', -1, {"path" : this.path});
    }
    // 初始化
    ,initRow : function(title, link, other){
        return '{"title":"'+ title +'", "link":"'+ link +'", "other":"'+ other +'"}';
    }
    ,parse2Json : function(jsonStr) {
        var json = [];
        try {
            json = JSON.parse(jsonStr);
        } catch(e) {
            json = eval(jsonStr);
        }
        return json;
    }
    // 添加记录
    ,add : function(title, link, other) {
        var jsonStr = this.getCookie(this.key);

        if("" != jsonStr) {
            this.jsonData = this.parse2Json(jsonStr);

            // 排重
            for(var x=0; x<this.jsonData.length; x++) {
                if(title == this.jsonData[x]['title']) {
                    return false;
                }
            }
            // 重新赋值 组装 json 字符串
            jsonStr = '[' + this.initRow(title, link, other) + ',';
            for(var i=0; i<this.limit-1; i++) {
                if(undefined != this.jsonData[i]) {
                    jsonStr += this.initRow(this.jsonData[i]['title'], this.jsonData[i]['link'], this.jsonData[i]['other']) + ',';
                } else {
                    break;
                }
            }
            jsonStr = jsonStr.substring(0, jsonStr.lastIndexOf(','));
            jsonStr += ']';

        } else {
            jsonStr = '['+ this.initRow(title, link, other) +']';
        }
        this.jsonData = this.parse2Json(jsonStr);
        this.setCookie(this.key, jsonStr, this.cacheTime, {"path" : this.path});
    }
    // 得到记录
    ,getList : function() {
        // 有缓存直接返回
        if(null != this.jsonData) {
            return this.jsonData;  // Array
        }
        // 没有缓存从 cookie 取
        var jsonStr = this.getCookie(this.key);
        if("" != jsonStr) {
            this.jsonData = this.parse2Json(jsonStr);
        }

        return this.jsonData;
    }
    // 清空历史
    ,clearHistory : function() {
        var page = this;
        xyPop({
            id: "pop_msg",
            title: "清空记录",
            content: "您确认要清空历史记录吗！",
            type: "confirm",
            padding: 15,
            btn: ["确定","取消"],
            btn2: function(){
            },
            btn1: function(){
                page.deleteCookie(page.key);
                page.jsonData = null;
                window.location.reload();
            },
            fixed: true
        });

    }
    ,appendDomElement : function(obj, title, link){
        var appendContent = "<a href="+ link + "><dd>" + title + "</dd></a>";
        obj.append(appendContent);
    }
    /**
     * 用于排除相同的搜索条件,
     * @param data 搜索中已有的数据
     * @param title 输入的内容或者热搜中的词
     * @returns {boolean}
     */
    ,removeRepeat : function(data, title){
        var flag = true;
        for(var i = 0; i < data.length; i ++){
            if(data[i].title == title){
                flag = false;
                break;
            }
        }
        return flag;
    }
};