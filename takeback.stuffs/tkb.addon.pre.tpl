
[sym-addonpre]
<script>
function _notice(content, title, timeout) {
    // When the previous notice not hidden
    $('.notice').hide();
    clearTimeout(noticetimeout);
    // Start a notice
    noticetitle.innerHTML = title;
    noticecontent.innerHTML = content;
    $('.notice').slideDown(160);
    console.log('%c\nNotice:\n'+title+'\n'+content, 'font-weight: bold;');
    var noticetimeout = setTimeout(function () { $('.notice').fadeOut(300); }, timeout ? timeout : 3200);
}    
// $('.notice').slideUp();

function notice(message, titlemessage, timeout) {
    _notice(message, titlemessage, timeout);
}

/***
 *  Fullscreen request & exit, by niewzh (CSDN Blog)
 *  requestFullScreen(document.documentElement); exitFullScreen(document);
 *  Link: https://blog.csdn.net/scaped/java/article/details/80297743
 */
function requestFullScreen(element) {
    var requestMethod = element.requestFullScreen || element.webkitRequestFullScreen || element.mozRequestFullScreen || element.msRequestFullScreen;
    if (requestMethod) {
        requestMethod.call(element);
    } else if (typeof window.ActiveXObject !== "undefined") {
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) wscript.SendKeys("{F11}");
    }
}
function exitFullScreen(element) {
    var exitMethod = element.exitFullScreen || element.webkitCancelFullScreen || element.mozCancelFullScreen || element.msExitFullScreen;
    if (exitMethod) { exitMethod.call(element); }
    else if (typeof window.ActiveXObject !== "undefined") {
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) wscript.SendKeys("{F11}");
    }
}


// Preparition: Query all file links on the page
// Many functions will use them
function spliturllast(url, indexnegative) {
    // 'http://example.net/folder/file.txt' -> 'file.txt'
    var urlparts = url.split('/');
    if (!indexnegative) indexnegative = 1;
    return urlparts[urlparts.length-indexnegative];
}
// Show current folder in preview title
previewtip.innerHTML = decodeURI(spliturllast(window.location.href, 2)+'/');
function _filestatics () {
    this.filelistnodes = document.querySelectorAll('td.file a');
    this.filelist = [];
    this.musiclist = [];
    this.picturelist = [];
}
var filestatics = new _filestatics();

filestatics.filelistnodes.forEach(function(filelistnode, index) {
    var url = filelistnode.href     // spliturllast(filelistnode.href);
    filestatics.filelist.push(url);
    // Prevent browser from directly downloading a file on click, and preview
    filelistnode.onclick = function(event) {
        event.preventDefault();
        previewfile('?open', this.href);
    }
    if (['.mp3', '.wav', '.ogg'].indexOf(url.slice(-4).toLowerCase()) != -1) {
        filestatics.musiclist.push(url);
    } else if (['.png', '.jpg', 'jpeg', '.gif', 'webp'].indexOf(url.slice(-4).toLowerCase()) != -1) {
        filestatics.picturelist.push(url);
    }
});
</script>
