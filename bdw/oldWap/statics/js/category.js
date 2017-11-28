$('.panel').on('hidden.bs.collapse', function () {
    var  dow 	= 'glyphicon  glyphicon-chevron-down pull-right';
        var targ	= this.childNodes[1].childNodes[1].children[1];
        targ.className = dow;
})
$('.panel').on('shown.bs.collapse', function () {
    var  up	= 'glyphicon glyphicon-chevron-up  pull-right';
    var targ	= this.childNodes[1].childNodes[1].children[1];
    targ.className = up;
})