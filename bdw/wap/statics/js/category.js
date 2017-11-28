function resizeFontSize() {
    var clientWidth = document.body.clientWidth;
    var x = 0;
    /*if(clientWidth >= 1024){
     x = '32px';
     }else */
    if (clientWidth <= 320) {
        x = '10px';
    } else {
        x = clientWidth * 0.03125 + 'px';
    }
    document.querySelector('html').setAttribute('style', 'font-size: ' + x + ';');
}