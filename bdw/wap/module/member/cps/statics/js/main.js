(function() {
	/*百度分享js*/
	window._bd_share_config = {
		"common": {
			"bdSnsKey": {},
			"bdText": webParams.bdText,
			"bdMini": "2",
			"bdMiniList": false,
			"bdPic": webParams.bdPic,
			"bdStyle": "0",
			"bdSize": "16",
			"bdUrl":webParams.bdUrl,
			"bdDesc": webParams.bdDesc
		},
		"share": {},
		"image": {
			"viewList": ["qzone", "tsina", "sqq", "tqq", "weixin", "copy"],
			"viewText": "分享到：",
			"viewSize": "16"
		},
		"selectShare": {
			"bdContainerClass": null,
			"bdSelectMiniList": ["qzone", "tsina", "sqq", "tqq", "weixin", "copy"]
		}
	};
	with(document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
})();