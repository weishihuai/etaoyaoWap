/*
 *   回到顶部
 *
 * */
function goTop(Who,Speed){

    Who.click(function(){
        $('body,html').animate({scrollTop:0},Speed)
    })
}




/*
 *   鼠标经过显示，离开隐藏
 *
 * */
function onlyHover(Who){

    Who.hover(function(){

        $(this).addClass("cur");

    },function(){

        $(this).removeClass("cur");
    });
}




/*
 *   主页类左侧导航分类鼠标经过显示右侧子菜单
 *
 * */
function navShow(Nav,NavSon){

    Nav.find(NavSon).each(function() {

        $(this).hover(function () {

            $(this).addClass("cur").siblings().removeClass("cur");

        }, function () {

            $(this).removeClass("cur");

        });
    });
}
/*
 *   热销排行/最新上架 鼠标经过商品时显示商品信息
 *
 * */
function moveShow(Nav,NavSon){

    Nav.find(NavSon).each(function() {

        $(this).hover(function () {

            $(this).addClass("act").siblings().removeClass("act");

        }, function () {

            $(this).removeClass("act");

        });
    });
}



/*
 *   鼠标经过切换子区域
 *
 * */
function hoverTab(Nav,NavSon,Cont,ContSon){

    Nav.find(NavSon).each(function(i){

        $(this).hover(function(){

            $(this).addClass("cur").siblings().removeClass("cur");
            Cont.find(ContSon).siblings().removeClass("cur").eq(i).addClass("cur");

        });

    });

}




/*
 *     平移式或闪光式焦点图效果(适合区域切换)
 *
 *      indexPage   初始化 第一页
 *      xyz         x是x轴方向平移,y是y轴方向平移,z是闪光弹
 *      who         谁要偏移(ul)(获取id或class)
 *      whoSon      谁的儿子(li)(获取id或class)
 *      isPN        是否有上下页切换按钮(1是,0否,2.鼠标经过图片才显示)
 *      Prev        上一页按钮(获取id或class)
 *      Next        下一页按钮(获取id或class)
 *      isSL        是否有底部Slider(1是,0否)
 *      slider      底部Slider(获取id或class)
 *      slSon       底部Slider的儿子(获取id或class)
 *      isNUM       是否显示页码(1是,0否)
 *      nowNUM      当前页码(获取id或class)
 *      allNUM      总页码(获取id或class)
 *      onePage     一页多少个儿子
 *      OfferTo     偏移位移(px)
 *      Speed       偏移速度(1000为一秒)
 *      Auto        是否自动播放(1自动,0否)
 *      AutoSpeed   自动轮播速度(1000为一秒)(要加上偏移速度,否则重叠)
 *
 * */

function TabLT(indexPage,xyz,who,whoSon,isPN,Prev,Next,isSL,slider,slSon,isNUM,nowNUM,allNUM,onePage,OfferTo,Speed,Auto,AutoSpeed){
    var listNum = whoSon.length;//计算总儿子数
    var allPage = Math.ceil(listNum/onePage);//计算出总页数
    if(isNUM){//是否显示页码(1是,0否)
        allNUM.html(allPage);
    }

    if(Auto){//自动切换
        var AutoChange = startAutoChange();//自动切换
        whoSon.each(function(){
            $(this).hover(function(){
                clearInterval(AutoChange);
                if(isPN==2){//是否有上下页切换按钮(1是,0否,2.鼠标经过图片才显示)
                    showPN('block');
                }
            },function(){
                AutoChangeAgain();
               if(isPN==2){//是否有上下页切换按钮(1是,0否,2.鼠标经过图片才显示)
                   showPN('none');
               }
            });
        });

        if(isPN){//是否有上下页切换按钮(1是,0否,2.鼠标经过图片才显示)
            Prev.hover(function(){
                showPN('block');
                clearInterval(AutoChange);
            },function(){
                showPN('none');
                AutoChangeAgain();
            });

            Next.hover(function(){
                showPN('block');
                clearInterval(AutoChange);
            },function(){
                showPN('none');
                AutoChangeAgain();
            });
        }

        if(isSL){//是否有底部Slider(1是,0否)
            slider.find(slSon).each(function(item){
                $(this).hover(function(){
                    clearInterval(AutoChange);
                    var indexPage1 = item+1;
                    changeTo(indexPage1,OfferTo,0,xyz);
                    indexPage = indexPage1;
                },function(){
                    AutoChangeAgain();
                });
            });
        }

        function AutoChangeAgain(){
            AutoChange = startAutoChange();
        }
        //开始自动切换定时器
        function startAutoChange() {
            return setInterval(function () {
                if (indexPage < allPage) {
                    indexPage++;
                } else {
                    indexPage = 1;
                }
                changeTo(indexPage, OfferTo, Speed, xyz);
            }, AutoSpeed);
        }
        function showPN(display) {
            Prev.css("display",display);
            Next.css("display",display);
        }
    }else {//不自动切换
        if(isSL){
            slider.find(slSon).each(function(item){
                $(this).hover(function(){
                    var indexPage1 = item+1;
                    changeTo(indexPage1,OfferTo,0,xyz);
                    indexPage = indexPage1;
                });
            });
        }
    }

    //上下页切换按钮点击
    if(isPN){
        Prev.click(function(){
            indexPage = (indexPage > 1) ? (indexPage - 1) : allPage;
            changeTo(indexPage,OfferTo,0,xyz);
        });

        Next.click(function(){
            indexPage = (indexPage < allPage) ? (indexPage + 1) : 1;
            changeTo(indexPage,OfferTo,0,xyz);
        });
    }

    //跳转到指定页面
    function changeTo(indexPage,OfferTo,Speed,xyz){
        var goTL = (indexPage-1) * OfferTo;
        var Tl = xyz;
        //切换动画
        if(Tl=="x"){
            who.animate({marginLeft: "-" + goTL + "px"},Speed);
        }
        if(Tl=="y"){
            who.animate({marginTop: "-" + goTL + "px"},Speed);
        }
        if(Tl=="z"){
            whoSon.eq(indexPage-1).animate({ zIndex:'1', opacity:'1'},Speed).siblings().animate({ zIndex:'0', opacity:'0'},Speed);
        }

        if(isSL){//是否有底部Slider(1是,0否)
            slider.find(slSon).removeClass("cur").eq(indexPage-1).addClass("cur");
        }

        if(isNUM){//是否显示页码(1是,0否)
            nowNUM.html(indexPage);
        }
    }

}