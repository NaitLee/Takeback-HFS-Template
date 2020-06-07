
[sym-thumbnail]
<script>
var thumbshown = false;
function showthumbnail () {
    if (thumbshown) return;
    thumbshown = true;
    var sum = filestatics.picturelist.length;
    var num = 0;
    var interval = 0;
    var numberonceshow = 5;
    var delay = 3000;
    // Reduce the server's load by delaying
    function addthumb() {
        for (var i=num; i<num+numberonceshow; i++) {
            var element = filestatics.filelistnodes[filestatics.filelist.indexOf(filestatics.picturelist[i])];
            if (element) element.innerHTML = '<img class="thumbnail" src="'+filestatics.picturelist[i]+'" />' + element.innerHTML;
        }
        if (num>=sum) { clearInterval(interval);}
        num += numberonceshow;
    }
    addthumb();
    interval = setInterval(function(){ addthumb(); }, delay);
}
if (filestatics.picturelist.length > 3 && filestatics.picturelist.length < 65) { showthumb.style.display='inline'; }
</script>
