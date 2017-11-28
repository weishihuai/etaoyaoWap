/**
 * 基于Tiny-Alert框架封装的方法
 * 属性与默认值
     // 内容
     content: '加载中...',
     // 图标样式：load/ok/alert
     title: 'load',
     // 宽度
     width: 'auto',
     // 高度
     height: 'auto',
     // 确定按钮回调函数
     ok: null,
     // 取消按钮回调函数
     cancel: null,
     // 确定按钮文字
     okText: '确定',
     // 取消按钮文字
     cancelText: '取消',
     // 自动关闭时间(毫秒)
     time: null,
     // 是否锁屏
     lock: true,
     // z-index值
     zIndex: 9999
 **/

/* 信息提示
 * @param content 显示的内容
 * @param title 图标样式：load/ok/alert
 * @param time 多长时间隐藏
 */
var breadDialog = function(content,type,time,isLock){
    $.dialog({
        content : content,
        title: type,
        time : time,
        lock: isLock
    });
};