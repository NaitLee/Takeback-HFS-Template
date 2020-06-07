
[sym-slideshow]
<script>
// Slideshow: Script
function _slideshow (timeout, switchtime) {
    var num=0;
    var self = this;
    slideshow1.innerHTML += '<img class="slidepic" />';
    slideshow2.innerHTML += '<img class="slidepic" />';
    slideshow1.children[0].src = filestatics.picturelist[num++];
    slideshow2.children[0].src = filestatics.picturelist[num++];
    requestFullScreen(document.documentElement);
    $('table#files').slideUp(); // Hide file list to hide scroll bar
    previewfile('?close');
    $('#slideshow').fadeIn();
    this.switchslide = function () {
        if (num >= filestatics.picturelist.length) num = 0;
        $('#slideblackside').show();
        $('#slideshow0').show();
        slideshow0.innerHTML = slideshow1.innerHTML;
        slideshow1.innerHTML = slideshow2.innerHTML;
        $('#slideblackside').fadeOut(switchtime);
        $('#slideshow0').fadeOut(switchtime)
        setTimeout(function() {
            slideshow2.innerHTML = slideshow0.innerHTML;
            slideshow2.children[0].src = filestatics.picturelist[num++];
        }, switchtime);
    }
    var switchtimeout = 0;
    var switchinterval = 0;
    this.start = function () {
        clearTimeout(switchtimeout);
        switchinterval = setInterval(function () {
            switchtimeout = setTimeout(self.switchslide, timeout);
        }, timeout);
        setTimeout(self.switchslide, timeout);
        slideshowctrl.onclick = function (event) {
            self.switchslide();
            clearTimeout(switchtimeout);
        }
        slideshowctrl.oncontextmenu = function (event) {
            event.preventDefault();
            self.stop();
        }
    }
    this.stop = function () {
        $('#slideshow').fadeOut();
        $('table#files').slideDown();
        clearTimeout(switchtimeout);
        clearInterval(switchinterval);
        exitFullScreen(document);
    }
}
// Slideshow: Shell function
function slideshow (ctrl) {
    switch (ctrl) {
        case '?start':
            notice('{.!Tap screen for next, rightclick/longpress to exit.}', '{.!Slideshow will start after 3 seconds.}');
            setTimeout(function () {
                if (typeof window.show) window.show = new _slideshow(5000, 1000);
                show.start();
            }, 3200);
            break;
        case '?next':
            show.switchslide(); break;
        case '?stop':
            show.stop(); break;
            // window.show = null;
        default:
            throw "Ctrl Error: Unknown ctrl type '"+ctrl+"' at slideshow()";
    }
}
</script>
