
[sym-randombg]

<script>
function randomOneIn(sth) {
    return sth[Math.floor(Math.random()*sth.length)];
}
var linkGettingList = '{.!BgFolder.}?tpl=list&folders-filter=\\&recursive';
function requestimage() {
var xhr1 = new XMLHttpRequest();
xhr1.open('get', linkGettingList);
xhr1.onreadystatechange = function () {
    if (xhr1.readyState === 4) {
        var lines = xhr1.responseText;
        if (xhr1.status == 429) {
            console.log('Network busy (429). Retrying in few seconds...');
            setTimeout(e => requestimage(), 1000);
            return;
        }
        var bgImgLocs = lines.split('\n');
        var selectedImage = randomOneIn(bgImgLocs);
        console.log("Selected image for bg: \n" + selectedImage);
        bg.style.backgroundImage = "url("+selectedImage+")";
    }
}
xhr1.send();
}
requestimage();
</script>
